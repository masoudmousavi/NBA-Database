-- Masoud Mousavi
-- 9735453
-- Phase 2
-- ========================== create the database ==========================
create database Basketball;

-- ========================== table team ==========================
use Basketball
go

create table Team (
  ID int identity primary key,
  Name varchar(32),
  Stadium varchar(32),
  City varchar(32),
  State varchar(32),
  Conference varchar(32),
  Division varchar(32),
  NumberOfChampionships int default 0
);

-- ========================== fill table team ==========================
use Basketball
go

insert into Team(Name, Stadium, City, State, Conference, Division, NumberOfChampionships)
   values
       ('Golden State Warriors', 'Chase Center', 'San Francisco', 'California', 'Western', 'Pacific', 0),
       ('New York Knicks', 'Madison Square Garden', 'New York City', 'New York', 'Eastern', 'Atlantic', 0),
       ('San Antonio Spurs', 'AT&T Center', 'San Antonio', 'Texas', 'Western', 'Southwest', 0),
       ('Chicago Bulls', 'United Center', 'Chicago', 'Illinois', 'Eastern', 'Central', 0);

select * from Team;

-- ========================== table player ==========================
use Basketball
go

create table Player (
  ID int identity primary key,
  FirstName varchar(32),
  LastName varchar(32),
  Position char(2),
  IsRetired int default 0,
  YearDrafted int,
  check(
    IsRetired in (0, 1)
  ),
  check(
    Position in ('PG', 'SG', 'SF', 'PF', 'C')
  )
);

-- ========================== fill table player ==========================
use Basketball
go

insert into Player(FirstName, LastName, Position, IsRetired, YearDrafted)
   values
       ('Stephen', 'Curry', 'PG', 0, 2009),
       ('Klay', 'Thompson', 'SG', 0, 2011),
       ('Draymond', 'Green', 'PF', 0, 2012),
       ('Andre', 'Iguodala', 'SF', 0, 2004),
       ('Kevon', 'Looney', 'C', 0, 2015),
       ('Jordan', 'Poole', 'SG', 0, 2019),

       ('Julius', 'Randle', 'PF', 0, 2014),
       ('Kemba', 'Walker', 'PG', 0, 2011),
       ('Derek', 'Rose', 'PG', 0, 2008),
       ('Mitchel', 'Robinson', 'C', 0, 2018),
       ('Evan', 'Fournier', 'SG', 0, 2012),
       ('RJ', 'Barrett', 'SF', 0, 2019),

       ('Bryn', 'Forbes', 'PG', 0, 2016),
       ('Joshua', 'Primo', 'SG', 0, 2021),
       ('Dejounte', 'Murray', 'PG', 0, 2016),
       ('Keita', 'Bates-Diop', 'SF', 0, 2018),
       ('Zach', 'Collins', 'PF', 0, 2017),
       ('Jack', 'Landale', 'C', 0, 2018),

       ('Zach', 'LaVine', 'SG', 0, 2014),
       ('Lonzo', 'Ball', 'PG', 0, 2017),
       ('DeMar', 'DeRozan', 'SF', 0, 2009),
       ('Alex', 'Caruso', 'PG', 0, 2016),
       ('Nikola', 'Vucevic', 'C', 0, 2011),
       ('Alize', 'Johnson', 'PF', 0, 2018),

       ('Shaquille', 'O''Neal', 'C', 1, 1992),
       ('Michael', 'Jordan', 'SG', 1, 1984);

select * from Player;

-- ========================== table coach ==========================
use Basketball
go

create table Coach (
  ID int identity primary key,
  FirstName varchar(32),
  LastName varchar(32),
  IsRetired int default 0
);

-- ========================== fill table coach ==========================
use Basketball
go

insert into Coach(FirstName, LastName, IsRetired)
   values
       ('Steve', 'Kerr', 0),
       ('Billy', 'Donovan', 0),
       ('Gregg', 'Poppovich', 0),
       ('Tom', 'Thibodeau', 0)

select * from Coach;

-- ========================== table match ==========================
use Basketball
go

