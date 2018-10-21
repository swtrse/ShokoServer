-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: Oct 21, 2018 at 03:30 PM
-- Server version: 10.3.10-MariaDB-1:10.3.10+maria~bionic
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shoko_legacy`
--

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime` (
  `AniDB_AnimeID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `EpisodeCount` int(11) NOT NULL,
  `AirDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Picname` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BeginYear` int(11) NOT NULL,
  `EndYear` int(11) NOT NULL,
  `AnimeType` int(11) NOT NULL,
  `MainTitle` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AllTitles` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AllTags` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EpisodeCountNormal` int(11) NOT NULL,
  `EpisodeCountSpecial` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `VoteCount` int(11) NOT NULL,
  `TempRating` int(11) NOT NULL,
  `TempVoteCount` int(11) NOT NULL,
  `AvgReviewRating` int(11) NOT NULL,
  `ReviewCount` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `DateTimeDescUpdated` datetime NOT NULL,
  `ImageEnabled` int(11) NOT NULL,
  `AwardList` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Restricted` int(11) NOT NULL,
  `AnimePlanetID` int(11) DEFAULT NULL,
  `ANNID` int(11) DEFAULT NULL,
  `AllCinemaID` int(11) DEFAULT NULL,
  `AnimeNfo` int(11) DEFAULT NULL,
  `LatestEpisodeNumber` int(11) DEFAULT NULL,
  `DisableExternalLinksFlag` int(11) NOT NULL,
  `ContractVersion` int(11) NOT NULL DEFAULT 0,
  `ContractBlob` mediumblob DEFAULT NULL,
  `ContractSize` int(11) NOT NULL DEFAULT 0,
  `Site_JP` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Site_EN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Wikipedia_ID` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `WikipediaJP_ID` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SyoboiID` int(11) DEFAULT NULL,
  `AnisonID` int(11) DEFAULT NULL,
  `CrunchyrollID` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_AnimeID`),
  UNIQUE KEY `UIX_AniDB_Anime_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_AnimeUpdate`
--

CREATE TABLE IF NOT EXISTS `AniDB_AnimeUpdate` (
  `AniDB_AnimeUpdateID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `UpdatedAt` datetime NOT NULL,
  PRIMARY KEY (`AniDB_AnimeUpdateID`),
  KEY `UIX_AniDB_AnimeUpdate` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Category`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Category` (
  `AniDB_Anime_CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `CategoryID` int(11) NOT NULL,
  `Weighting` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_Anime_CategoryID`),
  UNIQUE KEY `UIX_AniDB_Anime_Category_AnimeID_CategoryID` (`AnimeID`,`CategoryID`),
  KEY `IX_AniDB_Anime_Category_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Character`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Character` (
  `AniDB_Anime_CharacterID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `CharID` int(11) NOT NULL,
  `CharType` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `EpisodeListRaw` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_Anime_CharacterID`),
  UNIQUE KEY `UIX_AniDB_Anime_Character_AnimeID_CharID` (`AnimeID`,`CharID`),
  KEY `IX_AniDB_Anime_Character_AnimeID` (`AnimeID`),
  KEY `IX_AniDB_Anime_Character_CharID` (`CharID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_DefaultImage`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_DefaultImage` (
  `AniDB_Anime_DefaultImageID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `ImageParentID` int(11) NOT NULL,
  `ImageParentType` int(11) NOT NULL,
  `ImageType` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_Anime_DefaultImageID`),
  UNIQUE KEY `UIX_AniDB_Anime_DefaultImage_ImageType` (`AnimeID`,`ImageType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Relation`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Relation` (
  `AniDB_Anime_RelationID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `RelatedAnimeID` int(11) NOT NULL,
  `RelationType` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_Anime_RelationID`),
  UNIQUE KEY `UIX_AniDB_Anime_Relation_AnimeID_RelatedAnimeID` (`AnimeID`,`RelatedAnimeID`),
  KEY `IX_AniDB_Anime_Relation_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Review`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Review` (
  `AniDB_Anime_ReviewID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `ReviewID` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_Anime_ReviewID`),
  UNIQUE KEY `UIX_AniDB_Anime_Review_AnimeID_ReviewID` (`AnimeID`,`ReviewID`),
  KEY `IX_AniDB_Anime_Review_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Similar`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Similar` (
  `AniDB_Anime_SimilarID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `SimilarAnimeID` int(11) NOT NULL,
  `Approval` int(11) NOT NULL,
  `Total` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_Anime_SimilarID`),
  UNIQUE KEY `UIX_AniDB_Anime_Similar_AnimeID_SimilarAnimeID` (`AnimeID`,`SimilarAnimeID`),
  KEY `IX_AniDB_Anime_Similar_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Tag`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Tag` (
  `AniDB_Anime_TagID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `TagID` int(11) NOT NULL,
  `Approval` int(11) NOT NULL,
  `Weight` int(11) DEFAULT NULL,
  PRIMARY KEY (`AniDB_Anime_TagID`),
  UNIQUE KEY `UIX_AniDB_Anime_Tag_AnimeID_TagID` (`AnimeID`,`TagID`),
  KEY `IX_AniDB_Anime_Tag_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Anime_Title`
--

CREATE TABLE IF NOT EXISTS `AniDB_Anime_Title` (
  `AniDB_Anime_TitleID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `TitleType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Language` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_Anime_TitleID`),
  KEY `IX_AniDB_Anime_Title_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Category`
--

CREATE TABLE IF NOT EXISTS `AniDB_Category` (
  `AniDB_CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryID` int(11) NOT NULL,
  `ParentID` int(11) NOT NULL,
  `IsHentai` int(11) NOT NULL,
  `CategoryName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryDescription` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_CategoryID`),
  UNIQUE KEY `UIX_AniDB_Category_CategoryID` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Character`
--

CREATE TABLE IF NOT EXISTS `AniDB_Character` (
  `AniDB_CharacterID` int(11) NOT NULL AUTO_INCREMENT,
  `CharID` int(11) NOT NULL,
  `CharName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PicName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CharKanjiName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CharDescription` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatorListRaw` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`AniDB_CharacterID`),
  UNIQUE KEY `UIX_AniDB_Character_CharID` (`CharID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Character_Seiyuu`
--

CREATE TABLE IF NOT EXISTS `AniDB_Character_Seiyuu` (
  `AniDB_Character_SeiyuuID` int(11) NOT NULL AUTO_INCREMENT,
  `CharID` int(11) NOT NULL,
  `SeiyuuID` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_Character_SeiyuuID`),
  UNIQUE KEY `UIX_AniDB_Character_Seiyuu_CharID_SeiyuuID` (`CharID`,`SeiyuuID`),
  KEY `IX_AniDB_Character_Seiyuu_CharID` (`CharID`),
  KEY `IX_AniDB_Character_Seiyuu_SeiyuuID` (`SeiyuuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Episode`
--

CREATE TABLE IF NOT EXISTS `AniDB_Episode` (
  `AniDB_EpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `EpisodeID` int(11) NOT NULL,
  `AnimeID` int(11) NOT NULL,
  `LengthSeconds` int(11) NOT NULL,
  `Rating` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Votes` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `EpisodeNumber` int(11) NOT NULL,
  `EpisodeType` int(11) NOT NULL,
  `AirDate` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_EpisodeID`),
  UNIQUE KEY `UIX_AniDB_Episode_EpisodeID` (`EpisodeID`),
  KEY `IX_AniDB_Episode_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Episode_Title`
--

CREATE TABLE IF NOT EXISTS `AniDB_Episode_Title` (
  `AniDB_Episode_TitleID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDB_EpisodeID` int(11) NOT NULL,
  `Language` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_Episode_TitleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_File`
--

CREATE TABLE IF NOT EXISTS `AniDB_File` (
  `AniDB_FileID` int(11) NOT NULL AUTO_INCREMENT,
  `FileID` int(11) NOT NULL,
  `Hash` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `AnimeID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `File_Source` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `File_AudioCodec` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `File_VideoCodec` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `File_VideoResolution` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `File_FileExtension` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `File_LengthSeconds` int(11) NOT NULL,
  `File_Description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_ReleaseDate` int(11) NOT NULL,
  `Anime_GroupName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Anime_GroupNameShort` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Episode_Rating` int(11) NOT NULL,
  `Episode_Votes` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `IsWatched` int(11) NOT NULL,
  `WatchedDate` datetime DEFAULT NULL,
  `CRC` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MD5` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SHA1` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FileName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileSize` bigint(20) NOT NULL,
  `FileVersion` int(11) NOT NULL,
  `IsCensored` int(11) NOT NULL,
  `IsDeprecated` int(11) NOT NULL,
  `InternalVersion` int(11) NOT NULL,
  `IsChaptered` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`AniDB_FileID`),
  UNIQUE KEY `UIX_AniDB_File_Hash` (`Hash`),
  UNIQUE KEY `UIX_AniDB_File_FileID` (`FileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_GroupStatus`
--

CREATE TABLE IF NOT EXISTS `AniDB_GroupStatus` (
  `AniDB_GroupStatusID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `GroupName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CompletionState` int(11) NOT NULL,
  `LastEpisodeNumber` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Votes` int(11) NOT NULL,
  `EpisodeRange` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`AniDB_GroupStatusID`),
  UNIQUE KEY `UIX_AniDB_GroupStatus_AnimeID_GroupID` (`AnimeID`,`GroupID`),
  KEY `IX_AniDB_GroupStatus_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_MylistStats`
--

CREATE TABLE IF NOT EXISTS `AniDB_MylistStats` (
  `AniDB_MylistStatsID` int(11) NOT NULL AUTO_INCREMENT,
  `Animes` int(11) NOT NULL,
  `Episodes` int(11) NOT NULL,
  `Files` int(11) NOT NULL,
  `SizeOfFiles` bigint(20) NOT NULL,
  `AddedAnimes` int(11) NOT NULL,
  `AddedEpisodes` int(11) NOT NULL,
  `AddedFiles` int(11) NOT NULL,
  `AddedGroups` int(11) NOT NULL,
  `LeechPct` int(11) NOT NULL,
  `GloryPct` int(11) NOT NULL,
  `ViewedPct` int(11) NOT NULL,
  `MylistPct` int(11) NOT NULL,
  `ViewedMylistPct` int(11) NOT NULL,
  `EpisodesViewed` int(11) NOT NULL,
  `Votes` int(11) NOT NULL,
  `Reviews` int(11) NOT NULL,
  `ViewiedLength` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_MylistStatsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Recommendation`
--

CREATE TABLE IF NOT EXISTS `AniDB_Recommendation` (
  `AniDB_RecommendationID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `RecommendationType` int(11) NOT NULL,
  `RecommendationText` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_RecommendationID`),
  UNIQUE KEY `UIX_AniDB_Recommendation` (`AnimeID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_ReleaseGroup`
--

CREATE TABLE IF NOT EXISTS `AniDB_ReleaseGroup` (
  `AniDB_ReleaseGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupID` int(11) NOT NULL,
  `Rating` int(11) NOT NULL,
  `Votes` int(11) NOT NULL,
  `AnimeCount` int(11) NOT NULL,
  `FileCount` int(11) NOT NULL,
  `GroupName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GroupNameShort` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IRCChannel` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IRCServer` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Picname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`AniDB_ReleaseGroupID`),
  UNIQUE KEY `UIX_AniDB_ReleaseGroup_GroupID` (`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Review`
--

CREATE TABLE IF NOT EXISTS `AniDB_Review` (
  `AniDB_ReviewID` int(11) NOT NULL AUTO_INCREMENT,
  `ReviewID` int(11) NOT NULL,
  `AuthorID` int(11) NOT NULL,
  `RatingAnimation` int(11) NOT NULL,
  `RatingSound` int(11) NOT NULL,
  `RatingStory` int(11) NOT NULL,
  `RatingCharacter` int(11) NOT NULL,
  `RatingValue` int(11) NOT NULL,
  `RatingEnjoyment` int(11) NOT NULL,
  `ReviewText` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_ReviewID`),
  UNIQUE KEY `UIX_AniDB_Review_ReviewID` (`ReviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Seiyuu`
--

CREATE TABLE IF NOT EXISTS `AniDB_Seiyuu` (
  `AniDB_SeiyuuID` int(11) NOT NULL AUTO_INCREMENT,
  `SeiyuuID` int(11) NOT NULL,
  `SeiyuuName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PicName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`AniDB_SeiyuuID`),
  UNIQUE KEY `UIX_AniDB_Seiyuu_SeiyuuID` (`SeiyuuID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Tag`
--

CREATE TABLE IF NOT EXISTS `AniDB_Tag` (
  `AniDB_TagID` int(11) NOT NULL AUTO_INCREMENT,
  `TagID` int(11) NOT NULL,
  `Spoiler` int(11) NOT NULL,
  `LocalSpoiler` int(11) NOT NULL,
  `GlobalSpoiler` int(11) NOT NULL,
  `TagName` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TagCount` int(11) NOT NULL,
  `TagDescription` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AniDB_TagID`),
  UNIQUE KEY `UIX_AniDB_Tag_TagID` (`TagID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AniDB_Vote`
--

CREATE TABLE IF NOT EXISTS `AniDB_Vote` (
  `AniDB_VoteID` int(11) NOT NULL AUTO_INCREMENT,
  `EntityID` int(11) NOT NULL,
  `VoteValue` int(11) NOT NULL,
  `VoteType` int(11) NOT NULL,
  PRIMARY KEY (`AniDB_VoteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeCharacter`
--

CREATE TABLE IF NOT EXISTS `AnimeCharacter` (
  `CharacterID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDBID` int(11) NOT NULL,
  `Name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImagePath` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CharacterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeEpisode`
--

CREATE TABLE IF NOT EXISTS `AnimeEpisode` (
  `AnimeEpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeSeriesID` int(11) NOT NULL,
  `AniDB_EpisodeID` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `DateTimeCreated` datetime NOT NULL,
  `PlexContractVersion` int(11) NOT NULL DEFAULT 0,
  `PlexContractBlob` mediumblob DEFAULT NULL,
  `PlexContractSize` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AnimeEpisodeID`),
  UNIQUE KEY `UIX_AnimeEpisode_AniDB_EpisodeID` (`AniDB_EpisodeID`),
  KEY `IX_AnimeEpisode_AnimeSeriesID` (`AnimeSeriesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeEpisode_User`
--

CREATE TABLE IF NOT EXISTS `AnimeEpisode_User` (
  `AnimeEpisode_UserID` int(11) NOT NULL AUTO_INCREMENT,
  `JMMUserID` int(11) NOT NULL,
  `AnimeEpisodeID` int(11) NOT NULL,
  `AnimeSeriesID` int(11) NOT NULL,
  `WatchedDate` datetime DEFAULT NULL,
  `PlayedCount` int(11) NOT NULL,
  `WatchedCount` int(11) NOT NULL,
  `StoppedCount` int(11) NOT NULL,
  `ContractVersion` int(11) NOT NULL DEFAULT 0,
  `ContractBlob` mediumblob DEFAULT NULL,
  `ContractSize` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AnimeEpisode_UserID`),
  UNIQUE KEY `UIX_AnimeEpisode_User_User_EpisodeID` (`JMMUserID`,`AnimeEpisodeID`),
  KEY `IX_AnimeEpisode_User_User_AnimeSeriesID` (`JMMUserID`,`AnimeSeriesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeGroup`
--

CREATE TABLE IF NOT EXISTS `AnimeGroup` (
  `AnimeGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeGroupParentID` int(11) DEFAULT NULL,
  `GroupName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IsManuallyNamed` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `DateTimeCreated` datetime NOT NULL,
  `SortName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MissingEpisodeCount` int(11) NOT NULL,
  `MissingEpisodeCountGroups` int(11) NOT NULL,
  `OverrideDescription` int(11) NOT NULL,
  `EpisodeAddedDate` datetime DEFAULT NULL,
  `DefaultAnimeSeriesID` int(11) DEFAULT NULL,
  `ContractVersion` int(11) NOT NULL DEFAULT 0,
  `LatestEpisodeAirDate` datetime DEFAULT NULL,
  `ContractBlob` mediumblob DEFAULT NULL,
  `ContractSize` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AnimeGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeGroup_User`
--

CREATE TABLE IF NOT EXISTS `AnimeGroup_User` (
  `AnimeGroup_UserID` int(11) NOT NULL AUTO_INCREMENT,
  `JMMUserID` int(11) NOT NULL,
  `AnimeGroupID` int(11) NOT NULL,
  `IsFave` int(11) NOT NULL,
  `UnwatchedEpisodeCount` int(11) NOT NULL,
  `WatchedEpisodeCount` int(11) NOT NULL,
  `WatchedDate` datetime DEFAULT NULL,
  `PlayedCount` int(11) NOT NULL,
  `WatchedCount` int(11) NOT NULL,
  `StoppedCount` int(11) NOT NULL,
  `PlexContractVersion` int(11) NOT NULL DEFAULT 0,
  `PlexContractBlob` mediumblob DEFAULT NULL,
  `PlexContractSize` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AnimeGroup_UserID`),
  UNIQUE KEY `UIX_AnimeGroup_User_User_GroupID` (`JMMUserID`,`AnimeGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeSeries`
--

CREATE TABLE IF NOT EXISTS `AnimeSeries` (
  `AnimeSeriesID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeGroupID` int(11) NOT NULL,
  `AniDB_ID` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `DateTimeCreated` datetime NOT NULL,
  `DefaultAudioLanguage` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DefaultSubtitleLanguage` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MissingEpisodeCount` int(11) NOT NULL,
  `MissingEpisodeCountGroups` int(11) NOT NULL,
  `LatestLocalEpisodeNumber` int(11) NOT NULL,
  `EpisodeAddedDate` datetime DEFAULT NULL,
  `SeriesNameOverride` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DefaultFolder` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ContractVersion` int(11) NOT NULL DEFAULT 0,
  `LatestEpisodeAirDate` datetime DEFAULT NULL,
  `ContractBlob` mediumblob DEFAULT NULL,
  `ContractSize` int(11) NOT NULL DEFAULT 0,
  `AirsOn` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AnimeSeriesID`),
  UNIQUE KEY `UIX_AnimeSeries_AniDB_ID` (`AniDB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeSeries_User`
--

CREATE TABLE IF NOT EXISTS `AnimeSeries_User` (
  `AnimeSeries_UserID` int(11) NOT NULL AUTO_INCREMENT,
  `JMMUserID` int(11) NOT NULL,
  `AnimeSeriesID` int(11) NOT NULL,
  `UnwatchedEpisodeCount` int(11) NOT NULL,
  `WatchedEpisodeCount` int(11) NOT NULL,
  `WatchedDate` datetime DEFAULT NULL,
  `PlayedCount` int(11) NOT NULL,
  `WatchedCount` int(11) NOT NULL,
  `StoppedCount` int(11) NOT NULL,
  `PlexContractVersion` int(11) NOT NULL DEFAULT 0,
  `PlexContractBlob` mediumblob DEFAULT NULL,
  `PlexContractSize` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`AnimeSeries_UserID`),
  UNIQUE KEY `UIX_AnimeSeries_User_User_SeriesID` (`JMMUserID`,`AnimeSeriesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AnimeStaff`
--

CREATE TABLE IF NOT EXISTS `AnimeStaff` (
  `StaffID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDBID` int(11) NOT NULL,
  `Name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImagePath` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AuthTokens`
--

CREATE TABLE IF NOT EXISTS `AuthTokens` (
  `AuthID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `DeviceName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`AuthID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `BookmarkedAnime`
--

CREATE TABLE IF NOT EXISTS `BookmarkedAnime` (
  `BookmarkedAnimeID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `Priority` int(11) NOT NULL,
  `Notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Downloading` int(11) NOT NULL,
  PRIMARY KEY (`BookmarkedAnimeID`),
  UNIQUE KEY `UIX_BookmarkedAnime_AnimeID` (`AnimeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CloudAccount`
--

CREATE TABLE IF NOT EXISTS `CloudAccount` (
  `CloudID` int(11) NOT NULL AUTO_INCREMENT,
  `ConnectionString` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`CloudID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CommandRequest`
--

CREATE TABLE IF NOT EXISTS `CommandRequest` (
  `CommandRequestID` int(11) NOT NULL AUTO_INCREMENT,
  `Priority` int(11) NOT NULL,
  `CommandType` int(11) NOT NULL,
  `CommandID` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CommandDetails` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  PRIMARY KEY (`CommandRequestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_MAL`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_MAL` (
  `CrossRef_AniDB_MALID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `MALID` int(11) NOT NULL,
  `MALTitle` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StartEpisodeType` int(11) NOT NULL,
  `StartEpisodeNumber` int(11) NOT NULL,
  `CrossRefSource` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_MALID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_MAL_MALID` (`MALID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_Other`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_Other` (
  `CrossRef_AniDB_OtherID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `CrossRefID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CrossRefSource` int(11) NOT NULL,
  `CrossRefType` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_OtherID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_Other` (`AnimeID`,`CrossRefID`,`CrossRefSource`,`CrossRefType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_Trakt`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_Trakt` (
  `CrossRef_AniDB_TraktID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `TraktID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TraktSeasonNumber` int(11) NOT NULL,
  `CrossRefSource` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_TraktID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_Trakt_Anime` (`AnimeID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_Trakt_Season` (`TraktID`,`TraktSeasonNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_TraktV2`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_TraktV2` (
  `CrossRef_AniDB_TraktV2ID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `AniDBStartEpisodeType` int(11) NOT NULL,
  `AniDBStartEpisodeNumber` int(11) NOT NULL,
  `TraktID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TraktSeasonNumber` int(11) NOT NULL,
  `TraktStartEpisodeNumber` int(11) NOT NULL,
  `TraktTitle` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CrossRefSource` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_TraktV2ID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_TraktV2` (`AnimeID`,`TraktSeasonNumber`,`TraktStartEpisodeNumber`,`AniDBStartEpisodeType`,`AniDBStartEpisodeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_Trakt_Episode`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_Trakt_Episode` (
  `CrossRef_AniDB_Trakt_EpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `AnimeID` int(11) NOT NULL,
  `AniDBEpisodeID` int(11) NOT NULL,
  `TraktID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Season` int(11) NOT NULL,
  `EpisodeNumber` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_Trakt_EpisodeID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_Trakt_Episode_AniDBEpisodeID` (`AniDBEpisodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_TvDB`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_TvDB` (
  `CrossRef_AniDB_TvDBID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDBID` int(11) NOT NULL,
  `TvDBID` int(11) NOT NULL,
  `CrossRefSource` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_TvDBID`),
  UNIQUE KEY `UIX_AniDB_TvDB_AniDBID_TvDBID` (`AniDBID`,`TvDBID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_TvDB_Episode`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_TvDB_Episode` (
  `CrossRef_AniDB_TvDB_EpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDBEpisodeID` int(11) NOT NULL,
  `TvDBEpisodeID` int(11) NOT NULL,
  `MatchRating` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_TvDB_EpisodeID`),
  UNIQUE KEY `UIX_CrossRef_AniDB_TvDB_Episode_AniDBID_TvDBID` (`AniDBEpisodeID`,`TvDBEpisodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_AniDB_TvDB_Episode_Override`
--

CREATE TABLE IF NOT EXISTS `CrossRef_AniDB_TvDB_Episode_Override` (
  `CrossRef_AniDB_TvDB_Episode_OverrideID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDBEpisodeID` int(11) NOT NULL,
  `TvDBEpisodeID` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_AniDB_TvDB_Episode_OverrideID`),
  UNIQUE KEY `UIX_AniDB_TvDB_Episode_Override_AniDBEpisodeID_TvDBEpisodeID` (`AniDBEpisodeID`,`TvDBEpisodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_Anime_Staff`
--

CREATE TABLE IF NOT EXISTS `CrossRef_Anime_Staff` (
  `CrossRef_Anime_StaffID` int(11) NOT NULL AUTO_INCREMENT,
  `AniDB_AnimeID` int(11) NOT NULL,
  `StaffID` int(11) NOT NULL,
  `Role` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RoleID` int(11) DEFAULT NULL,
  `RoleType` int(11) NOT NULL,
  `Language` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CrossRef_Anime_StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_CustomTag`
--

CREATE TABLE IF NOT EXISTS `CrossRef_CustomTag` (
  `CrossRef_CustomTagID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomTagID` int(11) NOT NULL,
  `CrossRefID` int(11) NOT NULL,
  `CrossRefType` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_CustomTagID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_File_Episode`
--

CREATE TABLE IF NOT EXISTS `CrossRef_File_Episode` (
  `CrossRef_File_EpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `Hash` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileSize` bigint(20) NOT NULL,
  `CrossRefSource` int(11) NOT NULL,
  `AnimeID` int(11) NOT NULL,
  `EpisodeID` int(11) NOT NULL,
  `Percentage` int(11) NOT NULL,
  `EpisodeOrder` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_File_EpisodeID`),
  UNIQUE KEY `UIX_CrossRef_File_Episode_Hash_EpisodeID` (`Hash`,`EpisodeID`),
  KEY `IX_Xref_Epid` (`EpisodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_Languages_AniDB_File`
--

CREATE TABLE IF NOT EXISTS `CrossRef_Languages_AniDB_File` (
  `CrossRef_Languages_AniDB_FileID` int(11) NOT NULL AUTO_INCREMENT,
  `FileID` int(11) NOT NULL,
  `LanguageID` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_Languages_AniDB_FileID`),
  KEY `IX_Xref_Epid` (`FileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CrossRef_Subtitles_AniDB_File`
--

CREATE TABLE IF NOT EXISTS `CrossRef_Subtitles_AniDB_File` (
  `CrossRef_Subtitles_AniDB_FileID` int(11) NOT NULL AUTO_INCREMENT,
  `FileID` int(11) NOT NULL,
  `LanguageID` int(11) NOT NULL,
  PRIMARY KEY (`CrossRef_Subtitles_AniDB_FileID`),
  KEY `IX_Xref_Sub_AniDBFile` (`FileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CustomTag`
--

CREATE TABLE IF NOT EXISTS `CustomTag` (
  `CustomTagID` int(11) NOT NULL AUTO_INCREMENT,
  `TagName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TagDescription` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CustomTagID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `CustomTag`
--

INSERT INTO `CustomTag` (`CustomTagID`, `TagName`, `TagDescription`) VALUES
(1, 'Dropped', 'Started watching this series, but have since dropped it'),
(2, 'Pinned', 'Pinned this series for whatever reason you like'),
(3, 'Ongoing', 'This series does not have an end date'),
(4, 'Waiting for Series Completion', 'Will start watching this once this series is finished'),
(5, 'Waiting for Blu-ray Completion', 'Will start watching this once all episodes are available in Blu-Ray');

-- --------------------------------------------------------

--
-- Table structure for table `DuplicateFile`
--

CREATE TABLE IF NOT EXISTS `DuplicateFile` (
  `DuplicateFileID` int(11) NOT NULL AUTO_INCREMENT,
  `FilePathFile1` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FilePathFile2` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImportFolderIDFile1` int(11) NOT NULL,
  `ImportFolderIDFile2` int(11) NOT NULL,
  `Hash` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  PRIMARY KEY (`DuplicateFileID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `FileFfdshowPreset`
--

CREATE TABLE IF NOT EXISTS `FileFfdshowPreset` (
  `FileFfdshowPresetID` int(11) NOT NULL AUTO_INCREMENT,
  `Hash` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FileSize` bigint(20) NOT NULL,
  `Preset` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`FileFfdshowPresetID`),
  UNIQUE KEY `UIX_FileFfdshowPreset_Hash` (`Hash`,`FileSize`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `FileNameHash`
--

CREATE TABLE IF NOT EXISTS `FileNameHash` (
  `FileNameHashID` int(11) NOT NULL AUTO_INCREMENT,
  `FileName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileSize` bigint(20) NOT NULL,
  `Hash` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  PRIMARY KEY (`FileNameHashID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `GroupFilter`
--

CREATE TABLE IF NOT EXISTS `GroupFilter` (
  `GroupFilterID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupFilterName` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ApplyToSeries` int(11) NOT NULL,
  `BaseCondition` int(11) NOT NULL,
  `SortingCriteria` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Locked` int(11) DEFAULT NULL,
  `FilterType` int(11) NOT NULL,
  `GroupsIdsVersion` int(11) NOT NULL DEFAULT 0,
  `GroupsIdsString` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GroupConditionsVersion` int(11) NOT NULL DEFAULT 0,
  `GroupConditions` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ParentGroupFilterID` int(11) DEFAULT NULL,
  `InvisibleInClients` int(11) NOT NULL DEFAULT 0,
  `SeriesIdsVersion` int(11) NOT NULL DEFAULT 0,
  `SeriesIdsString` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`GroupFilterID`),
  KEY `IX_groupfilter_GroupFilterName` (`GroupFilterName`(250))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `GroupFilter`
--

INSERT INTO `GroupFilter` (`GroupFilterID`, `GroupFilterName`, `ApplyToSeries`, `BaseCondition`, `SortingCriteria`, `Locked`, `FilterType`, `GroupsIdsVersion`, `GroupsIdsString`, `GroupConditionsVersion`, `GroupConditions`, `ParentGroupFilterID`, `InvisibleInClients`, `SeriesIdsVersion`, `SeriesIdsString`) VALUES
(1, 'Continue Watching (SYSTEM)', 0, 1, '4;2', 1, 2, 3, '{}', 1, '[{\"GroupFilterConditionID\":0,\"GroupFilterID\":1,\"ConditionType\":28,\"ConditionOperator\":1,\"ConditionParameter\":\"\"},{\"GroupFilterConditionID\":0,\"GroupFilterID\":1,\"ConditionType\":3,\"ConditionOperator\":1,\"ConditionParameter\":\"\"}]', NULL, 0, 2, '{}'),
(2, 'All', 0, 1, '5;1', 1, 4, 3, '{}', 1, '[]', NULL, 0, 2, '{}'),
(3, 'Tags', 0, 1, '13;1', 1, 24, 3, '{}', 1, '[]', NULL, 0, 2, '{}'),
(4, 'Years', 0, 1, '13;1', 1, 40, 3, '{}', 1, '[]', NULL, 0, 2, '{}'),
(5, 'Seasons', 0, 1, '13;1', 1, 72, 3, '{}', 1, '[]', NULL, 0, 2, '{}');

-- --------------------------------------------------------

--
-- Table structure for table `GroupFilterCondition`
--

CREATE TABLE IF NOT EXISTS `GroupFilterCondition` (
  `GroupFilterConditionID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupFilterID` int(11) NOT NULL,
  `ConditionType` int(11) NOT NULL,
  `ConditionOperator` int(11) NOT NULL,
  `ConditionParameter` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`GroupFilterConditionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `IgnoreAnime`
--

CREATE TABLE IF NOT EXISTS `IgnoreAnime` (
  `IgnoreAnimeID` int(11) NOT NULL AUTO_INCREMENT,
  `JMMUserID` int(11) NOT NULL,
  `AnimeID` int(11) NOT NULL,
  `IgnoreType` int(11) NOT NULL,
  PRIMARY KEY (`IgnoreAnimeID`),
  UNIQUE KEY `UIX_IgnoreAnime_User_AnimeID` (`JMMUserID`,`AnimeID`,`IgnoreType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ImportFolder`
--

CREATE TABLE IF NOT EXISTS `ImportFolder` (
  `ImportFolderID` int(11) NOT NULL AUTO_INCREMENT,
  `ImportFolderType` int(11) NOT NULL,
  `ImportFolderName` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImportFolderLocation` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IsDropSource` int(11) NOT NULL,
  `IsDropDestination` int(11) NOT NULL,
  `IsWatched` int(11) NOT NULL,
  `CloudID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ImportFolderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `JMMUser`
--

CREATE TABLE IF NOT EXISTS `JMMUser` (
  `JMMUserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Password` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IsAdmin` int(11) NOT NULL,
  `IsAniDBUser` int(11) NOT NULL,
  `IsTraktUser` int(11) NOT NULL,
  `HideCategories` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CanEditServerSettings` int(11) DEFAULT NULL,
  `PlexUsers` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PlexToken` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`JMMUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `JMMUser`
--

INSERT INTO `JMMUser` (`JMMUserID`, `Username`, `Password`, `IsAdmin`, `IsAniDBUser`, `IsTraktUser`, `HideCategories`, `CanEditServerSettings`, `PlexUsers`, `PlexToken`) VALUES
(1, 'Default', '', 1, 1, 1, '', 1, NULL, NULL),
(2, 'Family Friendly', '', 1, 1, 1, 'ecchi,nudity,sex,sexual abuse,horror,erotic game,incest,18 restricted', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Language`
--

CREATE TABLE IF NOT EXISTS `Language` (
  `LanguageID` int(11) NOT NULL AUTO_INCREMENT,
  `LanguageName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`LanguageID`),
  UNIQUE KEY `UIX_Language_LanguageName` (`LanguageName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `MovieDB_Fanart`
--

CREATE TABLE IF NOT EXISTS `MovieDB_Fanart` (
  `MovieDB_FanartID` int(11) NOT NULL AUTO_INCREMENT,
  `ImageID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MovieId` int(11) NOT NULL,
  `ImageType` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImageSize` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImageWidth` int(11) NOT NULL,
  `ImageHeight` int(11) NOT NULL,
  `Enabled` int(11) NOT NULL,
  PRIMARY KEY (`MovieDB_FanartID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `MovieDB_Movie`
--

CREATE TABLE IF NOT EXISTS `MovieDB_Movie` (
  `MovieDB_MovieID` int(11) NOT NULL AUTO_INCREMENT,
  `MovieId` int(11) NOT NULL,
  `MovieName` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OriginalName` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Overview` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Rating` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`MovieDB_MovieID`),
  UNIQUE KEY `UIX_MovieDB_Movie_Id` (`MovieId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `MovieDB_Poster`
--

CREATE TABLE IF NOT EXISTS `MovieDB_Poster` (
  `MovieDB_PosterID` int(11) NOT NULL AUTO_INCREMENT,
  `ImageID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MovieId` int(11) NOT NULL,
  `ImageType` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImageSize` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImageWidth` int(11) NOT NULL,
  `ImageHeight` int(11) NOT NULL,
  `Enabled` int(11) NOT NULL,
  PRIMARY KEY (`MovieDB_PosterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Playlist`
--

CREATE TABLE IF NOT EXISTS `Playlist` (
  `PlaylistID` int(11) NOT NULL AUTO_INCREMENT,
  `PlaylistName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PlaylistItems` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DefaultPlayOrder` int(11) NOT NULL,
  `PlayWatched` int(11) NOT NULL,
  `PlayUnwatched` int(11) NOT NULL,
  PRIMARY KEY (`PlaylistID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `RenameScript`
--

CREATE TABLE IF NOT EXISTS `RenameScript` (
  `RenameScriptID` int(11) NOT NULL AUTO_INCREMENT,
  `ScriptName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Script` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IsEnabledOnImport` int(11) NOT NULL,
  `RenamerType` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ExtraData` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`RenameScriptID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `RenameScript`
--

INSERT INTO `RenameScript` (`RenameScriptID`, `ScriptName`, `Script`, `IsEnabledOnImport`, `RenamerType`, `ExtraData`) VALUES
(1, 'Default', '// Sample Output: [Coalgirls]_Highschool_of_the_Dead_-_01_(1920x1080_Blu-ray_H264)_[90CC6DC1].mkv\r\n// Sub group name\r\nDO ADD \'[%grp] \'\r\n// Anime Name, use english name if it exists, otherwise use the Romaji name\r\nIF I(eng) DO ADD \'%eng \'\r\nIF I(ann);I(!eng) DO ADD \'%ann \'\r\n// Episode Number, don\'t use episode number for movies\r\nIF T(!Movie) DO ADD \'- %enr\'\r\n// If the file version is v2 or higher add it here\r\nIF F(!1) DO ADD \'v%ver\'\r\n// Video Resolution\r\nDO ADD \' (%res\'\r\n// Video Source (only if blu-ray or DVD)\r\nIF R(DVD),R(Blu-ray) DO ADD \' %src\'\r\n// Video Codec\r\nDO ADD \' %vid\'\r\n// Video Bit Depth (only if 10bit)\r\nIF Z(10) DO ADD \' %bitbit\'\r\nDO ADD \') \'\r\nDO ADD \'[%CRC]\'\r\n\r\n// Replacement rules (cleanup)\r\nDO REPLACE \' \' \'_\' // replace spaces with underscores\r\nDO REPLACE \'H264/AVC\' \'H264\'\r\nDO REPLACE \'0x0\' \'\'\r\nDO REPLACE \'__\' \'_\'\r\nDO REPLACE \'__\' \'_\'\r\n\r\n// Replace all illegal file name characters\r\nDO REPLACE \'<\' \'(\'\r\nDO REPLACE \'>\' \')\'\r\nDO REPLACE \':\' \'-\'\r\nDO REPLACE \'\"\' \'`\'\r\nDO REPLACE \'/\' \'_\'\r\nDO REPLACE \'/\' \'_\'\r\nDO REPLACE \'\\\' \'_\'\r\nDO REPLACE \'|\' \'_\'\r\nDO REPLACE \'?\' \'_\'\r\nDO REPLACE \'*\' \'_\'\r\n', 0, 'Legacy', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Scan`
--

CREATE TABLE IF NOT EXISTS `Scan` (
  `ScanID` int(11) NOT NULL AUTO_INCREMENT,
  `CreationTime` datetime NOT NULL,
  `ImportFolders` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` int(11) NOT NULL,
  PRIMARY KEY (`ScanID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ScanFile`
--

CREATE TABLE IF NOT EXISTS `ScanFile` (
  `ScanFileID` int(11) NOT NULL AUTO_INCREMENT,
  `ScanID` int(11) NOT NULL,
  `ImportFolderID` int(11) NOT NULL,
  `VideoLocal_Place_ID` int(11) NOT NULL,
  `FullName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FileSize` bigint(20) NOT NULL,
  `Status` int(11) NOT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `Hash` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HashResult` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ScanFileID`),
  KEY `UIX_ScanFileStatus` (`ScanID`,`Status`,`CheckDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ScheduledUpdate`
--

CREATE TABLE IF NOT EXISTS `ScheduledUpdate` (
  `ScheduledUpdateID` int(11) NOT NULL AUTO_INCREMENT,
  `UpdateType` int(11) NOT NULL,
  `LastUpdate` datetime NOT NULL,
  `UpdateDetails` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ScheduledUpdateID`),
  UNIQUE KEY `UIX_ScheduledUpdate_UpdateType` (`UpdateType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Trakt_Episode`
--

CREATE TABLE IF NOT EXISTS `Trakt_Episode` (
  `Trakt_EpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `Trakt_ShowID` int(11) NOT NULL,
  `Season` int(11) NOT NULL,
  `EpisodeNumber` int(11) NOT NULL,
  `Title` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Overview` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EpisodeImage` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TraktID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Trakt_EpisodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Trakt_Friend`
--

CREATE TABLE IF NOT EXISTS `Trakt_Friend` (
  `Trakt_FriendID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FullName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Gender` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Age` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `About` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Joined` int(11) NOT NULL,
  `Avatar` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LastAvatarUpdate` datetime NOT NULL,
  PRIMARY KEY (`Trakt_FriendID`),
  UNIQUE KEY `UIX_Trakt_Friend_Username` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Trakt_Season`
--

CREATE TABLE IF NOT EXISTS `Trakt_Season` (
  `Trakt_SeasonID` int(11) NOT NULL AUTO_INCREMENT,
  `Trakt_ShowID` int(11) NOT NULL,
  `Season` int(11) NOT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Trakt_SeasonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Trakt_Show`
--

CREATE TABLE IF NOT EXISTS `Trakt_Show` (
  `Trakt_ShowID` int(11) NOT NULL AUTO_INCREMENT,
  `TraktID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Year` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `URL` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Overview` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TvDB_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Trakt_ShowID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TvDB_Episode`
--

CREATE TABLE IF NOT EXISTS `TvDB_Episode` (
  `TvDB_EpisodeID` int(11) NOT NULL AUTO_INCREMENT,
  `Id` int(11) NOT NULL,
  `SeriesID` int(11) NOT NULL,
  `SeasonID` int(11) NOT NULL,
  `SeasonNumber` int(11) NOT NULL,
  `EpisodeNumber` int(11) NOT NULL,
  `EpisodeName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Overview` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Filename` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EpImgFlag` int(11) NOT NULL,
  `AbsoluteNumber` int(11) DEFAULT NULL,
  `AirsAfterSeason` int(11) DEFAULT NULL,
  `AirsBeforeEpisode` int(11) DEFAULT NULL,
  `AirsBeforeSeason` int(11) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  `AirDate` datetime DEFAULT NULL,
  PRIMARY KEY (`TvDB_EpisodeID`),
  UNIQUE KEY `UIX_TvDB_Episode_Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TvDB_ImageFanart`
--

CREATE TABLE IF NOT EXISTS `TvDB_ImageFanart` (
  `TvDB_ImageFanartID` int(11) NOT NULL AUTO_INCREMENT,
  `Id` int(11) NOT NULL,
  `SeriesID` int(11) NOT NULL,
  `BannerPath` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BannerType` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BannerType2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Colors` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Language` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ThumbnailPath` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VignettePath` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Enabled` int(11) NOT NULL,
  `Chosen` int(11) NOT NULL,
  PRIMARY KEY (`TvDB_ImageFanartID`),
  UNIQUE KEY `UIX_TvDB_ImageFanart_Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TvDB_ImagePoster`
--

CREATE TABLE IF NOT EXISTS `TvDB_ImagePoster` (
  `TvDB_ImagePosterID` int(11) NOT NULL AUTO_INCREMENT,
  `Id` int(11) NOT NULL,
  `SeriesID` int(11) NOT NULL,
  `BannerPath` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BannerType` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BannerType2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Language` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Enabled` int(11) NOT NULL,
  `SeasonNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`TvDB_ImagePosterID`),
  UNIQUE KEY `UIX_TvDB_ImagePoster_Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TvDB_ImageWideBanner`
--

CREATE TABLE IF NOT EXISTS `TvDB_ImageWideBanner` (
  `TvDB_ImageWideBannerID` int(11) NOT NULL AUTO_INCREMENT,
  `Id` int(11) NOT NULL,
  `SeriesID` int(11) NOT NULL,
  `BannerPath` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BannerType` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BannerType2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Language` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Enabled` int(11) NOT NULL,
  `SeasonNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`TvDB_ImageWideBannerID`),
  UNIQUE KEY `UIX_TvDB_ImageWideBanner_Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TvDB_Series`
--

CREATE TABLE IF NOT EXISTS `TvDB_Series` (
  `TvDB_SeriesID` int(11) NOT NULL AUTO_INCREMENT,
  `SeriesID` int(11) NOT NULL,
  `Overview` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SeriesName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Banner` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fanart` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Poster` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Lastupdated` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`TvDB_SeriesID`),
  UNIQUE KEY `UIX_TvDB_Series_Id` (`SeriesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `VideoLocal`
--

CREATE TABLE IF NOT EXISTS `VideoLocal` (
  `VideoLocalID` int(11) NOT NULL AUTO_INCREMENT,
  `Hash` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CRC32` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MD5` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SHA1` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HashSource` int(11) NOT NULL,
  `FileSize` bigint(20) NOT NULL,
  `IsIgnored` int(11) NOT NULL,
  `DateTimeUpdated` datetime NOT NULL,
  `DateTimeCreated` datetime NOT NULL,
  `IsVariation` int(11) NOT NULL,
  `MediaVersion` int(11) NOT NULL DEFAULT 0,
  `MediaBlob` mediumblob DEFAULT NULL,
  `MediaSize` int(11) NOT NULL DEFAULT 0,
  `FileName` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `VideoCodec` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `VideoBitrate` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `VideoBitDepth` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `VideoFrameRate` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `VideoResolution` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AudioCodec` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `AudioBitrate` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Duration` bigint(20) NOT NULL DEFAULT 0,
  `MyListID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`VideoLocalID`),
  KEY `IX_VideoLocal_Hash` (`Hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `VideoLocal_Place`
--

CREATE TABLE IF NOT EXISTS `VideoLocal_Place` (
  `VideoLocal_Place_ID` int(11) NOT NULL AUTO_INCREMENT,
  `VideoLocalID` int(11) NOT NULL,
  `FilePath` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImportFolderID` int(11) NOT NULL,
  `ImportFolderType` int(11) NOT NULL,
  PRIMARY KEY (`VideoLocal_Place_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `VideoLocal_User`
--

CREATE TABLE IF NOT EXISTS `VideoLocal_User` (
  `VideoLocal_UserID` int(11) NOT NULL AUTO_INCREMENT,
  `JMMUserID` int(11) NOT NULL,
  `VideoLocalID` int(11) NOT NULL,
  `WatchedDate` datetime DEFAULT NULL,
  `ResumePosition` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`VideoLocal_UserID`),
  UNIQUE KEY `UIX_VideoLocal_User_User_VideoLocalID` (`JMMUserID`,`VideoLocalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
