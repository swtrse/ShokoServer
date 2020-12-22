﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using NLog;
using Shoko.Commons.Extensions;
using Shoko.Models.Enums;
using Shoko.Models.Server;
using Shoko.Models.TvDB;
using Shoko.Server.Commands;
using Shoko.Server.Extensions;
using Shoko.Server.Models;
using Shoko.Server.Repositories;
using Shoko.Server.Server;
using Shoko.Server.Settings;
using Shoko.Server.Utilities;
using TvDbSharper;
using TvDbSharper.Dto;
using Language = TvDbSharper.Dto.Language;

namespace Shoko.Server.Providers.TvDB
{
    public static class TvDBApiHelper
    {
        private static readonly ITvDbClient client;
        private static readonly Logger logger = LogManager.GetCurrentClassLogger();

        static TvDBApiHelper()
        {
            client = new TvDbClient();
            client.BaseUrl = "https://api-beta.thetvdb.com";
        }


        public static string CurrentServerTime
        {
            get
            {
                DateTime epoch = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Local);
                TimeSpan span = DateTime.Now - epoch;
                return ((long)span.TotalSeconds).ToString(CultureInfo.InvariantCulture);
            }
        }

        private static async Task CheckAuthorizationAsync()
        {
            try
            {
                client.AcceptedLanguage = ServerSettings.Instance.TvDB.Language;
                if (string.IsNullOrEmpty(client.Authentication.Token))
                {
                    TvDBRateLimiter.Instance.EnsureRate();
                    await client.Authentication.AuthenticateAsync(Constants.TvDB.apiKey);
                    if (string.IsNullOrEmpty(client.Authentication.Token))
                        throw new TvDbServerException("Authentication Failed", 200);
                }
            }
            catch (Exception e)
            {
                logger.Error(e, $"Error in TvDBAuth: {e}");
                Analytics.PostEvent("TvDB", "Login Failed");
                throw;
            }
        }

        public static TvDB_Series GetSeriesInfoOnline(int seriesID, bool forceRefresh)
        {
            return GetSeriesInfoOnlineAsync(seriesID, forceRefresh).Result;
        }

        public static async Task<TvDB_Series> GetSeriesInfoOnlineAsync(int seriesID, bool forceRefresh)
        {
            try
            {
                TvDB_Series tvSeries = RepoFactory.TvDB_Series.GetByTvDBID(seriesID);
                if (tvSeries != null && !forceRefresh)
                    return tvSeries;
                await CheckAuthorizationAsync();

                TvDBRateLimiter.Instance.EnsureRate();
                var response = await client.Series.GetAsync(seriesID);
                Series series = response.Data;

                tvSeries = tvSeries ?? new TvDB_Series();

                tvSeries.PopulateFromSeriesInfo(series);
                RepoFactory.TvDB_Series.Save(tvSeries);

                return tvSeries;
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetSeriesInfoOnlineAsync(seriesID, forceRefresh);
                    Analytics.PostEvent("TvDB", "Login Failed", "Tried to Get Series Without Login");
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound)
                {
                    Analytics.PostEvent("TvDB", "404: GetSeriesInfo", $"{seriesID}");
                    return null;
                }

                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TvDBApiHelper.GetSeriesInfoOnline: {ex}");
                Analytics.PostException(ex);
            }

