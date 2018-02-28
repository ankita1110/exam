-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 26, 2018 at 09:38 AM
-- Server version: 5.7.19
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbcricketdream11`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblmatch`
--

DROP TABLE IF EXISTS `tblmatch`;
CREATE TABLE IF NOT EXISTS `tblmatch` (
  `match_id` int(3) NOT NULL AUTO_INCREMENT,
  `match_date` date NOT NULL,
  PRIMARY KEY (`match_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblmatch`
--

INSERT INTO `tblmatch` (`match_id`, `match_date`) VALUES
(1, '2007-04-10'),
(2, '2007-04-10');

-- --------------------------------------------------------

--
-- Table structure for table `tblmatch_detail`
--

DROP TABLE IF EXISTS `tblmatch_detail`;
CREATE TABLE IF NOT EXISTS `tblmatch_detail` (
  `match_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `tournament_id` int(2) NOT NULL,
  `participant_id` int(8) NOT NULL,
  `player_id` int(5) NOT NULL,
  `match_id` int(3) NOT NULL,
  `runs` int(3) NOT NULL,
  `wicket` int(1) NOT NULL,
  `catches` int(1) NOT NULL,
  `stumping` int(1) NOT NULL,
  `point` int(5) NOT NULL,
  PRIMARY KEY (`match_detail_id`),
  KEY `tournament_id` (`tournament_id`),
  KEY `participant_id` (`participant_id`),
  KEY `player_id` (`player_id`),
  KEY `match_id` (`match_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblmatch_detail`
--

INSERT INTO `tblmatch_detail` (`match_detail_id`, `tournament_id`, `participant_id`, `player_id`, `match_id`, `runs`, `wicket`, `catches`, `stumping`, `point`) VALUES
(1, 1, 1, 1, 1, 26, 1, 1, 0, 3),
(2, 1, 1, 2, 1, 27, 1, 1, 0, 3),
(3, 1, 1, 2, 1, 28, 1, 1, 0, 3),
(4, 1, 1, 1, 2, 29, 1, 1, 0, 3),
(5, 1, 2, 5, 2, 100, 1, 1, 1, 8),
(6, 1, 1, 5, 2, 100, 1, 1, 1, 8),
(7, 1, 1, 16, 1, 100, 1, 1, 2, 10),
(8, 1, 2, 8, 2, 102, 1, 1, 2, 10),
(9, 1, 1, 7, 1, 102, 1, 1, 0, 6),
(10, 2, 2, 5, 1, 150, 0, 2, 2, 10),
(11, 2, 1, 19, 1, 140, 0, 3, 2, 11),
(12, 2, 1, 26, 2, 130, 0, 3, 2, 11),
(13, 2, 1, 21, 2, 150, 2, 2, 2, 12),
(14, 2, 2, 27, 2, 170, 2, 2, 2, 12),
(15, 2, 1, 25, 2, 140, 2, 2, 2, 12);

--
-- Triggers `tblmatch_detail`
--
DROP TRIGGER IF EXISTS `addTotalPointsToParticipant1`;
DELIMITER $$
CREATE TRIGGER `addTotalPointsToParticipant1` AFTER INSERT ON `tblmatch_detail` FOR EACH ROW BEGIN
	DECLARE total int;    
    select tblparticipant.total_points INTO total from tblparticipant where tblparticipant.participant_id=new.participant_id;
    
    UPDATE tblparticipant SET tblparticipant.total_points=total+NEW.point WHERE tblparticipant.participant_id=new.participant_id; 
    
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `calculatePointsTrigger`;
DELIMITER $$
CREATE TRIGGER `calculatePointsTrigger` BEFORE INSERT ON `tblmatch_detail` FOR EACH ROW BEGIN	
    IF NEW.runs>=100 THEN
    	SET new.point=4;
    END IF;
    
    IF NEW.runs>=75 and NEW.runs<=99 THEN
    	SET new.point=new.point+3;
    END IF;

	IF NEW.runs>=50 and NEW.runs<=74 THEN
    	SET new.point=new.point+2;
    END IF;

	IF NEW.runs>=25 AND NEW.runs<=49 THEN
    	SET new.point=new.point+1;
    END IF;

	IF NEW.wicket>0 THEN
    	SET new.point=new.point+(new.wicket*1);
    END IF;

	IF NEW.catches>0 THEN
    	SET new.point=new.point+(new.catches*1);
    END IF;
	
    IF NEW.stumping>0 THEN
    	SET new.point=new.point+(new.stumping*2);
    END IF;
	
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblparticipant`
--

DROP TABLE IF EXISTS `tblparticipant`;
CREATE TABLE IF NOT EXISTS `tblparticipant` (
  `participant_id` int(11) NOT NULL AUTO_INCREMENT,
  `participant_name` varchar(25) NOT NULL,
  `total_points` int(8) NOT NULL,
  PRIMARY KEY (`participant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblparticipant`
--

INSERT INTO `tblparticipant` (`participant_id`, `participant_name`, `total_points`) VALUES
(1, 'Ajeet Singh', 82),
(2, 'Snehal Shah', 40);

-- --------------------------------------------------------

--
-- Table structure for table `tblplayer`
--

DROP TABLE IF EXISTS `tblplayer`;
CREATE TABLE IF NOT EXISTS `tblplayer` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_name` varchar(70) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblplayer`
--

INSERT INTO `tblplayer` (`player_id`, `player_name`) VALUES
(1, 'Sandeep Purohit'),
(2, 'Yuval Prajapati'),
(3, 'Suresh Raina'),
(4, 'MS Dhoni'),
(5, 'AB Devilliars'),
(6, 'David Warner'),
(7, 'Chahal'),
(8, 'Kuldeep '),
(9, 'Virat Kohli'),
(10, 'Rohit Sharma'),
(11, 'Samuels'),
(12, 'Badree'),
(13, 'Kane Williamson'),
(14, 'Ross Taylor'),
(15, 'Hiren Tariwala'),
(16, 'Kunjan'),
(17, 'Rahane'),
(18, 'Gambhir'),
(19, 'Uthhappa'),
(20, 'Manish Pandey'),
(21, 'Subodh Sir'),
(22, 'Mukesh Singh'),
(23, 'Bhuvneshvar Kumar'),
(24, 'Bumrah'),
(25, 'Ashwin'),
(26, 'Jadeja'),
(27, 'Rashid Khan'),
(28, 'Pavan Negi'),
(29, 'Ishan Kishan'),
(30, 'Zaheer Khan'),
(31, 'JP Duminy'),
(32, 'Faf Du Plessis'),
(33, 'Rabada'),
(34, 'Morkel'),
(35, 'Praveen Tambe'),
(36, 'Shakib Al Hassan');

-- --------------------------------------------------------

--
-- Table structure for table `tblplaying11`
--

DROP TABLE IF EXISTS `tblplaying11`;
CREATE TABLE IF NOT EXISTS `tblplaying11` (
  `playing11_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(4) NOT NULL,
  `team_id` int(2) NOT NULL,
  PRIMARY KEY (`playing11_id`),
  KEY `player_id` (`player_id`),
  KEY `team_id` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblplaying11`
--

INSERT INTO `tblplaying11` (`playing11_id`, `player_id`, `team_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 5, 1),
(4, 26, 1),
(5, 23, 1),
(6, 32, 1),
(7, 16, 1),
(8, 8, 1),
(9, 18, 1),
(10, 33, 1),
(11, 11, 1),
(12, 5, 2),
(13, 4, 2),
(14, 2, 2),
(15, 31, 2),
(16, 6, 2),
(17, 20, 2),
(18, 23, 2),
(19, 34, 2),
(20, 24, 2),
(21, 17, 2),
(22, 16, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tblteam`
--

DROP TABLE IF EXISTS `tblteam`;
CREATE TABLE IF NOT EXISTS `tblteam` (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `participant_id` int(8) NOT NULL,
  `team_name` varchar(20) NOT NULL,
  PRIMARY KEY (`team_id`),
  KEY `participant_id` (`participant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblteam`
--

INSERT INTO `tblteam` (`team_id`, `participant_id`, `team_name`) VALUES
(1, 1, 'Royal Strikers'),
(2, 2, 'RR');

-- --------------------------------------------------------

--
-- Table structure for table `tbltournament`
--

DROP TABLE IF EXISTS `tbltournament`;
CREATE TABLE IF NOT EXISTS `tbltournament` (
  `tournament_id` int(11) NOT NULL AUTO_INCREMENT,
  `tournament_name` varchar(20) NOT NULL,
  `tournament_year` date NOT NULL,
  PRIMARY KEY (`tournament_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbltournament`
--

INSERT INTO `tbltournament` (`tournament_id`, `tournament_name`, `tournament_year`) VALUES
(1, 'IPLT20', '2007-04-08'),
(2, 'LPLT20', '2018-02-10');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblmatch_detail`
--
ALTER TABLE `tblmatch_detail`
  ADD CONSTRAINT `tblmatch_detail_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `tbltournament` (`tournament_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblmatch_detail_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `tblparticipant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblmatch_detail_ibfk_3` FOREIGN KEY (`player_id`) REFERENCES `tblplayer` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblmatch_detail_ibfk_4` FOREIGN KEY (`match_id`) REFERENCES `tblmatch` (`match_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblplaying11`
--
ALTER TABLE `tblplaying11`
  ADD CONSTRAINT `tblplaying11_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `tblplayer` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblplaying11_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `tblteam` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblteam`
--
ALTER TABLE `tblteam`
  ADD CONSTRAINT `tblteam_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `tblparticipant` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
