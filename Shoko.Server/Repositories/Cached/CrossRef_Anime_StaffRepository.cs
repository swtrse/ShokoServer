﻿using System.Collections.Generic;
using System.Linq;
using NutzCode.InMemoryIndex;
using Shoko.Commons.Properties;
using Shoko.Models.Enums;
using Shoko.Models.Server;
using Shoko.Server.Server;

namespace Shoko.Server.Repositories.Cached
{
    public class CrossRef_Anime_StaffRepository : BaseCachedRepository<CrossRef_Anime_Staff, int>
    {
        private PocoIndex<int, CrossRef_Anime_Staff, int> AnimeIDs;
        private PocoIndex<int, CrossRef_Anime_Staff, int> StaffIDs;
        private PocoIndex<int, CrossRef_Anime_Staff, int?> RoleIDs;
        private PocoIndex<int, CrossRef_Anime_Staff, StaffRoleType> RoleTypes;

        private static readonly Dictionary<string, CharacterAppearanceType> Roles =
            new Dictionary<string, CharacterAppearanceType>
            {
                {"main character in", CharacterAppearanceType.Main_Character},
                {"secondary cast in", CharacterAppearanceType.Minor_Character},
                {"appears in", CharacterAppearanceType.Background_Character},
                {"cameo appearance in", CharacterAppearanceType.Cameo},
            };

        public override void PopulateIndexes()
        {
            AnimeIDs = new PocoIndex<int, CrossRef_Anime_Staff, int>(Cache, a => a.AniDB_AnimeID);
            StaffIDs = new PocoIndex<int, CrossRef_Anime_Staff, int>(Cache, a => a.StaffID);
            RoleIDs = new PocoIndex<int, CrossRef_Anime_Staff, int?>(Cache, a => a.RoleID);
            RoleTypes = new PocoIndex<int, CrossRef_Anime_Staff, StaffRoleType>(Cache, a => (StaffRoleType)a.RoleType);
        }

        public override void RegenerateDb()
        {
            var list = Cache.Values.Where(animeStaff => animeStaff.RoleID != null && Roles.ContainsKey(animeStaff.Role))
                .ToList();
            int i = 0;
            foreach (var animeStaff in list)
            {
                animeStaff.Role = Roles[animeStaff.Role].ToString().Replace("_", " ");
                Save(animeStaff);
                i++;
                if (i % 10 == 0)
                    ServerState.Instance.ServerStartingStatus = string.Format(
                        Resources.Database_Validating, typeof(CrossRef_Anime_Staff).Name,
                        $" DbRegen - {i}/{list.Count}");
            }
        }

        protected override int SelectKey(CrossRef_Anime_Staff entity)
        {
            return entity.CrossRef_Anime_StaffID;
        }

        public List<CrossRef_Anime_Staff> GetByStaffID(int id)
        {
            lock (Cache)
            {
                return StaffIDs.GetMultiple(id);
            }
        }

        public List<CrossRef_Anime_Staff> GetByRoleID(int id)
        {
            lock (Cache)
            {
                return RoleIDs.GetMultiple(id);
            }
        }

        public List<CrossRef_Anime_Staff> GetByRoleType(StaffRoleType type)
        {
            lock (Cache)
            {
                return RoleTypes.GetMultiple(type);
            }
        }

        public List<CrossRef_Anime_Staff> GetByAnimeID(int id)
        {
            lock (Cache)
            {
                return AnimeIDs.GetMultiple(id);
            }
        }

        public List<CrossRef_Anime_Staff> GetByAnimeIDAndRoleType(int id, StaffRoleType type)
        {
            lock (Cache)
            {
                return AnimeIDs.GetMultiple(id).Where(xref => xref.RoleType == (int)type).ToList();
            }
        }

        public CrossRef_Anime_Staff GetByParts(int AnimeID, int? RoleID, int StaffID, StaffRoleType RoleType)
        {
            lock (Cache)
            {
                return AnimeIDs.GetMultiple(AnimeID).FirstOrDefault(a =>
                    a.RoleID == RoleID && a.StaffID == StaffID && a.RoleType == (int)RoleType);
            }
        }
    }
}