create table Match (
  ID int identity primary key,
  HomeID int foreign key references Team,
  AwayID int foreign key references Team,
  IsOngoing int default 1,
  HomeResult int default 0,
  AwayResult int default 0,
  StartDate datetime,
  check (
    HomeResult > -1
  ),
  check (
    AwayResult > -1
  ),
  check (
    IsOngoing in (0, 1)
  )
);

-- ========================== fill table match ==========================
use Basketball
go

insert into Match(HomeID, AwayID, IsOngoing, HomeResult, AwayResult, StartDate)
   values
      (1, 2, 0, 100, 80, '01/01/2021 13:00'),
      (3, 4, 0, 85, 95, '02/01/2021 14:00'),
      (4, 1, 0, 90, 92, '04/01/2021 13:00'),
      (2, 3, 0, 100, 96, '06/01/2021 16:00')

select * from Match;

-- ========================== table quarter ==========================
use Basketball
go

create table Quarter (
  ID int identity primary key,
  MatchID int foreign key references Match,
  Quarter varchar(2),
  StartTime datetime,
  IsOngoing int default 1,
  HomeResult int default 0,
  AwayResult int default 0,
  check (
    HomeResult > -1
  ),
  check (
    AwayResult > -1
  ),
  check (
    IsOngoing in (0, 1)
  ),
  check (
    Quarter in ('1', '2', '3', '4', 'OT')
  )
);

-- ========================== fill table quarter ==========================
use Basketball
go

insert into Quarter(MatchID, Quarter, StartTime, IsOngoing, HomeResult, AwayResult)
   values
      (1, '1', '01/01/2021 13:00', 0, 25, 20),
      (1, '2', '01/01/2021 13:30', 0, 25, 20),
      (1, '3', '01/01/2021 14:00', 0, 25, 20),
      (1, '4', '01/01/2021 14:30', 0, 25, 20),

      (2, '1', '02/01/2021 14:00', 0, 25, 20),
      (2, '2', '02/01/2021 14:25', 0, 25, 35),
      (2, '3', '02/01/2021 15:00', 0, 20, 25),
      (2, '4', '02/01/2021 15:30', 0, 15, 15),

      (3, '1', '04/01/2021 13:00', 0, 20, 20),
      (3, '2', '04/01/2021 13:30', 0, 20, 20),
      (3, '3', '04/01/2021 14:00', 0, 20, 20),
      (3, '4', '04/01/2021 14:20', 0, 20, 20),
      (3, 'OT', '04/01/2021 14:50', 0, 10, 12),

      (4, '1', '06/01/2021 16:00', 0, 25, 24),
      (4, '2', '06/01/2021 16:25', 0, 25, 24),
      (4, '3', '06/01/2021 16:50', 0, 25, 24),
      (4, '4', '06/01/2021 17:30', 0, 25, 24)

select * from Quarter;

-- ========================== table played for ==========================
use Basketball
go

create table PlayedFor (
  ID int identity primary key,
  QuarterID int foreign key references Quarter,
  PlayerID int foreign key references Player,
  TeamID int foreign key references Team,
  Minutes int,
  check (
    Minutes > -1
  )
);

-- ========================== fill table played for ==========================
use Basketball
go