            return null;
        }

        public static List<TVDB_Series_Search_Response> SearchSeries(string criteria)
        {
            return Task.Run(async () => await SearchSeriesAsync(criteria)).Result;
        }

        public static async Task<List<TVDB_Series_Search_Response>> SearchSeriesAsync(string criteria)
        {
            List<TVDB_Series_Search_Response> results = new List<TVDB_Series_Search_Response>();

            try
            {
                await CheckAuthorizationAsync();

                // Search for a series
                logger.Trace($"Search TvDB Series: {criteria}");

                TvDBRateLimiter.Instance.EnsureRate();
                var response = await client.Search.SearchSeriesByNameAsync(criteria);
                SeriesSearchResult[] series = response?.Data;
                if (series == null) return results;

                foreach (SeriesSearchResult item in series)
                {
                    TVDB_Series_Search_Response searchResult = new TVDB_Series_Search_Response();
                    searchResult.Populate(item);
                    results.Add(searchResult);
                }
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await SearchSeriesAsync(criteria);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return results;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}\n        when searching for {criteria}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in SearchSeries: {ex}");
                Analytics.PostException(ex);
            }

            return results;
        }

        public static void LinkAniDBTvDB(int animeID, int tvDBID, bool additiveLink = false)
        {
            if (!additiveLink)
            {
                // remove all current links
                logger.Info($"Removing All TvDB Links for: {animeID}");
                RemoveAllAniDBTvDBLinks(animeID, false);
            }

            // check if we have this information locally
            // if not download it now
            TvDB_Series tvSeries = RepoFactory.TvDB_Series.GetByTvDBID(tvDBID);

            if (tvSeries != null)
            {
                // download and update series info, episode info and episode images
                // will also download fanart, posters and wide banners
                CommandRequest_TvDBUpdateSeries cmdSeriesEps =
                    new CommandRequest_TvDBUpdateSeries(tvDBID,
                        false);
                cmdSeriesEps.Save();
            }
            else
            {
                var unused = GetSeriesInfoOnlineAsync(tvDBID, true).Result;
            }

            CrossRef_AniDB_TvDB xref = RepoFactory.CrossRef_AniDB_TvDB.GetByAniDBAndTvDBID(animeID, tvDBID) ??
                                       new CrossRef_AniDB_TvDB();

            xref.AniDBID = animeID;

            xref.TvDBID = tvDBID;

            xref.CrossRefSource = CrossRefSource.User;

            RepoFactory.CrossRef_AniDB_TvDB.Save(xref);

            logger.Info(
                $"Adding TvDB Link: AniDB(ID:{animeID}) -> TvDB(ID:{tvDBID})");

            if (ServerSettings.Instance.TraktTv.Enabled && !string.IsNullOrEmpty(ServerSettings.Instance.TraktTv.AuthToken))
            {
                // check for Trakt associations
                List<CrossRef_AniDB_TraktV2> trakt = RepoFactory.CrossRef_AniDB_TraktV2.GetByAnimeID(animeID);
                if (trakt.Count != 0)
                    foreach (CrossRef_AniDB_TraktV2 a in trakt)
                        RepoFactory.CrossRef_AniDB_TraktV2.Delete(a);

                var cmd2 = new CommandRequest_TraktSearchAnime(animeID, false);
                cmd2.Save();
            }
        }

        public static void RemoveAllAniDBTvDBLinks(int animeID, bool updateStats = true)
        {
            // check for Trakt associations
            List<CrossRef_AniDB_TraktV2> trakt = RepoFactory.CrossRef_AniDB_TraktV2.GetByAnimeID(animeID);
            if (trakt.Count != 0)
                foreach (CrossRef_AniDB_TraktV2 a in trakt)
                    RepoFactory.CrossRef_AniDB_TraktV2.Delete(a);

            List<CrossRef_AniDB_TvDB> xrefs = RepoFactory.CrossRef_AniDB_TvDB.GetByAnimeID(animeID);
            if (xrefs == null || xrefs.Count == 0) return;

            foreach (CrossRef_AniDB_TvDB xref in xrefs)
            {
                RepoFactory.CrossRef_AniDB_TvDB.Delete(xref);
            }

            if (updateStats) SVR_AniDB_Anime.UpdateStatsByAnimeID(animeID);
        }

        public static List<TvDB_Language> GetLanguages()
        {
            return Task.Run(async () => await GetLanguagesAsync()).Result;
        }

        public static async Task<List<TvDB_Language>> GetLanguagesAsync()
        {
            List<TvDB_Language> languages = new List<TvDB_Language>();

            try
            {
                await CheckAuthorizationAsync();

                TvDBRateLimiter.Instance.EnsureRate();
                var response = await client.Languages.GetAllAsync();
                Language[] apiLanguages = response.Data;

                if (apiLanguages.Length <= 0)
                    return languages;

                foreach (Language item in apiLanguages)
                {
                    TvDB_Language lan = new TvDB_Language
                    {
                        Id = item.Id,
                        EnglishName = item.EnglishName,
                        Name = item.Name,
                        Abbreviation = item.Abbreviation
                    };
                    languages.Add(lan);
                }
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetLanguagesAsync();
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return languages;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TVDBHelper.GetSeriesBannersOnline: {ex}");
                Analytics.PostException(ex);
            }

            return languages;
        }

        public static void DownloadAutomaticImages(int seriesID, bool forceDownload)
        {
            ImagesSummary summary = GetSeriesImagesCounts(seriesID);
            if (summary == null) return;
            if (summary.Fanart > 0 && ServerSettings.Instance.TvDB.AutoFanart) DownloadAutomaticImages(GetFanartOnline(seriesID), seriesID, forceDownload);
            if (summary.Poster > 0 || summary.Season > 0 && ServerSettings.Instance.TvDB.AutoPosters)
                DownloadAutomaticImages(GetPosterOnline(seriesID), seriesID, forceDownload);
        }

        static ImagesSummary GetSeriesImagesCounts(int seriesID)
        {
            return Task.Run(async () => await GetSeriesImagesCountsAsync(seriesID)).Result;
        }

        static async Task<ImagesSummary> GetSeriesImagesCountsAsync(int seriesID)
        {
            try
            {
                await CheckAuthorizationAsync();

                TvDBRateLimiter.Instance.EnsureRate();
                var response = await client.Series.GetImagesSummaryAsync(seriesID);
                return response.Data;
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetSeriesImagesCountsAsync(seriesID);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return null;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            return null;
        }

        static async Task<Image[]> GetSeriesImagesAsync(int seriesID, KeyType type)
        {
            await CheckAuthorizationAsync();

            ImagesQuery query = new ImagesQuery
            {
                KeyType = type
            };
            TvDBRateLimiter.Instance.EnsureRate();
            try
            {
                var response = await client.Series.GetImagesAsync(seriesID, query);
                return response.Data;
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetSeriesImagesAsync(seriesID, type);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return new Image[] { };
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch
            {
                // ignore
            }
            return new Image[] { };
        }

        public static List<TvDB_ImageFanart> GetFanartOnline(int seriesID)
        {
            return Task.Run(async () => await GetFanartOnlineAsync(seriesID)).Result;
        }

        public static async Task<List<TvDB_ImageFanart>> GetFanartOnlineAsync(int seriesID)
        {
            List<int> validIDs = new List<int>();
            List<TvDB_ImageFanart> tvImages = new List<TvDB_ImageFanart>();
            try
            {
                Image[] images = await GetSeriesImagesAsync(seriesID, KeyType.Fanart);

                int count = 0;
                foreach (Image image in images)
                {
                    int id = image.Id;
                    if (id == 0) continue;

                    if (count >= ServerSettings.Instance.TvDB.AutoFanartAmount) break;
                    TvDB_ImageFanart img = RepoFactory.TvDB_ImageFanart.GetByTvDBID(id) ?? new TvDB_ImageFanart
                    {
                        Enabled = 1
                    };

                    img.Populate(seriesID, image);
                    img.Language = client.AcceptedLanguage;
                    RepoFactory.TvDB_ImageFanart.Save(img);
                    tvImages.Add(img);
                    validIDs.Add(id);
                    count++;
                }

                // delete any images from the database which are no longer valid
                foreach (TvDB_ImageFanart img in RepoFactory.TvDB_ImageFanart.GetBySeriesID(seriesID))
                    if (!validIDs.Contains(img.Id))
                        RepoFactory.TvDB_ImageFanart.Delete(img);
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetFanartOnlineAsync(seriesID);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return tvImages;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TVDBApiHelper.GetSeriesFanartOnlineAsync: {ex}");
                Analytics.PostException(ex);
            }

            return tvImages;
        }

        public static List<TvDB_ImagePoster> GetPosterOnline(int seriesID)
        {
            return Task.Run(async () => await GetPosterOnlineAsync(seriesID)).Result;
        }

        public static async Task<List<TvDB_ImagePoster>> GetPosterOnlineAsync(int seriesID)
        {
            List<int> validIDs = new List<int>();
            List<TvDB_ImagePoster> tvImages = new List<TvDB_ImagePoster>();

            try
            {
                Image[] posters = await GetSeriesImagesAsync(seriesID, KeyType.Poster);
                Image[] season = await GetSeriesImagesAsync(seriesID, KeyType.Season);

                Image[] images = posters.Concat(season).ToArray();

                int count = 0;
                foreach (Image image in images)
                {
                    int id = image.Id;
                    if (id == 0) continue;

                    if (count >= ServerSettings.Instance.TvDB.AutoPostersAmount) break;
                    TvDB_ImagePoster img = RepoFactory.TvDB_ImagePoster.GetByTvDBID(id) ?? new TvDB_ImagePoster
                    {
                        Enabled = 1
                    };

                    img.Populate(seriesID, image);
                    img.Language = client.AcceptedLanguage;
                    RepoFactory.TvDB_ImagePoster.Save(img);
                    validIDs.Add(id);
                    tvImages.Add(img);
                    count++;
                }

                // delete any images from the database which are no longer valid
                foreach (TvDB_ImagePoster img in RepoFactory.TvDB_ImagePoster.GetBySeriesID(seriesID))
                    if (!validIDs.Contains(img.Id))
                        RepoFactory.TvDB_ImagePoster.Delete(img.TvDB_ImagePosterID);
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetPosterOnlineAsync(seriesID);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return tvImages;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TVDBApiHelper.GetPosterOnlineAsync: {ex}");
                Analytics.PostException(ex);
            }

            return tvImages;
        }

        public static List<TvDB_ImageWideBanner> GetBannerOnline(int seriesID)
        {
            return Task.Run(async () => await GetBannerOnlineAsync(seriesID)).Result;
        }

        public static async Task<List<TvDB_ImageWideBanner>> GetBannerOnlineAsync(int seriesID)
        {
            List<int> validIDs = new List<int>();
            List<TvDB_ImageWideBanner> tvImages = new List<TvDB_ImageWideBanner>();

            try
            {
                Image[] season = await GetSeriesImagesAsync(seriesID, KeyType.Seasonwide);
                Image[] series = await GetSeriesImagesAsync(seriesID, KeyType.Series);

                Image[] images = season.Concat(series).ToArray();

                int count = 0;
                foreach (Image image in images)
                {
                    int id = image.Id;
                    if (id == 0) continue;

                    if (count >= ServerSettings.Instance.TvDB.AutoWideBannersAmount) break;
                    TvDB_ImageWideBanner img = RepoFactory.TvDB_ImageWideBanner.GetByTvDBID(id) ?? new TvDB_ImageWideBanner
                    {
                        Enabled = 1
                    };

                    img.Populate(seriesID, image);
                    img.Language = client.AcceptedLanguage;
                    RepoFactory.TvDB_ImageWideBanner.Save(img);
                    validIDs.Add(id);
                    tvImages.Add(img);
                    count++;
                }

                // delete any images from the database which are no longer valid
                foreach (TvDB_ImageWideBanner img in RepoFactory.TvDB_ImageWideBanner.GetBySeriesID(seriesID))
                    if (!validIDs.Contains(img.Id))
                        RepoFactory.TvDB_ImageWideBanner.Delete(img.TvDB_ImageWideBannerID);
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetBannerOnlineAsync(seriesID);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return tvImages;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TVDBApiHelper.GetPosterOnlineAsync: {ex}");
                Analytics.PostException(ex);
            }

            return tvImages;
        }

        public static void DownloadAutomaticImages(List<TvDB_ImageFanart> images, int seriesID, bool forceDownload)
        {
            // find out how many images we already have locally
            int imageCount = RepoFactory.TvDB_ImageFanart.GetBySeriesID(seriesID).Count(fanart =>
                !string.IsNullOrEmpty(fanart.GetFullImagePath()) && File.Exists(fanart.GetFullImagePath()));

            foreach (TvDB_ImageFanart img in images)
                if (ServerSettings.Instance.TvDB.AutoFanart && imageCount < ServerSettings.Instance.TvDB.AutoFanartAmount &&
                    !string.IsNullOrEmpty(img.GetFullImagePath()))
                {
                    bool fileExists = File.Exists(img.GetFullImagePath());
                    if (fileExists && !forceDownload) continue;
                    CommandRequest_DownloadImage cmd = new CommandRequest_DownloadImage(img.TvDB_ImageFanartID,
                        ImageEntityType.TvDB_FanArt, forceDownload);
                    cmd.Save();
                    imageCount++;
                }
                else
                {
                    //The TvDB_AutoFanartAmount point to download less images than its available
                    // we should clean those image that we didn't download because those dont exists in local repo
                    // first we check if file was downloaded
                    if (string.IsNullOrEmpty(img.GetFullImagePath()) || !File.Exists(img.GetFullImagePath()))
                        RepoFactory.TvDB_ImageFanart.Delete(img.TvDB_ImageFanartID);
                }
        }

        public static void DownloadAutomaticImages(List<TvDB_ImagePoster> images, int seriesID, bool forceDownload)
        {
            // find out how many images we already have locally
            int imageCount = RepoFactory.TvDB_ImagePoster.GetBySeriesID(seriesID).Count(fanart =>
                !string.IsNullOrEmpty(fanart.GetFullImagePath()) && File.Exists(fanart.GetFullImagePath()));

            foreach (TvDB_ImagePoster img in images)
                if (ServerSettings.Instance.TvDB.AutoPosters && imageCount < ServerSettings.Instance.TvDB.AutoPostersAmount &&
                    !string.IsNullOrEmpty(img.GetFullImagePath()))
                {
                    bool fileExists = File.Exists(img.GetFullImagePath());
                    if (fileExists && !forceDownload) continue;
                    CommandRequest_DownloadImage cmd = new CommandRequest_DownloadImage(img.TvDB_ImagePosterID,
                        ImageEntityType.TvDB_Cover, forceDownload);
                    cmd.Save();
                    imageCount++;
                }
                else
                {
                    //The TvDB_AutoFanartAmount point to download less images than its available
                    // we should clean those image that we didn't download because those dont exists in local repo
                    // first we check if file was downloaded
                    if (string.IsNullOrEmpty(img.GetFullImagePath()) || !File.Exists(img.GetFullImagePath()))
                        RepoFactory.TvDB_ImagePoster.Delete(img);
                }
        }

        public static List<EpisodeRecord> GetEpisodesOnline(int seriesID)
        {
            return Task.Run(async () => await GetEpisodesOnlineAsync(seriesID)).Result;
        }

        static async Task<List<EpisodeRecord>> GetEpisodesOnlineAsync(int seriesID)
        {
            List<EpisodeRecord> apiEpisodes = new List<EpisodeRecord>();
            try
            {
                await CheckAuthorizationAsync();

                var tasks = new List<Task<TvDbResponse<EpisodeRecord[]>>>();
                TvDBRateLimiter.Instance.EnsureRate();
                var firstResponse = await client.Series.GetEpisodesAsync(seriesID, 1);
                logger.Trace("First Page: First: " + (firstResponse?.Links?.First?.ToString() ?? "NULL") + "Next: " + (firstResponse?.Links?.Next?.ToString() ?? "NULL") + "Previous: " + (firstResponse?.Links?.Prev?.ToString() ?? "NULL") + "Last: " + (firstResponse?.Links?.Last?.ToString() ?? "NULL"));

                for (int i = 2; i <= firstResponse.Links.Last; i++)
                {
                    logger.Trace("Adding Task: " + i);
                    TvDBRateLimiter.Instance.EnsureRate();
                    tasks.Add(client.Series.GetEpisodesAsync(seriesID, i));
                }

                var results = await Task.WhenAll(tasks);
                var lastresponse = results.Length == 0 ? firstResponse : results.Last();
                logger.Trace("Last Page: First: " + (lastresponse?.Links?.First?.ToString() ?? "NULL") + "Next: " + (lastresponse?.Links?.Next?.ToString() ?? "NULL") + "Previous: " + (lastresponse?.Links?.Prev?.ToString() ?? "NULL") + "Last: " + (lastresponse?.Links?.Last?.ToString() ?? "NULL"));
                logger.Trace("Last Count: " + (lastresponse?.Data.Length.ToString() ?? "NULL"));
                apiEpisodes = firstResponse.Data.Concat(results.SelectMany(x => x.Data)).ToList();
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetEpisodesOnlineAsync(seriesID);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound)
                {
                    Analytics.PostEvent("TvDB", "404: Get Episode List for Series", $"{seriesID}");
                    return apiEpisodes;
                }
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
                Analytics.PostException(exception);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TvDBApiHelper.GetEpisodesOnlineAsync: {ex}");
                Analytics.PostException(ex);
            }

            return apiEpisodes;
        }

        public static void UpdateSeriesInfoAndImages(int seriesID, bool forceRefresh, bool downloadImages)
        {
            try
            {
                // update the series info
                TvDB_Series tvSeries = GetSeriesInfoOnline(seriesID, forceRefresh);
                if (tvSeries == null) return;

                if (downloadImages)
                    DownloadAutomaticImages(seriesID, forceRefresh);

                List<EpisodeRecord> episodeItems = GetEpisodesOnline(seriesID);
                logger.Trace($"Found {episodeItems.Count} Episode nodes");

                List<int> existingEpIds = new List<int>();
                foreach (EpisodeRecord item in episodeItems)
                {
                    if (!existingEpIds.Contains(item.Id))
                        existingEpIds.Add(item.Id);

                    var ep = RepoFactory.TvDB_Episode.GetByTvDBID(item.Id) ?? new TvDB_Episode();
                    ep.Populate(item);
                    RepoFactory.TvDB_Episode.Save(ep);

                    if (downloadImages)
                        if (!string.IsNullOrEmpty(ep.Filename))
                        {
                            bool fileExists = File.Exists(ep.GetFullImagePath());
                            if (!fileExists || forceRefresh)
                            {
                                CommandRequest_DownloadImage cmd =
                                    new CommandRequest_DownloadImage(ep.TvDB_EpisodeID,
                                        ImageEntityType.TvDB_Episode, forceRefresh);
                                cmd.Save();
                            }
                        }
                }

                // get all the existing tvdb episodes, to see if any have been deleted
                List<TvDB_Episode> allEps = RepoFactory.TvDB_Episode.GetBySeriesID(seriesID);
                foreach (TvDB_Episode oldEp in allEps)
                    if (!existingEpIds.Contains(oldEp.Id))
                        RepoFactory.TvDB_Episode.Delete(oldEp.TvDB_EpisodeID);

                // Updating stats as it will not happen with the episodes
                RepoFactory.CrossRef_AniDB_TvDB.GetByTvDBID(seriesID).Select(a => a.AniDBID).Distinct()
                    .ForEach(SVR_AniDB_Anime.UpdateStatsByAnimeID);
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in TVDBHelper.GetEpisodes: {ex}");
                Analytics.PostException(ex);
            }
        }

        public static void LinkAniDBTvDBEpisode(int aniDBID, int tvDBID)
        {
            CrossRef_AniDB_TvDB_Episode_Override xref =
                RepoFactory.CrossRef_AniDB_TvDB_Episode_Override.GetByAniDBAndTvDBEpisodeIDs(aniDBID, tvDBID) ??
                new CrossRef_AniDB_TvDB_Episode_Override();

            xref.AniDBEpisodeID = aniDBID;
            xref.TvDBEpisodeID = tvDBID;
            RepoFactory.CrossRef_AniDB_TvDB_Episode_Override.Save(xref);

            SVR_AnimeEpisode ep = RepoFactory.AnimeEpisode.GetByAniDBEpisodeID(aniDBID);

            SVR_AniDB_Anime.UpdateStatsByAnimeID(ep.AniDB_Episode.AnimeID);
            RepoFactory.AnimeEpisode.Save(ep);

            logger.Trace($"Changed tvdb episode association: {aniDBID}");
        }

        // Removes all TVDB information from a series, bringing it back to a blank state.
        public static void RemoveLinkAniDBTvDB(int animeID, int tvDBID)
        {
            CrossRef_AniDB_TvDB xref = RepoFactory.CrossRef_AniDB_TvDB.GetByAniDBAndTvDBID(animeID, tvDBID);
            if (xref == null) return;

            RepoFactory.CrossRef_AniDB_TvDB.Delete(xref);
            RepoFactory.CrossRef_AniDB_TvDB_Episode.Delete(
                RepoFactory.CrossRef_AniDB_TvDB_Episode.GetByAnimeID(animeID));
            RepoFactory.CrossRef_AniDB_TvDB_Episode_Override.Delete(
                RepoFactory.CrossRef_AniDB_TvDB_Episode_Override.GetByAnimeID(animeID));

            SVR_AniDB_Anime.UpdateStatsByAnimeID(animeID);
        }

        public static void ScanForMatches()
        {
            if (!ServerSettings.Instance.TvDB.AutoLink) return;

            IReadOnlyList<SVR_AnimeSeries> allSeries = RepoFactory.CrossRef_AniDB_TvDB.GetSeriesWithoutLinks();

            foreach (SVR_AnimeSeries ser in allSeries)
            {
                CommandRequest_TvDBSearchAnime cmd = new CommandRequest_TvDBSearchAnime(ser.AniDB_ID, false);
                cmd.Save();
            }
        }

        public static void UpdateAllInfo(bool force)
        {
            IReadOnlyList<CrossRef_AniDB_TvDB> allCrossRefs = RepoFactory.CrossRef_AniDB_TvDB.GetAll();
            foreach (CrossRef_AniDB_TvDB xref in allCrossRefs)
            {
                CommandRequest_TvDBUpdateSeries cmd =
                    new CommandRequest_TvDBUpdateSeries(xref.TvDBID, force);
                cmd.Save();
            }
        }

        public static List<int> GetUpdatedSeriesList(long serverTime)
        {
            return GetUpdatedSeriesListAsync(serverTime).Result;
        }

        public static async Task<List<int>> GetUpdatedSeriesListAsync(long lasttimeseconds)
        {
            List<int> seriesList = new List<int>();
            try
            {
                // Unix timestamp is seconds past epoch
                DateTime lastUpdateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
                lastUpdateTime = lastUpdateTime.AddSeconds(lasttimeseconds).ToLocalTime();

                // api limits this to a week at a time, so split it up
                List<(DateTime, DateTime)> spans = new List<(DateTime, DateTime)>();
                if (lastUpdateTime.AddDays(7) < DateTime.Now)
                {
                    DateTime time = lastUpdateTime;
                    while (time < DateTime.Now)
                    {
                        var nextTime = time.AddDays(7);
                        if (nextTime > DateTime.Now) nextTime = DateTime.Now;
                        spans.Add((time, nextTime));
                        time = time.AddDays(7);
                    }
                }
                else
                {
                    spans.Add((lastUpdateTime, DateTime.Now));
                }

                int i = 1;
                int count = spans.Count;
                foreach (var span in spans)
                {
                    TvDBRateLimiter.Instance.EnsureRate();
                    // this may take a while if you don't keep shoko running, so log info
                    logger.Info($"Getting updates from TvDB, part {i} of {count}");
                    i++;
                    var response = await client.Updates.GetAsync(span.Item1, span.Item2);

                    Update[] updates = response?.Data;
                    if (updates == null) continue;

                    seriesList.AddRange(updates.Where(item => item != null).Select(item => item.Id));
                }

                return seriesList;
            }
            catch (TvDbServerException exception)
            {
                if (exception.StatusCode == (int)HttpStatusCode.Unauthorized)
                {
                    client.Authentication.Token = null;
                    await CheckAuthorizationAsync();
                    if (!string.IsNullOrEmpty(client.Authentication.Token))
                        return await GetUpdatedSeriesListAsync(lasttimeseconds);
                    // suppress 404 and move on
                }
                else if (exception.StatusCode == (int)HttpStatusCode.NotFound) return seriesList;
                logger.Error(exception,
                    $"TvDB returned an error code: {exception.StatusCode}\n        {exception.Message}");
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"Error in GetUpdatedSeriesList: {ex}");
            }
            return seriesList;
        }

        // ReSharper disable once RedundantAssignment
        public static string IncrementalTvDBUpdate(ref List<int> tvDBIDs, ref bool tvDBOnline)
        {
            // check if we have record of doing an automated update for the TvDB previously
            // if we have then we have kept a record of the server time and can do a delta update
            // otherwise we need to do a full update and keep a record of the time

            List<int> allTvDBIDs = new List<int>();
            tvDBIDs = tvDBIDs ?? new List<int>();
            tvDBOnline = true;

            try
            {
                // record the tvdb server time when we started
                // we record the time now instead of after we finish, to include any possible misses
                string currentTvDBServerTime = CurrentServerTime;
                if (currentTvDBServerTime.Length == 0)
                {
                    tvDBOnline = false;
                    return currentTvDBServerTime;
                }

                foreach (SVR_AnimeSeries ser in RepoFactory.AnimeSeries.GetAll())
                {
                    List<CrossRef_AniDB_TvDB> xrefs = ser.GetCrossRefTvDB();
                    if (xrefs == null) continue;

                    foreach (CrossRef_AniDB_TvDB xref in xrefs)
                        if (!allTvDBIDs.Contains(xref.TvDBID)) allTvDBIDs.Add(xref.TvDBID);
                }

                // get the time we last did a TvDB update
                // if this is the first time it will be null
                // update the anidb info ever 24 hours

                ScheduledUpdate sched = RepoFactory.ScheduledUpdate.GetByUpdateType((int)ScheduledUpdateType.TvDBInfo);

                string lastServerTime = string.Empty;
                if (sched != null)
                {
                    TimeSpan ts = DateTime.Now - sched.LastUpdate;
                    logger.Trace($"Last tvdb info update was {ts.TotalHours} hours ago");
                    if (!string.IsNullOrEmpty(sched.UpdateDetails))
                        lastServerTime = sched.UpdateDetails;

                    // the UpdateDetails field for this type will actually contain the last server time from
                    // TheTvDB that a full update was performed
                }


                // get a list of updates from TvDB since that time
                if (lastServerTime.Length > 0)
                {
                    if (!long.TryParse(lastServerTime, out long lasttimeseconds)) lasttimeseconds = -1;
                    if (lasttimeseconds < 0)
                    {
                        tvDBIDs = allTvDBIDs;
                        return CurrentServerTime;
                    }
                    List<int> seriesList = GetUpdatedSeriesList(lasttimeseconds);
                    logger.Trace($"{seriesList.Count} series have been updated since last download");
                    logger.Trace($"{allTvDBIDs.Count} TvDB series locally");

                    foreach (int id in seriesList)
                        if (allTvDBIDs.Contains(id)) tvDBIDs.Add(id);
                    logger.Trace($"{tvDBIDs.Count} TvDB local series have been updated since last download");
                }
                else
                {
                    // use the full list
                    tvDBIDs = allTvDBIDs;
                }

                return CurrentServerTime;
            }
            catch (Exception ex)
            {
                logger.Error(ex, $"IncrementalTvDBUpdate: {ex}");
                return string.Empty;
            }
        }
    }
}
