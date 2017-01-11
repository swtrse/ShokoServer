﻿using Shoko.Models.Server;
using Shoko.Server.Databases;
using Shoko.Server.Repositories;
using Shoko.Server.Repositories.NHibernate;

namespace Shoko.Server.Entities
{
    public class SVR_CrossRef_AniDB_Other : CrossRef_AniDB_Other
    {
        public SVR_CrossRef_AniDB_Other()
        {
        }
        public MovieDB_Movie GetMovieDB_Movie()
        {
            using (var session = DatabaseFactory.SessionFactory.OpenSession())
            {
                return GetMovieDB_Movie(session.Wrap());
            }
        }

        public MovieDB_Movie GetMovieDB_Movie(ISessionWrapper session)
        {
            if (CrossRefType != (int) Server.CrossRefType.MovieDB)
                return null;
            return RepoFactory.MovieDb_Movie.GetByOnlineID(session, int.Parse(CrossRefID));
        }

    }
}