insert into PlayedFor(QuarterID, PlayerID, TeamID, Minutes)
   values
      (1, 1, 1, 12),
      (1, 2, 1, 12),
      (1, 3, 1, 12),
      (1, 4, 1, 12),
      (1, 5, 1, 12),
      (2, 1, 1, 12),
      (2, 2, 1, 12),
      (2, 3, 1, 12),
      (2, 4, 1, 12),
      (2, 6, 1, 12),
      (3, 1, 1, 12),
      (3, 2, 1, 12),
      (3, 3, 1, 12),
      (3, 5, 1, 12),
      (3, 6, 1, 12),
      (4, 1, 1, 12),
      (4, 2, 1, 12),
      (4, 4, 1, 12),
      (4, 5, 1, 12),
      (4, 6, 1, 12),

      (1, 7, 2, 12),
      (1, 8, 2, 12),
      (1, 9, 2, 12),
      (1, 10, 2, 12),
      (1, 11, 2, 12),
      (2, 7, 2, 12),
      (2, 12, 2, 12),
      (2, 9, 2, 12),
      (2, 10, 2, 12),
      (2, 11, 2, 12),
      (3, 7, 2, 12),
      (3, 8, 2, 12),
      (3, 9, 2, 12),
      (3, 12, 2, 12),
      (3, 11, 2, 12),
      (4, 7, 2, 12),
      (4, 8, 2, 12),
      (4, 9, 2, 12),
      (4, 12, 2, 12),
      (4, 11, 2, 12),

      (5, 13, 3, 12),
      (5, 14, 3, 12),
      (5, 16, 3, 12),
      (5, 17, 3, 12),
      (5, 18, 3, 12),
      (6, 13, 3, 12),
      (6, 14, 3, 12),
      (6, 15, 3, 12),
      (6, 17, 3, 12),
      (6, 18, 3, 12),
      (7, 14, 3, 12),
      (7, 15, 3, 12),
      (7, 16, 3, 12),
      (7, 17, 3, 12),
      (7, 18, 3, 12),
      (8, 13, 3, 12),
      (8, 14, 3, 12),
      (8, 15, 3, 12),
      (8, 16, 3, 12),
      (8, 18, 3, 12),

      (5, 19, 4, 12),
      (5, 20, 4, 12),
      (5, 21, 4, 12),
      (5, 22, 4, 12),
      (5, 23, 4, 12),
      (6, 19, 4, 12),
      (6, 20, 4, 12),
      (6, 21, 4, 12),
      (6, 22, 4, 12),
      (6, 24, 4, 12),
      (7, 19, 4, 12),
      (7, 20, 4, 12),
      (7, 21, 4, 12),
      (7, 23, 4, 12),
      (7, 24, 4, 12),
      (8, 19, 4, 12),
      (8, 20, 4, 12),
      (8, 22, 4, 12),
      (8, 23, 4, 12),
      (8, 24, 4, 12),

      (9, 19, 4, 12),
      (9, 20, 4, 12),
      (9, 21, 4, 12),
      (9, 23, 4, 12),
      (9, 24, 4, 12),
      (10, 19, 4, 12),
      (10, 20, 4, 12),
      (10, 21, 4, 12),
      (10, 22, 4, 12),
      (10, 24, 4, 12),
      (11, 19, 4, 12),
      (11, 20, 4, 12),
      (11, 22, 4, 12),
      (11, 23, 4, 12),
      (11, 24, 4, 12),
      (12, 19, 4, 12),
      (12, 20, 4, 12),
      (12, 21, 4, 12),
      (12, 22, 4, 12),
      (12, 23, 4, 12),
      (13, 19, 4, 5),
      (13, 21, 4, 5),
      (13, 22, 4, 5),
      (13, 24, 4, 5),
      (13, 23, 4, 5),

      (9, 1, 1, 12),
      (9, 2, 1, 12),
      (9, 3, 1, 12),
      (9, 4, 1, 12),
      (9, 5, 1, 12),
      (10, 1, 1, 12),
      (10, 2, 1, 12),
      (10, 3, 1, 12),
      (10, 4, 1, 12),
      (10, 6, 1, 12),
      (11, 1, 1, 12),
      (11, 2, 1, 12),
      (11, 3, 1, 12),
      (11, 5, 1, 12),
      (11, 6, 1, 12),
      (12, 1, 1, 12),
      (12, 2, 1, 12),
      (12, 4, 1, 12),
      (12, 5, 1, 12),
      (12, 6, 1, 12),
      (13, 1, 1, 5),
      (13, 6, 1, 5),
      (13, 3, 1, 5),
      (13, 4, 1, 5),
      (13, 5, 1, 5),

      (14, 7, 2, 12),
      (14, 8, 2, 12),
      (14, 9, 2, 12),
      (14, 10, 2, 12),
      (14, 11, 2, 12),
      (15, 7, 2, 12),
      (15, 12, 2, 12),
      (15, 9, 2, 12),
      (15, 10, 2, 12),
      (15, 11, 2, 12),
      (16, 7, 2, 12),
      (16, 8, 2, 12),
      (16, 9, 2, 12),
      (16, 12, 2, 12),
      (16, 11, 2, 12),
      (17, 7, 2, 12),
      (17, 8, 2, 12),
      (17, 9, 2, 12),
      (17, 12, 2, 12),
      (17, 11, 2, 12),

      (14, 13, 3, 12),
      (14, 14, 3, 12),
      (14, 16, 3, 12),
      (14, 17, 3, 12),
      (14, 18, 3, 12),
      (15, 13, 3, 12),
      (15, 14, 3, 12),
      (15, 15, 3, 12),
      (15, 17, 3, 12),
      (15, 18, 3, 12),
      (16, 14, 3, 12),
      (16, 15, 3, 12),
      (16, 16, 3, 12),
      (16, 17, 3, 12),
      (16, 18, 3, 12),
      (17, 13, 3, 12),
      (17, 14, 3, 12),
      (17, 15, 3, 12),
      (17, 16, 3, 12),
      (17, 18, 3, 12);

