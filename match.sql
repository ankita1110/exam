-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2018 at 10:49 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `match`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `matchWiseTop10Batsman` (INOUT `mid` INT)  READS SQL DATA
    DETERMINISTIC
select players.name,points.runs as TotalRuns from points INNER JOIN players ON points.playerId=players.id  WHERE matchId=mid GROUP BY playerId ORDER by TotalRuns DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `matchWiseTop10Bowlers` (INOUT `mid` INT)  NO SQL
select players.name,sum(points.catch+points.wicket+(points.stump*2)) as TotalPoints from points INNER JOIN players ON points.playerId=players.id  WHERE matchId=mid GROUP BY playerId ORDER by TotalPoints DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `top10BatsmanlifeTime` ()  NO SQL
select points.playerId,players.name,SUM(points.runs) as TotalRuns from points INNER JOIN players ON points.playerId=players.id GROUP BY playerId ORDER BY TotalRuns DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `top10BowlersLifeTime` ()  READS SQL DATA
    DETERMINISTIC
select points.playerId,players.name,sum(points.catch+points.wicket+(points.stump*2)) as TotalPoints from points INNER JOIN players ON points.playerId=players.id GROUP BY playerId ORDER BY TotalPoints DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `top10ParticipantsTournamentWise` (IN `tid` INT)  NO SQL
Select p.participantId, sum(cnt) as total from participantdetail p INNER join ((Select playerId, SUM(totalPoints) as cnt from points  where matchid in (Select matchId from matchmaster where tournamentId=tid) group by playerId)) pt
on pt.playerId=p.playerId and tournamentId=tid
group by p.participantId ORDER BY total$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tournamentWiseTop10Batsman` (IN `tid` INT)  NO SQL
select players.name,sum(points.runs) as TotalRuns from points INNER JOIN players ON points.playerId=players.id  WHERE matchId in (Select matchid from matchmaster where tournamentid=tid) GROUP BY playerId ORDER by TotalRuns DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tournamentWiseTop10Bowlers` (IN `tid` INT)  NO SQL
select players.name,sum(points.catch+points.wicket+(points.stump*2)) as TotalPoints from points INNER JOIN players ON points.playerId=players.id  WHERE matchId in (Select matchid from matchmaster where tournamentid=tid) GROUP BY playerId ORDER by TotalPoints DESC LIMIT 10$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `matchdetail`
--

