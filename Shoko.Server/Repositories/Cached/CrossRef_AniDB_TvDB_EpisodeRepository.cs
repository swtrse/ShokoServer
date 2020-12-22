﻿using System.Collections.Generic;
using System.Linq;
using NutzCode.InMemoryIndex;
using Shoko.Models.Enums;
using Shoko.Models.Server;
using Shoko.Server.Databases;

namespace Shoko.Server.Repositories.Cached
{
    public class CrossRef_AniDB_TvDB_EpisodeRepository : BaseCachedRepository<CrossRef_AniDB_TvDB_Episode, int>
    {
        private PocoIndex<int, CrossRef_AniDB_TvDB_Episode, int> AnimeIDs;
        private PocoIndex<int, CrossRef_AniDB_TvDB_Episode, int> EpisodeIDs;

        public override void PopulateIndexes()
        {
            AnimeIDs = new PocoIndex<int, CrossRef_AniDB_TvDB_Episode, int>(Cache,
                a => RepoFactory.AniDB_Episode.GetByEpisodeID(a.AniDBEpisodeID)?.AnimeID ?? -1);
            EpisodeIDs = new PocoIndex<int, CrossRef_AniDB_TvDB_Episode, int>(Cache, a => a.AniDBEpisodeID);
        }

        public CrossRef_AniDB_TvDB_Episode GetByAniDBAndTvDBEpisodeIDs(int anidbID, int tvdbID)
        {
            lock (Cache)
            {
                return EpisodeIDs.GetMultiple(anidbID).FirstOrDefault(a => a.TvDBEpisodeID == tvdbID);
            }
        }

        public List<CrossRef_AniDB_TvDB_Episode> GetByAniDBEpisodeID(int id)
        {
            lock (Cache)
            {
                return EpisodeIDs.GetMultiple(id);
            }
        }

        public List<CrossRef_AniDB_TvDB_Episode> GetByAnimeID(int id)
        {
            lock (Cache)
            {
                return AnimeIDs.GetMultiple(id);
            }
        }

        public override void RegenerateDb()
        {
        }

        protected override int SelectKey(CrossRef_AniDB_TvDB_Episode entity)
        {
            return entity.CrossRef_AniDB_TvDB_EpisodeID;
        }

        public void DeleteAllUnverifiedLinksForAnime(int AnimeID)
        {
            lock (globalDBLock)
            {
                lock (Cache)
                {
                    using (var session = DatabaseFactory.SessionFactory.OpenSession())
                    {
                        var toRemove = GetByAnimeID(AnimeID).Where(a => a.MatchRating != MatchRating.UserVerified)
                            .ToList();
                        if (toRemove.Count <= 0) return;
                        foreach (var episode in toRemove) Cache.Remove(episode);

                        using (var transaction = session.BeginTransaction())
                        {
                            // I'm aware that this is stupid, but it's MySQL's fault
                            // see https://stackoverflow.com/questions/45494/mysql-error-1093-cant-specify-target-table-for-update-in-from-clause
                            try
                            {
                                session.CreateSQLQuery(@"SET optimizer_switch = 'derived_merge=off';").ExecuteUpdate();
                            }
                            catch
                            {
                                // ignore
                            }

                            session.CreateSQLQuery(
                                    @"DELETE FROM CrossRef_AniDB_TvDB_Episode
WHERE CrossRef_AniDB_TvDB_Episode.MatchRating != :rating AND CrossRef_AniDB_TvDB_Episode.CrossRef_AniDB_TvDB_EpisodeID IN (
  SELECT CrossRef_AniDB_TvDB_EpisodeID FROM (
    SELECT CrossRef_AniDB_TvDB_EpisodeID
    FROM CrossRef_AniDB_TvDB_Episode
    INNER JOIN AniDB_Episode ON AniDB_Episode.EpisodeID = CrossRef_AniDB_TvDB_Episode.AniDBEpisodeID
    WHERE AniDB_Episode.AnimeID = :animeid
  ) x
);")
                                .SetInt32("animeid", AnimeID).SetInt32("rating", (int)MatchRating.UserVerified)
                                .ExecuteUpdate();

                            try
                            {
                                session.CreateSQLQuery(@"SET optimizer_switch = 'derived_merge=on';").ExecuteUpdate();
                            }
                            catch
                            {
                                // ignore
                            }

                            transaction.Commit();
                        }
                    }
                }
            }
        }

        public void DeleteAllUnverifiedLinks()
        {
            lock (globalDBLock)
            {
                lock (Cache)
                {
                    using (var session = DatabaseFactory.SessionFactory.OpenSession())
                    {
                        using (var transaction = session.BeginTransaction())
                        {
                            var toRemove = GetAll().Where(a => a.MatchRating != MatchRating.UserVerified)
                                .ToList();
                            foreach (var episode in toRemove) Cache.Remove(episode);
                            session.CreateSQLQuery(
                                    "DELETE FROM CrossRef_AniDB_TvDB_Episode WHERE MatchRating != :rating;")
                                .SetInt32("rating", (int)MatchRating.UserVerified)
                                .ExecuteUpdate();
                            transaction.Commit();
                        }
                    }
                }
            }
        }
    }
}
