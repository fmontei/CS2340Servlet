SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema trip_planner_db_v2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trip_planner_db_v2` DEFAULT CHARACTER SET utf8 ;
USE `trip_planner_db_v2` ;

-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`address` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `streetAddress` VARCHAR(100) NOT NULL,
  `city` VARCHAR(25) NOT NULL,
  `state` VARCHAR(25) NOT NULL,
  `zipCode` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`place` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `placeType` TINYINT(4) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `addressID` INT(11) NOT NULL,
  `openTime` TIME NULL DEFAULT NULL,
  `closeTime` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `addressID_place_idx` (`addressID` ASC),
  CONSTRAINT `addressID_place`
    FOREIGN KEY (`addressID`)
    REFERENCES `trip_planner_db_v2`.`address` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`attraction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`attraction` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `placeID` INT(11) NOT NULL,
  `activityCategory` TINYINT(4) NOT NULL,
  `cost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `placeID_attraction_idx` (`placeID` ASC),
  CONSTRAINT `placeID_attraction`
    FOREIGN KEY (`placeID`)
    REFERENCES `trip_planner_db_v2`.`place` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`preference` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `minimumRating` FLOAT NOT NULL,
  `priceCategory` TINYINT(4) NOT NULL,
  `maxDistance` INT(11) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`attraction_preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`attraction_preference` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `preferenceID` INT(11) NOT NULL,
  `preferredAttractionType` TINYINT(4) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `preferenceID_attraction_preference_idx` (`preferenceID` ASC),
  CONSTRAINT `preferenceID_attraction_preference`
    FOREIGN KEY (`preferenceID`)
    REFERENCES `trip_planner_db_v2`.`preference` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`user` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(25) NOT NULL,
  `lastName` VARCHAR(25) NOT NULL,
  `userName` VARCHAR(25) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `userRole` INT(11) NOT NULL,
  `preferenceID` INT(11) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `preferenceID_idx` (`preferenceID` ASC),
  CONSTRAINT `preferenceID`
    FOREIGN KEY (`preferenceID`)
    REFERENCES `trip_planner_db_v2`.`preference` (`ID`)
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`lodging`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`lodging` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `addressID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `addressID_lodging_idx` (`addressID` ASC),
  CONSTRAINT `addressID_lodging`
    FOREIGN KEY (`addressID`)
    REFERENCES `trip_planner_db_v2`.`address` (`ID`)
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`trip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`trip` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `userID` INT(11) NOT NULL,
  `lodgingID` INT(11) NOT NULL,
  `transportationMode` TINYINT(4) NULL DEFAULT NULL,
  `startDateTime` DATETIME NOT NULL,
  `endDateTime` DATETIME NOT NULL,
  `preferenceID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `userID_idx` (`userID` ASC),
  INDEX `preferenceID_idx` (`preferenceID` ASC),
  INDEX `lodgingID_trip_idx` (`lodgingID` ASC),
  CONSTRAINT `userID_trip`
    FOREIGN KEY (`userID`)
    REFERENCES `trip_planner_db_v2`.`user` (`ID`)
    ON UPDATE NO ACTION,
  CONSTRAINT `preferenceID_trip`
    FOREIGN KEY (`preferenceID`)
    REFERENCES `trip_planner_db_v2`.`preference` (`ID`)
    ON UPDATE NO ACTION,
  CONSTRAINT `lodgingID_trip`
    FOREIGN KEY (`lodgingID`)
    REFERENCES `trip_planner_db_v2`.`lodging` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`available_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`available_time` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `tripID` INT(11) NOT NULL,
  `startDateTime` DATETIME NOT NULL,
  `endDateTime` DATETIME NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `tripID_available_time_idx` (`tripID` ASC),
  CONSTRAINT `tripID_available_time`
    FOREIGN KEY (`tripID`)
    REFERENCES `trip_planner_db_v2`.`trip` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`customer_feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`customer_feedback` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `customerName` VARCHAR(25) NOT NULL,
  `customerRating` FLOAT NOT NULL,
  `customerReview` VARCHAR(500) NULL DEFAULT NULL,
  `placeID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `placeID_customer_feedback_idx` (`placeID` ASC),
  CONSTRAINT `placeID_customer_feedback`
    FOREIGN KEY (`placeID`)
    REFERENCES `trip_planner_db_v2`.`place` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`itinerary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`itinerary` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `tripID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `tripID_itinerary_idx` (`tripID` ASC),
  CONSTRAINT `tripID_itinerary`
    FOREIGN KEY (`tripID`)
    REFERENCES `trip_planner_db_v2`.`trip` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`restaurant` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `placeID` INT(11) NOT NULL,
  `restaurantCategory` TINYINT(4) NOT NULL,
  `priceCategory` TINYINT(4) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `placeID_restaurant_idx` (`placeID` ASC),
  CONSTRAINT `placeID_restaurant`
    FOREIGN KEY (`placeID`)
    REFERENCES `trip_planner_db_v2`.`place` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`restaurant_preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`restaurant_preference` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `preferenceID` INT(11) NOT NULL,
  `preferredRestaurantType` TINYINT(4) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `preferenceID_restaurant_preference_idx` (`preferenceID` ASC),
  CONSTRAINT `preferenceID_restaurant_preference`
    FOREIGN KEY (`preferenceID`)
    REFERENCES `trip_planner_db_v2`.`preference` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_v2`.`time_slot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_v2`.`time_slot` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `startTime` DATETIME NOT NULL,
  `endTime` DATETIME NOT NULL,
  `itineraryID` INT(11) NOT NULL,
  `placeID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `itineraryID_time_slot_idx` (`itineraryID` ASC),
  INDEX `placeID_time_slot_idx` (`placeID` ASC),
  CONSTRAINT `itineraryID_time_slot`
    FOREIGN KEY (`itineraryID`)
    REFERENCES `trip_planner_db_v2`.`itinerary` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `placeID_time_slot`
    FOREIGN KEY (`placeID`)
    REFERENCES `trip_planner_db_v2`.`place` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
