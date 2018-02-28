-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 28, 2018 at 04:44 PM
-- Server version: 5.7.20-0ubuntu0.16.04.1
-- PHP Version: 7.0.25-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pro_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `cid` int(11) NOT NULL,
  `c_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`cid`, `c_name`) VALUES
(1, 'Ricke'),
(2, 'Matto');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `eid` int(11) NOT NULL,
  `rid` int(11) NOT NULL,
  `e_name` varchar(25) NOT NULL,
  `salary` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`eid`, `rid`, `e_name`, `salary`) VALUES
(1, 1, 'Shubham', 20000),
(2, 2, 'Ishwar', 40000),
(3, 3, 'Priti', 20000),
(4, 2, 'Hemin', 41000),
(6, 2, 'mayur', 21000),
(8, 2, 'bhai', 25000);

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `point_count` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
	DECLARE a int;
    
    IF NEW.salary>=50000 THEN
    	SET a=4;
    ELSEIF new.salary>41000 && new.salary<50000 THEN
		SET a=3;
    ELSEIF new.salary>21000 && new.salary<40000 THEN
		SET a=2;
    ELSEIF new.salary>0 && new.salary<20000 THEN
		SET a=1;
    END IF;
INSERT into Point(employee_id,total_point) VALUES (new.eid,a);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `manager`
--

CREATE TABLE `manager` (
  `mid` int(11) NOT NULL,
  `m_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `manager`
--

INSERT INTO `manager` (`mid`, `m_name`) VALUES
(1, 'Mohini'),
(2, 'Ankita');

-- --------------------------------------------------------

--
-- Table structure for table `Point`
--

CREATE TABLE `Point` (
  `point_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `total_point` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Point`
--

INSERT INTO `Point` (`point_id`, `employee_id`, `total_point`) VALUES
(1, 6, 4),
(2, 8, 2),
(3, 4, 4),
(4, 1, 1),
(5, 2, 3),
(6, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `p_id` int(11) NOT NULL,
  `p_name` varchar(30) NOT NULL,
  `Technology` varchar(30) NOT NULL,
  `Duration(in month)` varchar(30) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_manager_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`p_id`, `p_name`, `Technology`, `Duration(in month)`, `start_date`, `end_date`, `status`, `client_id`, `project_manager_id`) VALUES
(1, 'Node Project', 'Node js', '2', '2017-12-01', '2018-02-01', 'running', 1, 2),
(2, 'UPFIT', 'Wordpress', '12', '2017-01-01', '2018-01-01', 'done', 2, 1),
(3, 'Real ad', 'Laravel', '5', '2018-03-01', '2018-07-01', 'pendding', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `project_detail`
--

CREATE TABLE `project_detail` (
  `p_detail_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_detail`
--

INSERT INTO `project_detail` (`p_detail_id`, `employee_id`, `project_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 4, 3),
(5, 4, 2),
(6, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `rid` int(11) NOT NULL,
  `role` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`rid`, `role`) VALUES
(1, 'desineer'),
(2, 'Tester'),
(3, 'Devloper');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`eid`);

--
-- Indexes for table `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`mid`);

--
-- Indexes for table `Point`
--
ALTER TABLE `Point`
  ADD PRIMARY KEY (`point_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`p_id`);

--
-- Indexes for table `project_detail`
--
ALTER TABLE `project_detail`
  ADD PRIMARY KEY (`p_detail_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`rid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `manager`
--
ALTER TABLE `manager`
  MODIFY `mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Point`
--
ALTER TABLE `Point`
  MODIFY `point_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `project_detail`
--
ALTER TABLE `project_detail`
  MODIFY `p_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