select * from PlayedFor;

-- ========================== table coached for ==========================
use Basketball
go

create table CoachedFor (
  ID int identity primary key,
  CoachID int foreign key references Coach,
  TeamID int foreign key references Team,
  StartTime datetime
);

-- ========================== fill table coach ==========================
use Basketball
go

insert into CoachedFor(CoachID, TeamID, StartTime)
   values
       (1, 1, '1/05/2014 0:0'),
       (2, 4, '1/09/2020 0:0'),
       (3, 3, '1/11/1996 0:0'),
       (2, 2, '1/07/2020 0:0')

select * from CoachedFor;

-- ========================== table BoxScore ==========================
use Basketball
go

create table BoxScore (
  ID int identity primary key,
  PlayedForID int foreign key references PlayedFor,
  Type varchar(10),
  ScoredTime Timestamp,
  check(
    Type in ('Field Goal', 'Free Throw', '3 Pointer', 'Block', 'Steal', 'Rebound', 'Assist')
  )
);

-- ========================== fill table box score ==========================
use Basketball
go

insert into BoxScore(PlayedForID, Type, ScoredTime)
   values
      (1, 'Block', null),
      (1, 'Steal', null),
      (1, '3 Pointer', null),
      (1, '3 Pointer', null),
      (1, '3 Pointer', null),
      (1, '3 Pointer', null),

      (2, 'Block', null),
      (2, 'Steal', null),
      (2, 'Assist', null),
      (2, 'Block', null),
      (2, '3 Pointer', null),
      (2, '3 Pointer', null),

      (9, 'Block', null),
      (11, 'Steal', null),
      (10, 'Assist', null),
      (9, 'Block', null),
      (8, 'Rebound', null),
      (6, '3 Pointer', null),

      (1, 'Block', null),
      (3, 'Steal', null),
      (5, 'Assist', null),
      (6, 'Block', null),
      (7, '3 Pointer', null),
      (8, '3 Pointer', null),

      (10, 'Rebound', null),
      (10, 'Steal', null),
      (10, 'Assist', null),
      (10, 'Block', null),
      (10, 'Rebound', null),
      (10, '3 Pointer', null);

select * from BoxScore;

-- ========================== view match results =======================
use Basketball
go

create or alter view MatchResults as
  select HT.Name as 'Home Team', cast(M.HomeResult as varchar(3)) + ' - ' + cast(M.AwayResult as varchar(3)) as Result, AT.Name as 'Away Team'
  from Match M
    inner join Team HT on (M.HomeID = HT.ID)
      inner join Team AT on (M.AwayID = AT.ID);

go

select * from MatchResults;

-- ========================== view active players =======================
use Basketball
go

create or alter view ActivePlayers as
  select *
  from Player
  where IsRetired = 0;

go

select * from ActivePlayers;

-- ========================== view ongoing matches =======================
use Basketball
go

create or alter view OngoingMatches as
  select *
  from Match
  where IsOngoing = 1;

go

select * from OngoingMatches;

-- ========================== function player teams =======================
use Basketball
go

if object_id(N'dbo.funcGetPlayerTeamHistory', N'FN') is not null
  drop function dbo.funcGetPlayerTeamHistory;

go
create or alter function dbo.funcGetPlayerTeamHistory(@PlayerID int)
  returns table
as
  return (
    select distinct T.Name as 'Team'
    from PlayedFor PF
      inner join Team T on (PF.TeamID = T.ID)
    where PF.PlayerID = @PlayerID
  );
