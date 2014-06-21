CREATE DATABASE  IF NOT EXISTS `trip_planner_db_v2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `trip_planner_db_v2`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: trip_planner_db_v2
-- ------------------------------------------------------
-- Server version	5.6.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `streetAddress` varchar(100) NOT NULL,
  `city` varchar(25) NOT NULL,
  `state` varchar(25) NOT NULL,
  `zipCode` varchar(25) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `place` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `placeType` tinyint(4) NOT NULL,
  `name` varchar(25) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `addressID` int(11) NOT NULL,
  `openTime` time DEFAULT NULL,
  `closeTime` time DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `addressID_place_idx` (`addressID`),
  CONSTRAINT `addressID_place` FOREIGN KEY (`addressID`) REFERENCES `address` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `placeID` int(11) NOT NULL,
  `restaurantCategory` tinyint(4) NOT NULL,
  `priceCategory` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `placeID_restaurant_idx` (`placeID`),
  CONSTRAINT `placeID_restaurant` FOREIGN KEY (`placeID`) REFERENCES `place` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attraction`
--

DROP TABLE IF EXISTS `attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attraction` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `placeID` int(11) NOT NULL,
  `activityCategory` tinyint(4) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `placeID_attraction_idx` (`placeID`),
  CONSTRAINT `placeID_attraction` FOREIGN KEY (`placeID`) REFERENCES `place` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preference`
--

DROP TABLE IF EXISTS `preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preference` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `minimumRating` float NOT NULL,
  `priceCategory` tinyint(4) NOT NULL,
  `maxDistance` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant_preference`
--

DROP TABLE IF EXISTS `restaurant_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_preference` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `preferenceID` int(11) NOT NULL,
  `preferredRestaurantType` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `preferenceID_restaurant_preference_idx` (`preferenceID`),
  CONSTRAINT `preferenceID_restaurant_preference` FOREIGN KEY (`preferenceID`) REFERENCES `preference` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attraction_preference`
--

DROP TABLE IF EXISTS `attraction_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attraction_preference` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `preferenceID` int(11) NOT NULL,
  `preferredAttractionType` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `preferenceID_attraction_preference_idx` (`preferenceID`),
  CONSTRAINT `preferenceID_attraction_preference` FOREIGN KEY (`preferenceID`) REFERENCES `preference` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_feedback`
--

DROP TABLE IF EXISTS `customer_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_feedback` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `customerName` varchar(25) NOT NULL,
  `customerRating` float NOT NULL,
  `customerReview` varchar(500) DEFAULT NULL,
  `placeID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `placeID_customer_feedback_idx` (`placeID`),
  CONSTRAINT `placeID_customer_feedback` FOREIGN KEY (`placeID`) REFERENCES `place` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lodging`
--

DROP TABLE IF EXISTS `lodging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lodging` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `addressID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `addressID_lodging_idx` (`addressID`),
  CONSTRAINT `addressID_lodging` FOREIGN KEY (`addressID`) REFERENCES `address` (`ID`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(25) NOT NULL,
  `lastName` varchar(25) NOT NULL,
  `userName` varchar(25) NOT NULL,
  `password` varchar(45) NOT NULL,
  `userRole` int(11) NOT NULL,
  `preferenceID` int(11) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `preferenceID_idx` (`preferenceID`),
  CONSTRAINT `preferenceID` FOREIGN KEY (`preferenceID`) REFERENCES `preference` (`ID`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trip` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `lodgingID` int(11) NOT NULL,
  `transportationMode` tinyint(4) DEFAULT NULL,
  `startDateTime` datetime NOT NULL,
  `endDateTime` datetime NOT NULL,
  `preferenceID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `userID_idx` (`userID`),
  KEY `preferenceID_idx` (`preferenceID`),
  KEY `lodgingID_trip_idx` (`lodgingID`),
  CONSTRAINT `userID_trip` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON UPDATE NO ACTION,
  CONSTRAINT `preferenceID_trip` FOREIGN KEY (`preferenceID`) REFERENCES `preference` (`ID`) ON UPDATE NO ACTION,
  CONSTRAINT `lodgingID_trip` FOREIGN KEY (`lodgingID`) REFERENCES `lodging` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itinerary`
--

DROP TABLE IF EXISTS `itinerary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itinerary` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `tripID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `tripID_itinerary_idx` (`tripID`),
  CONSTRAINT `tripID_itinerary` FOREIGN KEY (`tripID`) REFERENCES `trip` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_slot`
--

DROP TABLE IF EXISTS `time_slot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_slot` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `itineraryID` int(11) NOT NULL,
  `placeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `itineraryID_time_slot_idx` (`itineraryID`),
  KEY `placeID_time_slot_idx` (`placeID`),
  CONSTRAINT `itineraryID_time_slot` FOREIGN KEY (`itineraryID`) REFERENCES `itinerary` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `placeID_time_slot` FOREIGN KEY (`placeID`) REFERENCES `place` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `available_time`
--

DROP TABLE IF EXISTS `available_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `available_time` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `tripID` int(11) NOT NULL,
  `startDateTime` datetime NOT NULL,
  `endDateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `tripID_available_time_idx` (`tripID`),
  CONSTRAINT `tripID_available_time` FOREIGN KEY (`tripID`) REFERENCES `trip` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'trip_planner_db_v2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-18 22:27:18
