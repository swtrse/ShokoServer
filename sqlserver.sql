USE [shoko_legacy]
GO
/****** Object:  Table [dbo].[AniDB_Anime]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime](
	[AniDB_AnimeID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[EpisodeCount] [int] NOT NULL,
	[AirDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[URL] [varchar](max) NULL,
	[Picname] [varchar](max) NULL,
	[BeginYear] [int] NOT NULL,
	[EndYear] [int] NOT NULL,
	[AnimeType] [int] NOT NULL,
	[MainTitle] [nvarchar](500) NOT NULL,
	[AllTitles] [nvarchar](1500) NOT NULL,
	[AllTags] [nvarchar](max) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[EpisodeCountNormal] [int] NOT NULL,
	[EpisodeCountSpecial] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[VoteCount] [int] NOT NULL,
	[TempRating] [int] NOT NULL,
	[TempVoteCount] [int] NOT NULL,
	[AvgReviewRating] [int] NOT NULL,
	[ReviewCount] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[DateTimeDescUpdated] [datetime] NOT NULL,
	[ImageEnabled] [int] NOT NULL,
	[AwardList] [varchar](max) NOT NULL,
	[Restricted] [int] NOT NULL,
	[AnimePlanetID] [int] NULL,
	[ANNID] [int] NULL,
	[AllCinemaID] [int] NULL,
	[AnimeNfo] [int] NULL,
	[LatestEpisodeNumber] [int] NULL,
	[DisableExternalLinksFlag] [int] NOT NULL,
	[ContractVersion] [int] NOT NULL,
	[ContractBlob] [varbinary](max) NULL,
	[ContractSize] [int] NOT NULL,
	[Site_JP] [nvarchar](max) NULL,
	[Site_EN] [nvarchar](max) NULL,
	[Wikipedia_ID] [nvarchar](max) NULL,
	[WikipediaJP_ID] [nvarchar](max) NULL,
	[SyoboiID] [int] NULL,
	[AnisonID] [int] NULL,
	[CrunchyrollID] [nvarchar](max) NULL,
 CONSTRAINT [PK_AniDB_Anime] PRIMARY KEY CLUSTERED 
(
	[AniDB_AnimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Category]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Category](
	[AniDB_Anime_CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Weighting] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_Anime_Category] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Character]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Character]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Character](
	[AniDB_Anime_CharacterID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[CharID] [int] NOT NULL,
	[CharType] [varchar](100) NOT NULL,
	[EpisodeListRaw] [varchar](max) NULL,
 CONSTRAINT [PK_AniDB_Anime_Character] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_CharacterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_DefaultImage]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_DefaultImage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_DefaultImage](
	[AniDB_Anime_DefaultImageID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[ImageParentID] [int] NOT NULL,
	[ImageParentType] [int] NOT NULL,
	[ImageType] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_Anime_DefaultImage] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_DefaultImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Relation]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Relation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Relation](
	[AniDB_Anime_RelationID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[RelatedAnimeID] [int] NOT NULL,
	[RelationType] [varchar](100) NOT NULL,
 CONSTRAINT [PK_AniDB_Anime_Relation] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Review]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Review]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Review](
	[AniDB_Anime_ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[ReviewID] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_Anime_Review] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Similar]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Similar]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Similar](
	[AniDB_Anime_SimilarID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[SimilarAnimeID] [int] NOT NULL,
	[Approval] [int] NOT NULL,
	[Total] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_Anime_Similar] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_SimilarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Tag]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Tag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Tag](
	[AniDB_Anime_TagID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
	[Approval] [int] NOT NULL,
	[Weight] [int] NULL,
 CONSTRAINT [PK_AniDB_Anime_Tag] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Anime_Title]    Script Date: 2018-10-22 1:55:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Anime_Title]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Anime_Title](
	[AniDB_Anime_TitleID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[TitleType] [varchar](50) NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_AniDB_Anime_Title] PRIMARY KEY CLUSTERED 
(
	[AniDB_Anime_TitleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_AnimeUpdate]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_AnimeUpdate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_AnimeUpdate](
	[AniDB_AnimeUpdateID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Category]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Category](
	[AniDB_CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
	[IsHentai] [int] NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[CategoryDescription] [varchar](max) NOT NULL,
 CONSTRAINT [PK_AniDB_Category] PRIMARY KEY CLUSTERED 
(
	[AniDB_CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Character]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Character]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Character](
	[AniDB_CharacterID] [int] IDENTITY(1,1) NOT NULL,
	[CharID] [int] NOT NULL,
	[CharName] [nvarchar](max) NOT NULL,
	[PicName] [varchar](100) NOT NULL,
	[CharKanjiName] [nvarchar](max) NOT NULL,
	[CharDescription] [nvarchar](max) NOT NULL,
	[CreatorListRaw] [varchar](max) NOT NULL,
 CONSTRAINT [PK_AniDB_Character] PRIMARY KEY CLUSTERED 
(
	[AniDB_CharacterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Character_Seiyuu]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Character_Seiyuu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Character_Seiyuu](
	[AniDB_Character_SeiyuuID] [int] IDENTITY(1,1) NOT NULL,
	[CharID] [int] NOT NULL,
	[SeiyuuID] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_Character_Seiyuu] PRIMARY KEY CLUSTERED 
(
	[AniDB_Character_SeiyuuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Episode]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Episode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Episode](
	[AniDB_EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[AnimeID] [int] NOT NULL,
	[LengthSeconds] [int] NOT NULL,
	[Rating] [varchar](max) NOT NULL,
	[Votes] [varchar](max) NOT NULL,
	[EpisodeNumber] [int] NOT NULL,
	[EpisodeType] [int] NOT NULL,
	[AirDate] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AniDB_Episode] PRIMARY KEY CLUSTERED 
(
	[AniDB_EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Episode_Title]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Episode_Title]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Episode_Title](
	[AniDB_Episode_TitleID] [int] IDENTITY(1,1) NOT NULL,
	[AniDB_EpisodeID] [int] NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](500) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_File]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_File]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_File](
	[AniDB_FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileID] [int] NOT NULL,
	[Hash] [varchar](50) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[File_Source] [varchar](max) NOT NULL,
	[File_AudioCodec] [varchar](max) NOT NULL,
	[File_VideoCodec] [varchar](max) NOT NULL,
	[File_VideoResolution] [varchar](max) NOT NULL,
	[File_FileExtension] [varchar](max) NOT NULL,
	[File_LengthSeconds] [int] NOT NULL,
	[File_Description] [varchar](max) NOT NULL,
	[File_ReleaseDate] [int] NOT NULL,
	[Anime_GroupName] [nvarchar](max) NOT NULL,
	[Anime_GroupNameShort] [nvarchar](max) NOT NULL,
	[Episode_Rating] [int] NOT NULL,
	[Episode_Votes] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[IsWatched] [int] NOT NULL,
	[WatchedDate] [datetime] NULL,
	[CRC] [varchar](max) NOT NULL,
	[MD5] [varchar](max) NOT NULL,
	[SHA1] [varchar](max) NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[FileVersion] [int] NOT NULL,
	[IsCensored] [int] NOT NULL,
	[IsDeprecated] [int] NOT NULL,
	[InternalVersion] [int] NOT NULL,
	[IsChaptered] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_File] PRIMARY KEY CLUSTERED 
(
	[AniDB_FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_GroupStatus]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_GroupStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_GroupStatus](
	[AniDB_GroupStatusID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[GroupName] [nvarchar](200) NOT NULL,
	[CompletionState] [int] NOT NULL,
	[LastEpisodeNumber] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Votes] [int] NOT NULL,
	[EpisodeRange] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_AniDB_GroupStatus] PRIMARY KEY CLUSTERED 
(
	[AniDB_GroupStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_MylistStats]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_MylistStats]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_MylistStats](
	[AniDB_MylistStatsID] [int] IDENTITY(1,1) NOT NULL,
	[Animes] [int] NOT NULL,
	[Episodes] [int] NOT NULL,
	[Files] [int] NOT NULL,
	[SizeOfFiles] [bigint] NOT NULL,
	[AddedAnimes] [int] NOT NULL,
	[AddedEpisodes] [int] NOT NULL,
	[AddedFiles] [int] NOT NULL,
	[AddedGroups] [int] NOT NULL,
	[LeechPct] [int] NOT NULL,
	[GloryPct] [int] NOT NULL,
	[ViewedPct] [int] NOT NULL,
	[MylistPct] [int] NOT NULL,
	[ViewedMylistPct] [int] NOT NULL,
	[EpisodesViewed] [int] NOT NULL,
	[Votes] [int] NOT NULL,
	[Reviews] [int] NOT NULL,
	[ViewiedLength] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_MylistStats] PRIMARY KEY CLUSTERED 
(
	[AniDB_MylistStatsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Recommendation]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Recommendation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Recommendation](
	[AniDB_RecommendationID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[RecommendationType] [int] NOT NULL,
	[RecommendationText] [nvarchar](max) NULL,
 CONSTRAINT [PK_AniDB_Recommendation] PRIMARY KEY CLUSTERED 
(
	[AniDB_RecommendationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_ReleaseGroup]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_ReleaseGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_ReleaseGroup](
	[AniDB_ReleaseGroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Votes] [int] NOT NULL,
	[AnimeCount] [int] NOT NULL,
	[FileCount] [int] NOT NULL,
	[GroupName] [nvarchar](max) NOT NULL,
	[GroupNameShort] [nvarchar](200) NOT NULL,
	[IRCChannel] [nvarchar](200) NOT NULL,
	[IRCServer] [nvarchar](200) NOT NULL,
	[URL] [nvarchar](200) NOT NULL,
	[Picname] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_AniDB_ReleaseGroup] PRIMARY KEY CLUSTERED 
(
	[AniDB_ReleaseGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Review]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Review]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Review](
	[AniDB_ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ReviewID] [int] NOT NULL,
	[AuthorID] [int] NOT NULL,
	[RatingAnimation] [int] NOT NULL,
	[RatingSound] [int] NOT NULL,
	[RatingStory] [int] NOT NULL,
	[RatingCharacter] [int] NOT NULL,
	[RatingValue] [int] NOT NULL,
	[RatingEnjoyment] [int] NOT NULL,
	[ReviewText] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AniDB_Review] PRIMARY KEY CLUSTERED 
(
	[AniDB_ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Seiyuu]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Seiyuu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Seiyuu](
	[AniDB_SeiyuuID] [int] IDENTITY(1,1) NOT NULL,
	[SeiyuuID] [int] NOT NULL,
	[SeiyuuName] [nvarchar](200) NOT NULL,
	[PicName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_AniDB_Seiyuu] PRIMARY KEY CLUSTERED 
(
	[AniDB_SeiyuuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Tag]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Tag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Tag](
	[AniDB_TagID] [int] IDENTITY(1,1) NOT NULL,
	[TagID] [int] NOT NULL,
	[Spoiler] [int] NOT NULL,
	[LocalSpoiler] [int] NOT NULL,
	[GlobalSpoiler] [int] NOT NULL,
	[TagName] [nvarchar](150) NOT NULL,
	[TagCount] [int] NOT NULL,
	[TagDescription] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_AniDB_Tag] PRIMARY KEY CLUSTERED 
(
	[AniDB_TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AniDB_Vote]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AniDB_Vote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AniDB_Vote](
	[AniDB_VoteID] [int] IDENTITY(1,1) NOT NULL,
	[EntityID] [int] NOT NULL,
	[VoteValue] [int] NOT NULL,
	[VoteType] [int] NOT NULL,
 CONSTRAINT [PK_AniDB_Vote] PRIMARY KEY CLUSTERED 
(
	[AniDB_VoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeCharacter]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeCharacter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeCharacter](
	[CharacterID] [int] IDENTITY(1,1) NOT NULL,
	[AniDBID] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[AlternateName] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeEpisode]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeEpisode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeEpisode](
	[AnimeEpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeSeriesID] [int] NOT NULL,
	[AniDB_EpisodeID] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[DateTimeCreated] [datetime] NOT NULL,
	[PlexContractVersion] [int] NOT NULL,
	[PlexContractBlob] [varbinary](max) NULL,
	[PlexContractSize] [int] NOT NULL,
 CONSTRAINT [PK_AnimeEpisode] PRIMARY KEY CLUSTERED 
(
	[AnimeEpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeEpisode_User]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeEpisode_User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeEpisode_User](
	[AnimeEpisode_UserID] [int] IDENTITY(1,1) NOT NULL,
	[JMMUserID] [int] NOT NULL,
	[AnimeEpisodeID] [int] NOT NULL,
	[AnimeSeriesID] [int] NOT NULL,
	[WatchedDate] [datetime] NULL,
	[PlayedCount] [int] NOT NULL,
	[WatchedCount] [int] NOT NULL,
	[StoppedCount] [int] NOT NULL,
	[ContractVersion] [int] NOT NULL,
	[ContractBlob] [varbinary](max) NULL,
	[ContractSize] [int] NOT NULL,
 CONSTRAINT [PK_AnimeEpisode_User] PRIMARY KEY CLUSTERED 
(
	[AnimeEpisode_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeGroup]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeGroup](
	[AnimeGroupID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeGroupParentID] [int] NULL,
	[GroupName] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[IsManuallyNamed] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[DateTimeCreated] [datetime] NOT NULL,
	[SortName] [varchar](max) NOT NULL,
	[MissingEpisodeCount] [int] NOT NULL,
	[MissingEpisodeCountGroups] [int] NOT NULL,
	[OverrideDescription] [int] NOT NULL,
	[EpisodeAddedDate] [datetime] NULL,
	[DefaultAnimeSeriesID] [int] NULL,
	[ContractVersion] [int] NOT NULL,
	[LatestEpisodeAirDate] [datetime] NULL,
	[ContractBlob] [varbinary](max) NULL,
	[ContractSize] [int] NOT NULL,
 CONSTRAINT [PK_AnimeGroup] PRIMARY KEY CLUSTERED 
(
	[AnimeGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeGroup_User]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeGroup_User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeGroup_User](
	[AnimeGroup_UserID] [int] IDENTITY(1,1) NOT NULL,
	[JMMUserID] [int] NOT NULL,
	[AnimeGroupID] [int] NOT NULL,
	[IsFave] [int] NOT NULL,
	[UnwatchedEpisodeCount] [int] NOT NULL,
	[WatchedEpisodeCount] [int] NOT NULL,
	[WatchedDate] [datetime] NULL,
	[PlayedCount] [int] NOT NULL,
	[WatchedCount] [int] NOT NULL,
	[StoppedCount] [int] NOT NULL,
	[PlexContractVersion] [int] NOT NULL,
	[PlexContractBlob] [varbinary](max) NULL,
	[PlexContractSize] [int] NOT NULL,
 CONSTRAINT [PK_AnimeGroup_User] PRIMARY KEY CLUSTERED 
(
	[AnimeGroup_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeSeries]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeSeries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeSeries](
	[AnimeSeriesID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeGroupID] [int] NOT NULL,
	[AniDB_ID] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[DateTimeCreated] [datetime] NOT NULL,
	[DefaultAudioLanguage] [varchar](max) NULL,
	[DefaultSubtitleLanguage] [varchar](max) NULL,
	[MissingEpisodeCount] [int] NOT NULL,
	[MissingEpisodeCountGroups] [int] NOT NULL,
	[LatestLocalEpisodeNumber] [int] NOT NULL,
	[EpisodeAddedDate] [datetime] NULL,
	[SeriesNameOverride] [nvarchar](500) NULL,
	[DefaultFolder] [nvarchar](max) NULL,
	[ContractVersion] [int] NOT NULL,
	[LatestEpisodeAirDate] [datetime] NULL,
	[ContractBlob] [varbinary](max) NULL,
	[ContractSize] [int] NOT NULL,
	[AirsOn] [varchar](10) NULL,
 CONSTRAINT [PK_AnimeSeries] PRIMARY KEY CLUSTERED 
(
	[AnimeSeriesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeSeries_User]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeSeries_User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeSeries_User](
	[AnimeSeries_UserID] [int] IDENTITY(1,1) NOT NULL,
	[JMMUserID] [int] NOT NULL,
	[AnimeSeriesID] [int] NOT NULL,
	[UnwatchedEpisodeCount] [int] NOT NULL,
	[WatchedEpisodeCount] [int] NOT NULL,
	[WatchedDate] [datetime] NULL,
	[PlayedCount] [int] NOT NULL,
	[WatchedCount] [int] NOT NULL,
	[StoppedCount] [int] NOT NULL,
	[PlexContractVersion] [int] NOT NULL,
	[PlexContractBlob] [varbinary](max) NULL,
	[PlexContractSize] [int] NOT NULL,
 CONSTRAINT [PK_AnimeSeries_User] PRIMARY KEY CLUSTERED 
(
	[AnimeSeries_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AnimeStaff]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AnimeStaff]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AnimeStaff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[AniDBID] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[AlternateName] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AuthTokens]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuthTokens]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AuthTokens](
	[AuthID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[DeviceName] [nvarchar](max) NOT NULL,
	[Token] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BookmarkedAnime]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BookmarkedAnime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BookmarkedAnime](
	[BookmarkedAnimeID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[Priority] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[Downloading] [int] NOT NULL,
 CONSTRAINT [PK_BookmarkedAnime] PRIMARY KEY CLUSTERED 
(
	[BookmarkedAnimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CloudAccount]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloudAccount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CloudAccount](
	[CloudID] [int] IDENTITY(1,1) NOT NULL,
	[ConnectionString] [nvarchar](max) NOT NULL,
	[Provider] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CloudAccount] PRIMARY KEY CLUSTERED 
(
	[CloudID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CommandRequest]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CommandRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CommandRequest](
	[CommandRequestID] [int] IDENTITY(1,1) NOT NULL,
	[Priority] [int] NOT NULL,
	[CommandType] [int] NOT NULL,
	[CommandID] [nvarchar](max) NOT NULL,
	[CommandDetails] [nvarchar](max) NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_CommandRequest] PRIMARY KEY CLUSTERED 
(
	[CommandRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_MAL]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_MAL]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_MAL](
	[CrossRef_AniDB_MALID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[MALID] [int] NOT NULL,
	[MALTitle] [nvarchar](500) NULL,
	[StartEpisodeType] [int] NOT NULL,
	[StartEpisodeNumber] [int] NOT NULL,
	[CrossRefSource] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_AniDB_MAL] PRIMARY KEY CLUSTERED 
(
	[CrossRef_AniDB_MALID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_Other]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_Other]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_Other](
	[CrossRef_AniDB_OtherID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[CrossRefID] [nvarchar](500) NOT NULL,
	[CrossRefSource] [int] NOT NULL,
	[CrossRefType] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_AniDB_Other] PRIMARY KEY CLUSTERED 
(
	[CrossRef_AniDB_OtherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_Trakt]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_Trakt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_Trakt](
	[CrossRef_AniDB_TraktID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[TraktID] [nvarchar](500) NULL,
	[TraktSeasonNumber] [int] NOT NULL,
	[CrossRefSource] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_AniDB_Trakt] PRIMARY KEY CLUSTERED 
(
	[CrossRef_AniDB_TraktID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_Trakt_Episode]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_Trakt_Episode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_Trakt_Episode](
	[CrossRef_AniDB_Trakt_EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[AniDBEpisodeID] [int] NOT NULL,
	[TraktID] [nvarchar](500) NULL,
	[Season] [int] NOT NULL,
	[EpisodeNumber] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_AniDB_Trakt_Episode] PRIMARY KEY CLUSTERED 
(
	[CrossRef_AniDB_Trakt_EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_TraktV2]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_TraktV2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_TraktV2](
	[CrossRef_AniDB_TraktV2ID] [int] IDENTITY(1,1) NOT NULL,
	[AnimeID] [int] NOT NULL,
	[AniDBStartEpisodeType] [int] NOT NULL,
	[AniDBStartEpisodeNumber] [int] NOT NULL,
	[TraktID] [nvarchar](500) NULL,
	[TraktSeasonNumber] [int] NOT NULL,
	[TraktStartEpisodeNumber] [int] NOT NULL,
	[TraktTitle] [nvarchar](max) NULL,
	[CrossRefSource] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_AniDB_TraktV2] PRIMARY KEY CLUSTERED 
(
	[CrossRef_AniDB_TraktV2ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_TvDB]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_TvDB]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_TvDB](
	[CrossRef_AniDB_TvDBID] [int] IDENTITY(1,1) NOT NULL,
	[AniDBID] [int] NOT NULL,
	[TvDBID] [int] NOT NULL,
	[CrossRefSource] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_TvDB_Episode]    Script Date: 2018-10-22 1:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_TvDB_Episode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_TvDB_Episode](
	[CrossRef_AniDB_TvDB_EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[AniDBEpisodeID] [int] NOT NULL,
	[TvDBEpisodeID] [int] NOT NULL,
	[MatchRating] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_AniDB_TvDB_Episode_Override]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_AniDB_TvDB_Episode_Override]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_AniDB_TvDB_Episode_Override](
	[CrossRef_AniDB_TvDB_Episode_OverrideID] [int] IDENTITY(1,1) NOT NULL,
	[AniDBEpisodeID] [int] NOT NULL,
	[TvDBEpisodeID] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_AniDB_TvDB_Episode] PRIMARY KEY CLUSTERED 
(
	[CrossRef_AniDB_TvDB_Episode_OverrideID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_Anime_Staff]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_Anime_Staff]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_Anime_Staff](
	[CrossRef_Anime_StaffID] [int] IDENTITY(1,1) NOT NULL,
	[AniDB_AnimeID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[Role] [nvarchar](max) NULL,
	[RoleID] [int] NULL,
	[RoleType] [int] NOT NULL,
	[Language] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_CustomTag]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_CustomTag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_CustomTag](
	[CrossRef_CustomTagID] [int] IDENTITY(1,1) NOT NULL,
	[CustomTagID] [int] NOT NULL,
	[CrossRefID] [int] NOT NULL,
	[CrossRefType] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_CustomTag] PRIMARY KEY CLUSTERED 
(
	[CrossRef_CustomTagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_File_Episode]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_File_Episode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_File_Episode](
	[CrossRef_File_EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[Hash] [varchar](50) NULL,
	[FileName] [nvarchar](500) NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[CrossRefSource] [int] NOT NULL,
	[AnimeID] [int] NOT NULL,
	[EpisodeID] [int] NOT NULL,
	[Percentage] [int] NOT NULL,
	[EpisodeOrder] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_File_Episode] PRIMARY KEY CLUSTERED 
(
	[CrossRef_File_EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_Languages_AniDB_File]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_Languages_AniDB_File]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_Languages_AniDB_File](
	[CrossRef_Languages_AniDB_FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_Languages_AniDB_File] PRIMARY KEY CLUSTERED 
(
	[CrossRef_Languages_AniDB_FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CrossRef_Subtitles_AniDB_File]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CrossRef_Subtitles_AniDB_File]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CrossRef_Subtitles_AniDB_File](
	[CrossRef_Subtitles_AniDB_FileID] [int] IDENTITY(1,1) NOT NULL,
	[FileID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
 CONSTRAINT [PK_CrossRef_Subtitles_AniDB_File] PRIMARY KEY CLUSTERED 
(
	[CrossRef_Subtitles_AniDB_FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CustomTag]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomTag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CustomTag](
	[CustomTagID] [int] IDENTITY(1,1) NOT NULL,
	[TagName] [nvarchar](500) NULL,
	[TagDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_CustomTag] PRIMARY KEY CLUSTERED 
(
	[CustomTagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DuplicateFile]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DuplicateFile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DuplicateFile](
	[DuplicateFileID] [int] IDENTITY(1,1) NOT NULL,
	[FilePathFile1] [nvarchar](max) NOT NULL,
	[FilePathFile2] [nvarchar](max) NOT NULL,
	[ImportFolderIDFile1] [int] NOT NULL,
	[ImportFolderIDFile2] [int] NOT NULL,
	[Hash] [varchar](50) NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_DuplicateFile] PRIMARY KEY CLUSTERED 
(
	[DuplicateFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FileFfdshowPreset]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FileFfdshowPreset]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FileFfdshowPreset](
	[FileFfdshowPresetID] [int] IDENTITY(1,1) NOT NULL,
	[Hash] [varchar](50) NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[Preset] [nvarchar](max) NULL,
 CONSTRAINT [PK_FileFfdshowPreset] PRIMARY KEY CLUSTERED 
(
	[FileFfdshowPresetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FileNameHash]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FileNameHash]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FileNameHash](
	[FileNameHashID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](500) NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[Hash] [varchar](50) NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_FileNameHash] PRIMARY KEY CLUSTERED 
(
	[FileNameHashID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[GroupFilter]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupFilter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GroupFilter](
	[GroupFilterID] [int] IDENTITY(1,1) NOT NULL,
	[GroupFilterName] [nvarchar](max) NOT NULL,
	[ApplyToSeries] [int] NOT NULL,
	[BaseCondition] [int] NOT NULL,
	[SortingCriteria] [nvarchar](max) NULL,
	[Locked] [int] NULL,
	[FilterType] [int] NOT NULL,
	[GroupsIdsVersion] [int] NOT NULL,
	[GroupsIdsString] [nvarchar](max) NULL,
	[GroupConditionsVersion] [int] NOT NULL,
	[GroupConditions] [nvarchar](max) NULL,
	[ParentGroupFilterID] [int] NULL,
	[InvisibleInClients] [int] NOT NULL,
	[SeriesIdsVersion] [int] NOT NULL,
	[SeriesIdsString] [nvarchar](max) NULL,
 CONSTRAINT [PK_GroupFilter] PRIMARY KEY CLUSTERED 
(
	[GroupFilterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[GroupFilterCondition]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupFilterCondition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GroupFilterCondition](
	[GroupFilterConditionID] [int] IDENTITY(1,1) NOT NULL,
	[GroupFilterID] [int] NOT NULL,
	[ConditionType] [int] NOT NULL,
	[ConditionOperator] [int] NOT NULL,
	[ConditionParameter] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_GroupFilterCondition] PRIMARY KEY CLUSTERED 
(
	[GroupFilterConditionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[IgnoreAnime]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IgnoreAnime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IgnoreAnime](
	[IgnoreAnimeID] [int] IDENTITY(1,1) NOT NULL,
	[JMMUserID] [int] NOT NULL,
	[AnimeID] [int] NOT NULL,
	[IgnoreType] [int] NOT NULL,
 CONSTRAINT [PK_IgnoreAnime] PRIMARY KEY CLUSTERED 
(
	[IgnoreAnimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ImportFolder]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportFolder]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ImportFolder](
	[ImportFolderID] [int] IDENTITY(1,1) NOT NULL,
	[ImportFolderType] [int] NOT NULL,
	[ImportFolderName] [nvarchar](max) NOT NULL,
	[ImportFolderLocation] [nvarchar](max) NOT NULL,
	[IsDropSource] [int] NOT NULL,
	[IsDropDestination] [int] NOT NULL,
	[IsWatched] [int] NOT NULL,
	[CloudID] [int] NULL,
 CONSTRAINT [PK_ImportFolder] PRIMARY KEY CLUSTERED 
(
	[ImportFolderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[JMMUser]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JMMUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[JMMUser](
	[JMMUserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NULL,
	[Password] [nvarchar](150) NULL,
	[IsAdmin] [int] NOT NULL,
	[IsAniDBUser] [int] NOT NULL,
	[IsTraktUser] [int] NOT NULL,
	[HideCategories] [nvarchar](max) NULL,
	[CanEditServerSettings] [int] NULL,
	[PlexUsers] [nvarchar](max) NULL,
	[PlexToken] [nvarchar](max) NULL,
 CONSTRAINT [PK_JMMUser] PRIMARY KEY CLUSTERED 
(
	[JMMUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Language]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Language]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Language](
	[LanguageID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MovieDB_Fanart]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MovieDB_Fanart]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MovieDB_Fanart](
	[MovieDB_FanartID] [int] IDENTITY(1,1) NOT NULL,
	[ImageID] [varchar](100) NULL,
	[MovieId] [int] NOT NULL,
	[ImageType] [varchar](100) NULL,
	[ImageSize] [varchar](100) NULL,
	[URL] [nvarchar](max) NULL,
	[ImageWidth] [int] NOT NULL,
	[ImageHeight] [int] NOT NULL,
	[Enabled] [int] NOT NULL,
 CONSTRAINT [PK_MovieDB_Fanart] PRIMARY KEY CLUSTERED 
(
	[MovieDB_FanartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MovieDB_Movie]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MovieDB_Movie]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MovieDB_Movie](
	[MovieDB_MovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NOT NULL,
	[MovieName] [nvarchar](max) NULL,
	[OriginalName] [nvarchar](max) NULL,
	[Overview] [nvarchar](max) NULL,
	[Rating] [int] NOT NULL,
 CONSTRAINT [PK_MovieDB_Movie] PRIMARY KEY CLUSTERED 
(
	[MovieDB_MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MovieDB_Poster]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MovieDB_Poster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MovieDB_Poster](
	[MovieDB_PosterID] [int] IDENTITY(1,1) NOT NULL,
	[ImageID] [varchar](100) NULL,
	[MovieId] [int] NOT NULL,
	[ImageType] [varchar](100) NULL,
	[ImageSize] [varchar](100) NULL,
	[URL] [nvarchar](max) NULL,
	[ImageWidth] [int] NOT NULL,
	[ImageHeight] [int] NOT NULL,
	[Enabled] [int] NOT NULL,
 CONSTRAINT [PK_MovieDB_Poster] PRIMARY KEY CLUSTERED 
(
	[MovieDB_PosterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Playlist]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Playlist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Playlist](
	[PlaylistID] [int] IDENTITY(1,1) NOT NULL,
	[PlaylistName] [nvarchar](max) NULL,
	[PlaylistItems] [varchar](max) NULL,
	[DefaultPlayOrder] [int] NOT NULL,
	[PlayWatched] [int] NOT NULL,
	[PlayUnwatched] [int] NOT NULL,
 CONSTRAINT [PK_Playlist] PRIMARY KEY CLUSTERED 
(
	[PlaylistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RenameScript]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RenameScript]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RenameScript](
	[RenameScriptID] [int] IDENTITY(1,1) NOT NULL,
	[ScriptName] [nvarchar](max) NULL,
	[Script] [nvarchar](max) NULL,
	[IsEnabledOnImport] [int] NOT NULL,
	[RenamerType] [nvarchar](max) NOT NULL,
	[ExtraData] [nvarchar](max) NULL,
 CONSTRAINT [PK_RenameScript] PRIMARY KEY CLUSTERED 
(
	[RenameScriptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Scan]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Scan]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Scan](
	[ScanID] [int] IDENTITY(1,1) NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ImportFolders] [nvarchar](max) NOT NULL,
	[Status] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ScanFile]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScanFile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScanFile](
	[ScanFileID] [int] IDENTITY(1,1) NOT NULL,
	[ScanID] [int] NOT NULL,
	[ImportFolderID] [int] NOT NULL,
	[VideoLocal_Place_ID] [int] NOT NULL,
	[FullName] [nvarchar](max) NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[Status] [int] NOT NULL,
	[CheckDate] [datetime] NULL,
	[Hash] [nvarchar](100) NOT NULL,
	[HashResult] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ScheduledUpdate]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduledUpdate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduledUpdate](
	[ScheduledUpdateID] [int] IDENTITY(1,1) NOT NULL,
	[UpdateType] [int] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[UpdateDetails] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ScheduledUpdate] PRIMARY KEY CLUSTERED 
(
	[ScheduledUpdateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Trakt_Episode]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Trakt_Episode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Trakt_Episode](
	[Trakt_EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[Trakt_ShowID] [int] NOT NULL,
	[Season] [int] NOT NULL,
	[EpisodeNumber] [int] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[URL] [nvarchar](500) NULL,
	[Overview] [nvarchar](max) NULL,
	[EpisodeImage] [nvarchar](500) NULL,
	[TraktID] [int] NULL,
 CONSTRAINT [PK_Trakt_Episode] PRIMARY KEY CLUSTERED 
(
	[Trakt_EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Trakt_Friend]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Trakt_Friend]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Trakt_Friend](
	[Trakt_FriendID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[Gender] [nvarchar](100) NULL,
	[Age] [nvarchar](100) NULL,
	[Location] [nvarchar](100) NULL,
	[About] [nvarchar](max) NULL,
	[Joined] [int] NOT NULL,
	[Avatar] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[LastAvatarUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_Trakt_Friend] PRIMARY KEY CLUSTERED 
(
	[Trakt_FriendID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Trakt_Season]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Trakt_Season]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Trakt_Season](
	[Trakt_SeasonID] [int] IDENTITY(1,1) NOT NULL,
	[Trakt_ShowID] [int] NOT NULL,
	[Season] [int] NOT NULL,
	[URL] [nvarchar](500) NULL,
 CONSTRAINT [PK_Trakt_Season] PRIMARY KEY CLUSTERED 
(
	[Trakt_SeasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Trakt_Show]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Trakt_Show]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Trakt_Show](
	[Trakt_ShowID] [int] IDENTITY(1,1) NOT NULL,
	[TraktID] [nvarchar](500) NULL,
	[Title] [nvarchar](max) NULL,
	[Year] [nvarchar](500) NULL,
	[URL] [nvarchar](500) NULL,
	[Overview] [nvarchar](max) NULL,
	[TvDB_ID] [int] NULL,
 CONSTRAINT [PK_Trakt_Show] PRIMARY KEY CLUSTERED 
(
	[Trakt_ShowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TvDB_Episode]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TvDB_Episode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TvDB_Episode](
	[TvDB_EpisodeID] [int] IDENTITY(1,1) NOT NULL,
	[Id] [int] NOT NULL,
	[SeriesID] [int] NOT NULL,
	[SeasonID] [int] NOT NULL,
	[SeasonNumber] [int] NOT NULL,
	[EpisodeNumber] [int] NOT NULL,
	[EpisodeName] [nvarchar](max) NULL,
	[Overview] [nvarchar](max) NULL,
	[Filename] [nvarchar](max) NULL,
	[EpImgFlag] [int] NOT NULL,
	[AbsoluteNumber] [int] NULL,
	[AirsAfterSeason] [int] NULL,
	[AirsBeforeEpisode] [int] NULL,
	[AirsBeforeSeason] [int] NULL,
	[Rating] [int] NULL,
	[AirDate] [datetime] NULL,
 CONSTRAINT [PK_TvDB_Episode] PRIMARY KEY CLUSTERED 
(
	[TvDB_EpisodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TvDB_ImageFanart]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TvDB_ImageFanart]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TvDB_ImageFanart](
	[TvDB_ImageFanartID] [int] IDENTITY(1,1) NOT NULL,
	[Id] [int] NOT NULL,
	[SeriesID] [int] NOT NULL,
	[BannerPath] [nvarchar](max) NULL,
	[BannerType] [nvarchar](max) NULL,
	[BannerType2] [nvarchar](max) NULL,
	[Colors] [nvarchar](max) NULL,
	[Language] [nvarchar](max) NULL,
	[ThumbnailPath] [nvarchar](max) NULL,
	[VignettePath] [nvarchar](max) NULL,
	[Enabled] [int] NOT NULL,
	[Chosen] [int] NOT NULL,
 CONSTRAINT [PK_TvDB_ImageFanart] PRIMARY KEY CLUSTERED 
(
	[TvDB_ImageFanartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TvDB_ImagePoster]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TvDB_ImagePoster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TvDB_ImagePoster](
	[TvDB_ImagePosterID] [int] IDENTITY(1,1) NOT NULL,
	[Id] [int] NOT NULL,
	[SeriesID] [int] NOT NULL,
	[BannerPath] [nvarchar](max) NULL,
	[BannerType] [nvarchar](max) NULL,
	[BannerType2] [nvarchar](max) NULL,
	[Language] [nvarchar](max) NULL,
	[Enabled] [int] NOT NULL,
	[SeasonNumber] [int] NULL,
 CONSTRAINT [PK_TvDB_ImagePoster] PRIMARY KEY CLUSTERED 
(
	[TvDB_ImagePosterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TvDB_ImageWideBanner]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TvDB_ImageWideBanner]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TvDB_ImageWideBanner](
	[TvDB_ImageWideBannerID] [int] IDENTITY(1,1) NOT NULL,
	[Id] [int] NOT NULL,
	[SeriesID] [int] NOT NULL,
	[BannerPath] [nvarchar](max) NULL,
	[BannerType] [nvarchar](max) NULL,
	[BannerType2] [nvarchar](max) NULL,
	[Language] [nvarchar](max) NULL,
	[Enabled] [int] NOT NULL,
	[SeasonNumber] [int] NULL,
 CONSTRAINT [PK_TvDB_ImageWideBanner] PRIMARY KEY CLUSTERED 
(
	[TvDB_ImageWideBannerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TvDB_Series]    Script Date: 2018-10-22 1:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TvDB_Series]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TvDB_Series](
	[TvDB_SeriesID] [int] IDENTITY(1,1) NOT NULL,
	[SeriesID] [int] NOT NULL,
	[Overview] [nvarchar](max) NULL,
	[SeriesName] [nvarchar](max) NULL,
	[Status] [varchar](100) NULL,
	[Banner] [varchar](100) NULL,
	[Fanart] [varchar](100) NULL,
	[Poster] [varchar](100) NULL,
	[Lastupdated] [varchar](100) NULL,
	[Rating] [int] NULL,
 CONSTRAINT [PK_TvDB_Series] PRIMARY KEY CLUSTERED 
(
	[TvDB_SeriesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[VideoLocal]    Script Date: 2018-10-22 1:55:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VideoLocal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VideoLocal](
	[VideoLocalID] [int] IDENTITY(1,1) NOT NULL,
	[Hash] [varchar](50) NOT NULL,
	[CRC32] [varchar](50) NULL,
	[MD5] [varchar](50) NULL,
	[SHA1] [varchar](50) NULL,
	[HashSource] [int] NOT NULL,
	[FileSize] [bigint] NOT NULL,
	[IsIgnored] [int] NOT NULL,
	[DateTimeUpdated] [datetime] NOT NULL,
	[DateTimeCreated] [datetime] NOT NULL,
	[IsVariation] [int] NOT NULL,
	[MediaVersion] [int] NOT NULL,
	[MediaBlob] [varbinary](max) NULL,
	[MediaSize] [int] NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[VideoCodec] [varchar](max) NOT NULL,
	[VideoBitrate] [varchar](max) NOT NULL,
	[VideoBitDepth] [varchar](max) NOT NULL,
	[VideoFrameRate] [varchar](max) NOT NULL,
	[VideoResolution] [varchar](max) NOT NULL,
	[AudioCodec] [varchar](max) NOT NULL,
	[AudioBitrate] [varchar](max) NOT NULL,
	[Duration] [bigint] NOT NULL,
	[MyListID] [int] NOT NULL,
 CONSTRAINT [PK_VideoLocal] PRIMARY KEY CLUSTERED 
(
	[VideoLocalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[VideoLocal_Place]    Script Date: 2018-10-22 1:55:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VideoLocal_Place]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VideoLocal_Place](
	[VideoLocal_Place_ID] [int] IDENTITY(1,1) NOT NULL,
	[VideoLocalID] [int] NOT NULL,
	[FilePath] [nvarchar](max) NOT NULL,
	[ImportFolderID] [int] NOT NULL,
	[ImportFolderType] [int] NOT NULL,
 CONSTRAINT [PK_VideoLocal_Place] PRIMARY KEY CLUSTERED 
(
	[VideoLocal_Place_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[VideoLocal_User]    Script Date: 2018-10-22 1:55:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VideoLocal_User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VideoLocal_User](
	[VideoLocal_UserID] [int] IDENTITY(1,1) NOT NULL,
	[JMMUserID] [int] NOT NULL,
	[VideoLocalID] [int] NOT NULL,
	[WatchedDate] [datetime] NULL,
	[ResumePosition] [bigint] NOT NULL,
 CONSTRAINT [PK_VideoLocal_User] PRIMARY KEY CLUSTERED 
(
	[VideoLocal_UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[CustomTag] ON 

INSERT [dbo].[CustomTag] ([CustomTagID], [TagName], [TagDescription]) VALUES (1, N'Dropped', N'Started watching this series, but have since dropped it')
INSERT [dbo].[CustomTag] ([CustomTagID], [TagName], [TagDescription]) VALUES (2, N'Pinned', N'Pinned this series for whatever reason you like')
INSERT [dbo].[CustomTag] ([CustomTagID], [TagName], [TagDescription]) VALUES (3, N'Ongoing', N'This series does not have an end date')
INSERT [dbo].[CustomTag] ([CustomTagID], [TagName], [TagDescription]) VALUES (4, N'Waiting for Series Completion', N'Will start watching this once this series is finished')
INSERT [dbo].[CustomTag] ([CustomTagID], [TagName], [TagDescription]) VALUES (5, N'Waiting for Blu-ray Completion', N'Will start watching this once all episodes are available in Blu-Ray')
SET IDENTITY_INSERT [dbo].[CustomTag] OFF
SET IDENTITY_INSERT [dbo].[GroupFilter] ON 

INSERT [dbo].[GroupFilter] ([GroupFilterID], [GroupFilterName], [ApplyToSeries], [BaseCondition], [SortingCriteria], [Locked], [FilterType], [GroupsIdsVersion], [GroupsIdsString], [GroupConditionsVersion], [GroupConditions], [ParentGroupFilterID], [InvisibleInClients], [SeriesIdsVersion], [SeriesIdsString]) VALUES (1, N'Continue Watching (SYSTEM)', 0, 1, N'4;2', 1, 2, 3, N'{}', 1, N'[{"GroupFilterConditionID":0,"GroupFilterID":1,"ConditionType":28,"ConditionOperator":1,"ConditionParameter":""},{"GroupFilterConditionID":0,"GroupFilterID":1,"ConditionType":3,"ConditionOperator":1,"ConditionParameter":""}]', NULL, 0, 2, N'{}')
INSERT [dbo].[GroupFilter] ([GroupFilterID], [GroupFilterName], [ApplyToSeries], [BaseCondition], [SortingCriteria], [Locked], [FilterType], [GroupsIdsVersion], [GroupsIdsString], [GroupConditionsVersion], [GroupConditions], [ParentGroupFilterID], [InvisibleInClients], [SeriesIdsVersion], [SeriesIdsString]) VALUES (2, N'All', 0, 1, N'5;1', 1, 4, 3, N'{}', 1, N'[]', NULL, 0, 2, N'{}')
INSERT [dbo].[GroupFilter] ([GroupFilterID], [GroupFilterName], [ApplyToSeries], [BaseCondition], [SortingCriteria], [Locked], [FilterType], [GroupsIdsVersion], [GroupsIdsString], [GroupConditionsVersion], [GroupConditions], [ParentGroupFilterID], [InvisibleInClients], [SeriesIdsVersion], [SeriesIdsString]) VALUES (3, N'Tags', 0, 1, N'13;1', 1, 24, 3, N'{}', 1, N'[]', NULL, 0, 2, N'{}')
INSERT [dbo].[GroupFilter] ([GroupFilterID], [GroupFilterName], [ApplyToSeries], [BaseCondition], [SortingCriteria], [Locked], [FilterType], [GroupsIdsVersion], [GroupsIdsString], [GroupConditionsVersion], [GroupConditions], [ParentGroupFilterID], [InvisibleInClients], [SeriesIdsVersion], [SeriesIdsString]) VALUES (4, N'Years', 0, 1, N'13;1', 1, 40, 3, N'{}', 1, N'[]', NULL, 0, 2, N'{}')
INSERT [dbo].[GroupFilter] ([GroupFilterID], [GroupFilterName], [ApplyToSeries], [BaseCondition], [SortingCriteria], [Locked], [FilterType], [GroupsIdsVersion], [GroupsIdsString], [GroupConditionsVersion], [GroupConditions], [ParentGroupFilterID], [InvisibleInClients], [SeriesIdsVersion], [SeriesIdsString]) VALUES (5, N'Seasons', 0, 1, N'13;1', 1, 72, 3, N'{}', 1, N'[]', NULL, 0, 2, N'{}')
SET IDENTITY_INSERT [dbo].[GroupFilter] OFF
SET IDENTITY_INSERT [dbo].[JMMUser] ON 

INSERT [dbo].[JMMUser] ([JMMUserID], [Username], [Password], [IsAdmin], [IsAniDBUser], [IsTraktUser], [HideCategories], [CanEditServerSettings], [PlexUsers], [PlexToken]) VALUES (1, N'Default', N'', 1, 1, 1, N'', 1, NULL, NULL)
INSERT [dbo].[JMMUser] ([JMMUserID], [Username], [Password], [IsAdmin], [IsAniDBUser], [IsTraktUser], [HideCategories], [CanEditServerSettings], [PlexUsers], [PlexToken]) VALUES (2, N'Family Friendly', N'', 1, 1, 1, N'ecchi,nudity,sex,sexual abuse,horror,erotic game,incest,18 restricted', 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[JMMUser] OFF
SET IDENTITY_INSERT [dbo].[RenameScript] ON 

INSERT [dbo].[RenameScript] ([RenameScriptID], [ScriptName], [Script], [IsEnabledOnImport], [RenamerType], [ExtraData]) VALUES (1, N'Default', N'// Sample Output: [Coalgirls]_Highschool_of_the_Dead_-_01_(1920x1080_Blu-ray_H264)_[90CC6DC1].mkv
// Sub group name
DO ADD ''[%grp] ''
// Anime Name, use english name if it exists, otherwise use the Romaji name
IF I(eng) DO ADD ''%eng ''
IF I(ann);I(!eng) DO ADD ''%ann ''
// Episode Number, don''t use episode number for movies
IF T(!Movie) DO ADD ''- %enr''
// If the file version is v2 or higher add it here
IF F(!1) DO ADD ''v%ver''
// Video Resolution
DO ADD '' (%res''
// Video Source (only if blu-ray or DVD)
IF R(DVD),R(Blu-ray) DO ADD '' %src''
// Video Codec
DO ADD '' %vid''
// Video Bit Depth (only if 10bit)
IF Z(10) DO ADD '' %bitbit''
DO ADD '') ''
DO ADD ''[%CRC]''

// Replacement rules (cleanup)
DO REPLACE '' '' ''_'' // replace spaces with underscores
DO REPLACE ''H264/AVC'' ''H264''
DO REPLACE ''0x0'' ''''
DO REPLACE ''__'' ''_''
DO REPLACE ''__'' ''_''

// Replace all illegal file name characters
DO REPLACE ''<'' ''(''
DO REPLACE ''>'' '')''
DO REPLACE '':'' ''-''
DO REPLACE ''"'' ''`''
DO REPLACE ''/'' ''_''
DO REPLACE ''/'' ''_''
DO REPLACE ''\'' ''_''
DO REPLACE ''|'' ''_''
DO REPLACE ''?'' ''_''
DO REPLACE ''*'' ''_''
', 0, N'Legacy', NULL)
SET IDENTITY_INSERT [dbo].[RenameScript] OFF

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AniDB_Ani__Contr__44CA3770]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AniDB_Anime] ADD  DEFAULT ((0)) FOR [ContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AniDB_Ani__Contr__5224328E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AniDB_Anime] ADD  DEFAULT ((0)) FOR [ContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AniDB_Epi__Descr__6FB49575]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AniDB_Episode] ADD  DEFAULT ('') FOR [Description]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AniDB_Fil__IsCha__69FBBC1F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AniDB_File] ADD  DEFAULT ((-1)) FOR [IsChaptered]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeEpis__PlexC__4D5F7D71]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeEpisode] ADD  DEFAULT ((0)) FOR [PlexContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeEpis__PlexC__540C7B00]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeEpisode] ADD  DEFAULT ((0)) FOR [PlexContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeEpis__Contr__4C6B5938]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeEpisode_User] ADD  DEFAULT ((0)) FOR [ContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeEpis__Contr__55009F39]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeEpisode_User] ADD  DEFAULT ((0)) FOR [ContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeGrou__Contr__45BE5BA9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeGroup] ADD  DEFAULT ((0)) FOR [ContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeGrou__Contr__58D1301D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeGroup] ADD  DEFAULT ((0)) FOR [ContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeGrou__PlexC__46B27FE2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeGroup_User] ADD  DEFAULT ((0)) FOR [PlexContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeGrou__PlexC__57DD0BE4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeGroup_User] ADD  DEFAULT ((0)) FOR [PlexContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeSeri__Contr__489AC854]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeSeries] ADD  DEFAULT ((0)) FOR [ContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeSeri__Contr__55F4C372]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeSeries] ADD  DEFAULT ((0)) FOR [ContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeSeri__PlexC__498EEC8D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeSeries_User] ADD  DEFAULT ((0)) FOR [PlexContractVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__AnimeSeri__PlexC__56E8E7AB]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AnimeSeries_User] ADD  DEFAULT ((0)) FOR [PlexContractSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__GroupFilt__Group__4B7734FF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GroupFilter] ADD  DEFAULT ((0)) FOR [GroupsIdsVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__GroupFilt__Group__4F47C5E3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GroupFilter] ADD  DEFAULT ((0)) FOR [GroupConditionsVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__GroupFilt__Invis__503BEA1C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GroupFilter] ADD  DEFAULT ((0)) FOR [InvisibleInClients]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__GroupFilt__Serie__51300E55]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GroupFilter] ADD  DEFAULT ((0)) FOR [SeriesIdsVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__MovieDB_M__Ratin__6EC0713C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MovieDB_Movie] ADD  DEFAULT ((0)) FOR [Rating]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__RenameScr__Renam__6AEFE058]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RenameScript] ADD  DEFAULT ('Legacy') FOR [RenamerType]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Media__4E53A1AA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ((0)) FOR [MediaVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Media__531856C7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ((0)) FOR [MediaSize]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__FileN__5BAD9CC8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [FileName]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Video__5CA1C101]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [VideoCodec]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Video__5D95E53A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [VideoBitrate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Video__5E8A0973]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [VideoBitDepth]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Video__5F7E2DAC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [VideoFrameRate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Video__607251E5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [VideoResolution]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Audio__6166761E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [AudioCodec]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Audio__625A9A57]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ('') FOR [AudioBitrate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Durat__634EBE90]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ((0)) FOR [Duration]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__MyLis__719CDDE7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal] ADD  DEFAULT ((0)) FOR [MyListID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VideoLoca__Resum__662B2B3B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VideoLocal_User] ADD  DEFAULT ((0)) FOR [ResumePosition]
END
GO
