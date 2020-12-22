using System;
using Shoko.Models.Enums;
using Shoko.Server.Providers.AniDB.UDP.Exceptions;
using Shoko.Server.Providers.AniDB.UDP.Requests;
using Shoko.Server.Providers.AniDB.UDP.Responses;
using Void = Shoko.Server.Providers.AniDB.UDP.Responses.Void;

namespace Shoko.Server.Providers.AniDB.UDP.MyList.Requests
{
    /// <summary>
    /// Update a file in the MyList
    /// </summary>
    public class RequestUpdateEpisode : UDPBaseRequest<Void>
    {
        protected override string BaseCommand
        {
            get
            {
                string command = $"MYLISTADD aid={AnimeID}&epno={EpisodeNumber}&generic=1&state={State}";
                if (IsWatched)
                {
                    DateTime date = WatchedDate ?? DateTime.Now;
                    command += $"&viewed=1&viewdate={Commons.Utils.AniDB.GetAniDBDateAsSeconds(date)}";
                }
                else
                {
                    command += "viewed=0";
                }

                command += "&edit=1";

                return command;
            }
        }

        public int AnimeID { get; set; }

        public int EpisodeNumber { get; set; }

        public AniDBFile_State State { get; set; }

        public bool IsWatched { get; set; }
        public DateTime? WatchedDate { get; set; }

        protected override UDPBaseResponse<Void> ParseResponse(AniDBUDPReturnCode code, string receivedData)
        {
            switch (code)
            {
                case AniDBUDPReturnCode.MYLIST_ENTRY_EDITED:
                case AniDBUDPReturnCode.NO_SUCH_MYLIST_ENTRY:
                    return new UDPBaseResponse<Void> { Code = code };
            }
            throw new UnexpectedAniDBResponseException(code, receivedData);
        }

    }
}