go

select * from dbo.funcGetPlayerTeamHistory(1);

-- ========================== function teams home wins =======================
use Basketball
go

if object_id(N'dbo.funcGetTeamHomeWins', N'FN') is not null
  drop function dbo.funcGetTeamHomeWins;

go
create or alter function dbo.funcGetTeamHomeWins(@TeamID int, @season int)
  returns table
as
  return (
    select count(*) as Wins
    from Match M
    where M.HomeID = @TeamID
          and M.HomeResult > M.AwayResult
          and (
            month(M.StartDate) between 10 and 12 and year(M.StartDate) = @season -1
            or month(M.StartDate) < 5 and year(M.StartDate) = @season
          )
  );
go

select * from dbo.funcGetTeamHomeWins(1, 2021);

-- ========================== function teams away wins =======================
use Basketball
go

if object_id(N'dbo.funcGetTeamAwayWIns', N'FN') is not null
  drop function dbo.funcGetTeamAwayWins;

go
create or alter function dbo.funcGetTeamAwayWins(@TeamID int, @season int)
  returns table
as
  return (
    select count(*) as Wins
    from Match M
    where M.AwayID = @TeamID
          and M.HomeResult < M.AwayResult
          and (
            month(M.StartDate) between 10 and 12 and year(M.StartDate) = @season -1
            or month(M.StartDate) < 5 and year(M.StartDate) = @season
          )
  );
go

select * from dbo.funcGetTeamAwayWins(1, 2021);

-- ========================== function teams home losses =======================
use Basketball
go

if object_id(N'dbo.funcGetTeamHomeLosses', N'FN') is not null
  drop function dbo.funcGetTeamHomeLosses;

go
create or alter function dbo.funcGetTeamHomeLosses(@TeamID int, @season int)
  returns table
as
  return (
    select count(*) as Losses
    from Match M
    where M.HomeID = @TeamID
          and M.HomeResult < M.AwayResult
          and (
            month(M.StartDate) between 10 and 12 and year(M.StartDate) = @season -1
            or month(M.StartDate) < 5 and year(M.StartDate) = @season
          )
  );
go

select * from dbo.funcGetTeamHomeLosses(1, 2021);

-- ========================== function teams away losses =======================
use Basketball
go

if object_id(N'dbo.funcGetTeamAwayLosses', N'FN') is not null
  drop function dbo.funcGetTeamAwayLosses;

go
create or alter function dbo.funcGetTeamAwayLosses(@TeamID int, @season int)
  returns table
as
  return (
    select count(*) as Wins
    from Match M
    where M.AwayID = @TeamID
          and M.HomeResult > M.AwayResult
          and (
            month(M.StartDate) between 10 and 12 and year(M.StartDate) = @season -1
            or month(M.StartDate) < 5 and year(M.StartDate) = @season
          )
  );
go

select * from dbo.funcGetTeamAwayLosses(1, 2021);

-- ========================== procedure teams wins and losses =======================
use Basketball
go

create or alter procedure dbo.procGetTeamResults
  @TeamID int,
  @Season int,
  @Wins int output,
  @Losses int output
as
begin
  set @Wins = (select * from dbo.funcGetTeamHomeWins(@TeamID, @Season)) + (select * from dbo.funcGetTeamAwayWins(@TeamID, @Season));
  set @Losses =  (select * from dbo.funcGetTeamHomeLosses(@TeamID, @Season)) + (select * from dbo.funcGetTeamAwayLosses(@TeamID, @Season));
end;

go

declare @wins int;
declare @losses int;
execute dbo.procGetTeamResults 1, 2021, @wins output, @losses output;
select @wins as 'GSW Wins', @losses as 'GSW Losses';

-- ========================== procedure season ranking =======================
use Basketball
go

create or alter procedure dbo.procGetSeasonRanking
  @Season int
as
begin
  select T.Name, (select * from dbo.funcGetTeamHomeWins(T.ID, @Season)) + (select * from dbo.funcGetTeamAwayWins(T.ID, @Season)) as Wins,
                (select * from dbo.funcGetTeamHomeLosses(T.ID, @Season)) + (select * from dbo.funcGetTeamAwayLosses(T.ID, @Season)) as Losses
  from Team T
  order by Wins desc, Losses asc
