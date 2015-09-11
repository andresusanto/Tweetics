-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 11, 2015 at 03:42 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tweetics`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `username` varchar(30) NOT NULL,
  `category` varchar(30) NOT NULL,
  `keyword` text NOT NULL,
  PRIMARY KEY (`username`,`category`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE IF NOT EXISTS `tweets` (
  `id_tweet` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `category` varchar(30) NOT NULL,
  `tweet_content` text NOT NULL,
  `location_name` varchar(30) NOT NULL,
  `location_pos` varchar(30) NOT NULL,
  `tweet_user` varchar(30) NOT NULL,
  `tweet_pic` varchar(200) NOT NULL,
  `tweet_time` varchar(20) NOT NULL,
  `keyword_match` varchar(30) NOT NULL,
  PRIMARY KEY (`id_tweet`),
  KEY `id_tweet` (`id_tweet`),
  KEY `username` (`username`),
  KEY `category` (`category`),
  KEY `category_2` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=254 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(30) NOT NULL,
  `auth` varchar(52) NOT NULL,
  `algoritma` char(1) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tweets`
--
ALTER TABLE `tweets`
  ADD CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tweets_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`category`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
