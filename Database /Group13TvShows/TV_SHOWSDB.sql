CREATE DATABASE TV_SHOWS

CREATE TABLE tblLANGUAGE (LanguageID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                            LanguageCode VARCHAR(5) NOT NULL, 
                            LanguageName VARCHAR(50) NOT NULL)
GO 
CREATE TABLE tblSERIES (SeriesID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        LanguageID INT FOREIGN KEY REFERENCES tblLANGUAGE (LanguageID) NOT NULL, 
                        SeriesName VARCHAR(100) NOT NULL, 
                        SeriesOverview VARCHAR(500) NOT NULL, 
                        SeriesPopularity INT NULL, 
                        SeasonTotal INT NOT NULL, 
                        SeriesBeginDate DATE NOT NULL, 
                        SeriesEndDate Date NULL)
GO 
CREATE TABLE tblEPISODE (EpisodeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        SeriesID INT FOREIGN KEY REFERENCES tblSERIES (SeriesID) NOT NULL, 
                        EpisodeName VARCHAR(100) NOT NULL, 
                        EpisodeOverview VARCHAR(500) NOT NULL, 
                        EpisodeRuntime TIME NOT NULL, 
                        BroadcastDate DATE)
GO 
CREATE TABLE tblGENRE (GenreID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        GenreName VARCHAR(100) NOT NULL,
                        GenreDescr VARCHAR(150) NULL)
GO 
CREATE TABLE tblEPISODE_GENRE (EpisodeGenreID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
                                EpisodeID INT FOREIGN KEY REFERENCES tblEPISODE (EpisodeID) NOT NULL, 
                                GenreID INT FOREIGN KEY REFERENCES tblGENRE (GenreID) NOT NULL)
GO 
CREATE TABLE tblGENDER (GenderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        GenderName CHAR(1) NOT NULL)
GO 
CREATE TABLE tblPERSON (PersonID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        PersonFname VARCHAR(30) NOT NULL, 
                        PersonLname VARCHAR(30) NOT NULL, 
                        PersonDOB DATE NOT NULL, 
                        GenderID INT FOREIGN KEY REFERENCES tblGENDER (GenderID) NOT NULL,
                        PersonBiography VARCHAR(500) NULL, 
                        PersonPopularity INT NULL)
GO 
CREATE TABLE tblCREDIT (CreditID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        CreditName VARCHAR(50) NOT NULL, 
                        CreditDescr VARCHAR(150) NULL)
GO 
CREATE TABLE tblPERSON_CREDIT_EPISODE (PersonCreditEpisodeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                                    EpisodeID INT FOREIGN KEY REFERENCES tblEPISODE (EpisodeID) NOT NULL, 
                                    CreditID INT FOREIGN KEY REFERENCES tblCREDIT (CreditID) NOT NULL, 
                                    PersonID INT FOREIGN KEY REFERENCES tblPERSON (PersonID) NOT NULL,
                                    [Character] VARCHAR(50) NOT NULL)
GO 
CREATE TABLE tblPLATFORM (PlatformID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                        PlatformName VARCHAR(50) NOT NULL, 
                        PlatformDescr VARCHAR(150) NOT NULL)
GO 
CREATE TABLE tblPLATFORM_EPISODE (PlatformEpisodeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
                                PlatformID INT FOREIGN KEY REFERENCES tblPLATFORM (PlatformID) NOT NULL,
                                EpisodeID INT FOREIGN KEY REFERENCES tblEPISODE (EpisodeID) NOT NULL)
GO 