CREATE TABLE `matchdetail` (
  `id` int(11) NOT NULL,
  `mmid` int(11) NOT NULL,
  `team1` int(11) NOT NULL,
  `team2` int(11) NOT NULL,
  `winnerTeam` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `matchdetail`
--

INSERT INTO `matchdetail` (`id`, `mmid`, `team1`, `team2`, `winnerTeam`) VALUES
(1, 1, 1, 3, 1),
(2, 2, 2, 1, 2),
(3, 3, 1, 2, 1),
(4, 4, 3, 1, 1),
(5, 5, 2, 1, 1),
(6, 6, 3, 1, 3),
(7, 7, 2, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `matchmaster`
--

CREATE TABLE `matchmaster` (
  `matchId` int(11) NOT NULL,
  `tournamentId` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `location` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `matchmaster`
--

INSERT INTO `matchmaster` (`matchId`, `tournamentId`, `name`, `location`) VALUES
(1, 1, 'match1', 'Bejing'),
(2, 1, 'match2', 'Bejing'),
(3, 2, 'match1', 'Mumbai'),
(4, 2, 'match2', 'Chennai'),
(5, 3, 'match1', 'Huwaei'),
(6, 4, 'match1', 'place1'),
(7, 4, 'match2', 'place2');

-- --------------------------------------------------------

--
-- Table structure for table `participant`
--

CREATE TABLE `participant` (
  `participantId` int(11) NOT NULL,
  `participantName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participant`
--

INSERT INTO `participant` (`participantId`, `participantName`) VALUES
(1, 'Rajeev'),
(2, 'Vanit Maheshwari'),
(3, 'Vaibhav'),
(4, 'Saransh');

-- --------------------------------------------------------

--
-- Table structure for table `participantdetail`
--

CREATE TABLE `participantdetail` (
  `id` int(11) NOT NULL,
  `participantId` int(11) NOT NULL,
  `playerId` int(11) NOT NULL,
  `tournamentId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participantdetail`
--

INSERT INTO `participantdetail` (`id`, `participantId`, `playerId`, `tournamentId`) VALUES
(10, 1, 6, 1),
(1, 1, 14, 1),
(7, 1, 17, 1),
(5, 1, 20, 1),
(8, 1, 21, 1),
(6, 1, 23, 1),
(3, 1, 25, 1),
(9, 1, 27, 1),
(11, 1, 29, 1),
(2, 1, 32, 1),
(4, 1, 33, 1),
(17, 4, 8, 1),
(16, 4, 9, 1),
(18, 4, 12, 1),
(23, 4, 14, 1),
(27, 4, 16, 1),
(28, 4, 22, 1),
(24, 4, 24, 1),
(20, 4, 26, 1),
(15, 4, 27, 1),
(19, 4, 28, 1),
(12, 4, 33, 1);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `teamId` int(11) NOT NULL,
  `playerType` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `name`, `teamId`, `playerType`) VALUES
(1, 'Chris Gayle', 1, 'Bowler'),
(2, 'Rahul dravid', 1, 'Bowler'),
(3, 'Virat kohli', 1, 'Batsman'),
(4, 'Sachin tendulkar', 1, 'Batsman'),
(5, 'Virendra Sewagh', 1, 'Batsman'),
(6, 'Keshav Shah', 1, 'Bowler'),
(7, 'Ram', 1, 'Bowler'),
(8, 'Kartik', 1, 'Batsman'),
(9, 'Punit', 1, 'Batsman'),
(10, 'Raghav', 1, 'Bowler'),
(11, 'Rihaan', 1, 'Batsman'),
(12, 'Krunal', 2, 'Batsman'),
(13, 'Vanit', 2, 'Bowler'),
(14, 'Hardik', 2, 'Batsman'),
(15, 'Sharad Yadav', 2, 'Bowler'),
(16, 'Rahane', 2, 'Batsman'),
(17, 'Deepak', 2, 'Batsman'),
(18, 'Ronak', 2, 'Bowler'),
(19, 'Rishaan', 2, 'Bowler'),
(20, 'Aarnav', 2, 'Batsman'),
(21, 'Pratik', 2, 'Bowler'),
(22, 'Shubham', 2, 'Batsman'),
(23, 'Nikhil', 3, 'Bowler'),
(24, 'MS Dhoni', 3, 'Batsman'),
(25, 'AB De Villers', 3, 'Batsman'),
(26, 'Kailash', 3, 'Bowler'),
(27, 'Jenish ', 3, 'Bowler'),
(28, 'JaiRaj', 3, 'Batsman'),
(29, 'Manav', 3, 'Batsman'),
(30, 'Shaishav', 3, 'Bowler'),
(31, 'Kamal', 3, 'Bowler'),
(32, 'Jayesh', 3, 'Batsman'),
(33, 'Mukund', 3, 'Batsman');

-- --------------------------------------------------------

--
-- Table structure for table `points`
--

CREATE TABLE `points` (
  `id` int(11) NOT NULL,
  `playerId` int(11) NOT NULL,
  `matchId` int(11) NOT NULL,
  `runs` int(11) NOT NULL,
  `catch` int(11) NOT NULL,
  `wicket` int(11) NOT NULL,
  `stump` int(11) NOT NULL,
  `runsPoint` int(11) NOT NULL,
  `totalPoints` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `points`
--

INSERT INTO `points` (`id`, `playerId`, `matchId`, `runs`, `catch`, `wicket`, `stump`, `runsPoint`, `totalPoints`) VALUES
(1, 25, 1, 45, 2, 0, 1, 1, 5),
(2, 23, 1, 55, 3, 3, 0, 2, 8),
(3, 1, 1, 30, 2, 2, 1, 1, 7),
(4, 7, 1, 70, 1, 0, 3, 2, 9),
(5, 6, 1, 50, 3, 0, 0, 2, 5),
(6, 9, 1, 50, 0, 0, 2, 2, 4),
(7, 27, 1, 50, 1, 1, 1, 2, 6),
(8, 33, 1, 40, 2, 0, 0, 1, 3),
(9, 24, 1, 70, 2, 1, 2, 2, 9),
(10, 30, 1, 100, 1, 0, 0, 4, 5),
(11, 29, 1, 100, 1, 1, 1, 4, 8),
(12, 29, 2, 50, 1, 1, 1, 2, 6),
(13, 17, 2, 50, 1, 1, 0, 4, 6),
(14, 20, 2, 60, 2, 0, 0, 2, 4),
(19, 14, 2, 50, 1, 2, 0, 2, 5),
(20, 18, 2, 75, 2, 1, 0, 3, 6),
(21, 17, 3, 60, 1, 1, 0, 2, 4),
(22, 14, 4, 100, 0, 0, 1, 4, 6),
(23, 21, 4, 55, 2, 0, 1, 2, 6),
(24, 9, 4, 60, 1, 1, 1, 2, 6),
(25, 16, 3, 90, 1, 1, 1, 3, 7),
(26, 1, 3, 30, 1, 0, 0, 1, 2),
(27, 28, 5, 40, 2, 1, 1, 1, 6),
(28, 33, 6, 67, 0, 0, 1, 2, 4),
(29, 32, 5, 67, 2, 0, 0, 2, 4),
(30, 7, 5, 80, 0, 0, 0, 3, 3),
(31, 21, 5, 40, 1, 1, 1, 1, 5),
(32, 30, 6, 80, 0, 0, 1, 3, 5),
(33, 17, 6, 100, 2, 0, 0, 4, 6),
(34, 23, 6, 50, 1, 1, 1, 2, 6),
(35, 24, 3, 60, 2, 2, 0, 2, 6),
(36, 21, 2, 30, 1, 1, 0, 1, 3),
(37, 4, 2, 50, 1, 0, 0, 2, 3),
(38, 15, 2, 67, 0, 0, 0, 2, 2),
(39, 23, 2, 30, 0, 0, 1, 1, 3),
(40, 16, 2, 56, 0, 0, 0, 2, 2),
(41, 2, 5, 40, 0, 0, 1, 1, 3),
(42, 5, 5, 70, 0, 0, 1, 2, 4),
(43, 29, 5, 45, 1, 0, 0, 1, 2),
(44, 33, 5, 90, 0, 0, 0, 3, 3),
(45, 1, 5, 30, 1, 0, 0, 1, 2),
(46, 4, 5, 90, 0, 1, 0, 3, 4),
(47, 3, 5, 30, 1, 0, 0, 1, 2),
(48, 8, 5, 90, 0, 1, 0, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `teaminfo`
--

CREATE TABLE `teaminfo` (
  `teamId` int(11) NOT NULL,
  `teamName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teaminfo`
--

INSERT INTO `teaminfo` (`teamId`, `teamName`) VALUES
(1, 'Mumbai Indians'),
(2, 'Rajasthan Royals'),
(3, 'Chennai Superkings');

-- --------------------------------------------------------

--
-- Table structure for table `tournaments`
--

CREATE TABLE `tournaments` (
  `tId` int(11) NOT NULL,
  `tournamentName` varchar(20) NOT NULL,
  `yearCounducted` int(4) NOT NULL,
  `country` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tournaments`
--

INSERT INTO `tournaments` (`tId`, `tournamentName`, `yearCounducted`, `country`) VALUES
(1, 'IPL1', 2015, 'China'),
(2, 'IPL2', 2016, 'India'),
(3, 'IPL3', 2017, 'Japan'),
(4, 'IPL4', 2018, 'Korea');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `matchdetail`
--
ALTER TABLE `matchdetail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mmid` (`mmid`),
  ADD KEY `team1` (`team1`),
  ADD KEY `team2` (`team2`),
  ADD KEY `winnerTeam` (`winnerTeam`);

--
-- Indexes for table `matchmaster`
--
ALTER TABLE `matchmaster`
  ADD PRIMARY KEY (`matchId`),
  ADD KEY `tournamentId` (`tournamentId`);

--
-- Indexes for table `participant`
--
ALTER TABLE `participant`
  ADD PRIMARY KEY (`participantId`);

--
-- Indexes for table `participantdetail`
--
ALTER TABLE `participantdetail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cuk` (`participantId`,`playerId`,`tournamentId`),
  ADD KEY `playerId` (`playerId`),
  ADD KEY `tournamentId` (`tournamentId`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teamId` (`teamId`);

--
-- Indexes for table `points`
--
ALTER TABLE `points`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq` (`matchId`,`playerId`),
  ADD KEY `playerId` (`playerId`);

--
-- Indexes for table `teaminfo`
--
ALTER TABLE `teaminfo`
  ADD PRIMARY KEY (`teamId`);

--
-- Indexes for table `tournaments`
--
ALTER TABLE `tournaments`
  ADD PRIMARY KEY (`tId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `matchdetail`
--
ALTER TABLE `matchdetail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `matchmaster`
--
ALTER TABLE `matchmaster`
  MODIFY `matchId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `participant`
--
ALTER TABLE `participant`
  MODIFY `participantId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `participantdetail`
--
ALTER TABLE `participantdetail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `points`
--
ALTER TABLE `points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `teaminfo`
--
ALTER TABLE `teaminfo`
  MODIFY `teamId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tournaments`
--
ALTER TABLE `tournaments`
  MODIFY `tId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `matchdetail`
--
ALTER TABLE `matchdetail`
  ADD CONSTRAINT `matchdetail_ibfk_1` FOREIGN KEY (`mmid`) REFERENCES `matchmaster` (`matchId`),
  ADD CONSTRAINT `matchdetail_ibfk_2` FOREIGN KEY (`team1`) REFERENCES `teaminfo` (`teamId`),
  ADD CONSTRAINT `matchdetail_ibfk_3` FOREIGN KEY (`team2`) REFERENCES `teaminfo` (`teamId`),
  ADD CONSTRAINT `matchdetail_ibfk_4` FOREIGN KEY (`winnerTeam`) REFERENCES `teaminfo` (`teamId`);

--
-- Constraints for table `matchmaster`
--
ALTER TABLE `matchmaster`
  ADD CONSTRAINT `matchmaster_ibfk_1` FOREIGN KEY (`tournamentId`) REFERENCES `tournaments` (`tId`);

--
-- Constraints for table `participantdetail`
--
ALTER TABLE `participantdetail`
  ADD CONSTRAINT `participantdetail_ibfk_1` FOREIGN KEY (`participantId`) REFERENCES `participant` (`participantId`),
  ADD CONSTRAINT `participantdetail_ibfk_2` FOREIGN KEY (`playerId`) REFERENCES `players` (`id`),
  ADD CONSTRAINT `participantdetail_ibfk_3` FOREIGN KEY (`tournamentId`) REFERENCES `tournaments` (`tId`);

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_2` FOREIGN KEY (`teamId`) REFERENCES `teaminfo` (`teamId`);

--
-- Constraints for table `points`
--
ALTER TABLE `points`
  ADD CONSTRAINT `points_ibfk_1` FOREIGN KEY (`matchId`) REFERENCES `matchdetail` (`id`),
  ADD CONSTRAINT `points_ibfk_2` FOREIGN KEY (`playerId`) REFERENCES `players` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