end;

go

execute dbo.procGetSeasonRanking 2021;

-- ========================== procedure season box score ranking =======================
use Basketball
go

create or alter procedure dbo.procGetSeasonBoxScoreRanking
  @Season int,
  @BoxScoreType varchar(10)
as
begin
  select P.FirstName + ' ' + P.LastName as Name, T.Name as 'Team', count(*) as 'Count'
  from Player P
    inner join PlayedFor PF on (P.ID = PF.PlayerID)
      inner join BoxScore BS on (BS.PlayedForID = PF.ID)
        inner join Team T on (PF.TeamID = T.ID)
  where BS.Type = @BoxScoreType
  group by P.FirstName + ' ' + P.LastName, T.Name
  order by 'Count' desc
end;

go

execute dbo.procGetSeasonBoxScoreRanking 2021, 'Block';
execute dbo.procGetSeasonBoxScoreRanking 2021, 'Rebound';

-- ========================== trigger update match after 3 pointer =======================
use Basketball
go
create or alter trigger dbo.triggerUpdateMatchResult3Pointer
  on BoxScore
  after insert
as

begin
  update M
  set M.HomeResult = M.HomeResult + 3
  from Match M
    inner join Quarter Q on (M.ID = Q.MatchID)
      inner join PlayedFor PF on (PF.QuarterID = Q.ID)
        inner join inserted I on (I.PlayedForID = PF.ID)
  where M.IsOngoing = 1
    and PF.TeamID = M.AwayID
    and I.Type = '3 Pointer';

  update M
  set M.AwayResult = M.AwayResult + 3
  from Match M
    inner join Quarter Q on (M.ID = Q.MatchID)
      inner join PlayedFor PF on (PF.QuarterID = Q.ID)
        inner join inserted I on (I.PlayedForID = PF.ID)
  where M.IsOngoing = 1
    and PF.TeamID = M.AwayID
    and I.Type = '3 Pointer';
end;

go

-- ========================== trigger update match after field goal =======================
use Basketball
go
create or alter trigger dbo.triggerUpdateMatchResultFieldGoal
  on BoxScore
  after insert
as

begin
  update M
  set M.HomeResult = M.HomeResult + 2
  from Match M
    inner join Quarter Q on (M.ID = Q.MatchID)
      inner join PlayedFor PF on (PF.QuarterID = Q.ID)
        inner join inserted I on (I.PlayedForID = PF.ID)
  where M.IsOngoing = 1
    and PF.TeamID = M.AwayID
    and I.Type = 'Field Goal';

  update M
  set M.AwayResult = M.AwayResult + 2
  from Match M
    inner join Quarter Q on (M.ID = Q.MatchID)
      inner join PlayedFor PF on (PF.QuarterID = Q.ID)
        inner join inserted I on (I.PlayedForID = PF.ID)
  where M.IsOngoing = 1
    and PF.TeamID = M.AwayID
    and I.Type = 'Filed Goal';
end;

go
-- ========================== trigger update match after free throw =======================
use Basketball
go
create or alter trigger dbo.triggerUpdateMatchResultFreeThrow
  on BoxScore
  after insert
as

begin
  update M
  set M.HomeResult = M.HomeResult + 1
  from Match M
    inner join Quarter Q on (M.ID = Q.MatchID)
      inner join PlayedFor PF on (PF.QuarterID = Q.ID)
        inner join inserted I on (I.PlayedForID = PF.ID)
  where M.IsOngoing = 1
    and PF.TeamID = M.AwayID
    and I.Type = 'Free Throw';

  update M
  set M.AwayResult = M.AwayResult + 1
  from Match M
    inner join Quarter Q on (M.ID = Q.MatchID)
      inner join PlayedFor PF on (PF.QuarterID = Q.ID)
        inner join inserted I on (I.PlayedForID = PF.ID)
  where M.IsOngoing = 1
    and PF.TeamID = M.AwayID
    and I.Type = 'Free Throw';
end;

go


-- ============================ backup data base ===========================
backup database Basketball to disk = 'F:\Basketball.bak';
