
DROP TABLE DraftOrders;
DROP TABLE RepStatistics;
DROP TABLE TeamReps;
DROP TABLE TeamScores;
DROP TABLE PlayerTeams;
DROP TABLE Players;
DROP TABLE Leagues;
DROP TABLE Reps;
DROP TABLE Quarters;


CREATE TABLE Leagues(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX idx_leagues_name
ON Leagues(Name);

CREATE TABLE Players (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX idx_players_username
ON Players(UserName);

CREATE TABLE Quarters (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    StartDate DATETIME NOT NULL,
    StopDate DATETIME NOT NULL
);

CREATE TABLE Reps (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(255) NOT NULL,
    PICGuid UNIQUEIDENTIFIER NOT NULL
);

CREATE INDEX idx_reps_picguid
ON Reps(PICGuid);

CREATE TABLE PlayerTeams (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PlayerID INT NOT NULL
            REFERENCES Players(ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    LeagueID INT REFERENCES Leagues(ID)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    QuarterID INT NOT NULL
            REFERENCES Quarters(ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE TeamReps (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PlayerTeamID INT NOT NULL
            REFERENCES PlayerTeams(ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    RepID INT REFERENCES Reps(ID)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    InPlay BIT NOT NULL,
    WeekEndingDate DATETIME NOT NULL
);

CREATE TABLE RepStatistics (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    RepID INT REFERENCES Reps(ID)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    [Date] DATETIME NOT NULL,
    InField BIT NOT NULL,
    TotalApps DECIMAL NOT NULL,
    CurrentCustomerApps DECIMAL NOT NULL,
    TotalPremium DECIMAL NOT NULL,
    CancelledPremium DECIMAL NOT NULL,
    Referrals INT NOT NULL,
    Score DECIMAL
);

CREATE TABLE TeamScores (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PlayerTeamID INT NOT NULL
            REFERENCES PlayerTeams(ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    WeekEndingDate DATETIME NOT NULL,
    Score INT
);

CREATE TABLE DraftOrders(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PlayerTeamID INT NOT NULL
            REFERENCES PlayerTeams(ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    OrderNumber INT
);

SELECT      name AS [Constraint Name],
            OBJECT_NAME(referenced_object_id) [Referenced Object],
            OBJECT_NAME(parent_object_id) [Parent Object],
            delete_referential_action_desc [ON DELETE],
            update_referential_action_desc [ON UPDATE]
FROM        sys.foreign_keys 

SELECT TOP(5) * FROM RepStatistics;
SELECT TOP(5) * FROM PlayerTeams;
SELECT TOP(5) * FROM TeamReps;
SELECT TOP(5) * FROM TeamScores;
SELECT TOP(5) * FROM Players;
SELECT TOP(5) * FROM Leagues;
SELECT TOP(5) * FROM Reps;
SELECT TOP(5) * FROM Quarters;
SELECT TOP(5) * FROM DraftOrders;