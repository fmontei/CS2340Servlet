SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema trip_planner_db_simple
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `trip_planner_db_simple` DEFAULT CHARACTER SET utf8 ;
USE `trip_planner_db_simple` ;

-- -----------------------------------------------------
-- Table `trip_planner_db_simple`.`preference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_simple`.`preference` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `minimumRating` FLOAT NOT NULL,
  `priceCategory` VARCHAR(25) NOT NULL,
  `maxDistance` INT(11) NOT NULL,
  `foodType` VARCHAR(45) NULL DEFAULT NULL,
  `attractionType` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_simple`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_simple`.`user` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(25) NOT NULL,
  `lastName` VARCHAR(25) NOT NULL,
  `userName` VARCHAR(25) NOT NULL,
  `password` INT(20) NOT NULL,
  `userRole` INT(11) NULL DEFAULT NULL,
  `preferenceID` INT(11) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `preferenceID_idx` (`preferenceID` ASC),
  CONSTRAINT `preferenceID`
    FOREIGN KEY (`preferenceID`)
    REFERENCES `trip_planner_db_simple`.`preference` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 46
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_simple`.`itinerary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_simple`.`itinerary` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `userID` INT(11) NULL DEFAULT NULL,
  `transportation` VARCHAR(45) NOT NULL,
  `creationDate` VARCHAR(45) NULL DEFAULT NULL,
  `preferenceID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `tripID_itinerary_idx` (`userID` ASC),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `trip_planner_db_simple`.`user` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_simple`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_simple`.`city` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `latitude` DECIMAL(10,7) NOT NULL,
  `longitude` DECIMAL(10,7) NOT NULL,
  `itineraryID` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `itineraryID_city_fk_idx` (`itineraryID` ASC),
  CONSTRAINT `itineraryID_city_fk`
    FOREIGN KEY (`itineraryID`)
    REFERENCES `trip_planner_db_simple`.`itinerary` (`ID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `trip_planner_db_simple`.`place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trip_planner_db_simple`.`place` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `cityID` INT(11) NOT NULL,
  `placeType` VARCHAR(9) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `phoneNumber` VARCHAR(20) NULL DEFAULT NULL,
  `apiType` VARCHAR(6) NULL DEFAULT NULL,
  `priceLevel` INT(1) NULL DEFAULT NULL,
  `rating` DECIMAL(2,1) NULL DEFAULT NULL,
  `latitude` DECIMAL(10,7) NULL DEFAULT NULL,
  `longitude` DECIMAL(10,7) NULL DEFAULT NULL,
  `url` VARCHAR(200) NULL DEFAULT NULL,
  `creationDate` VARCHAR(80) NULL DEFAULT NULL,
  `checkIn` VARCHAR(80) NULL DEFAULT NULL,
  `checkOut` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC),
  INDEX `cityID_fk_idx` (`cityID` ASC),
  CONSTRAINT `cityID_fk`
    FOREIGN KEY (`cityID`)
    REFERENCES `trip_planner_db_simple`.`city` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 118
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
