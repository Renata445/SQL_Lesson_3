-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Kinopoisk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Kinopoisk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Kinopoisk` DEFAULT CHARACTER SET cp1251 ;
USE `Kinopoisk` ;

-- -----------------------------------------------------
-- Table `Kinopoisk`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`User` (
  `id_User` INT NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_User`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`User_Profilie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`User_Profilie` (
  `id_Profilie` INT NOT NULL,
  `Gender` VARCHAR(45) NULL,
  `Bithday` VARCHAR(45) NOT NULL,
  `Photo_id` INT NULL,
  `Hometown` VARCHAR(45) NULL,
  `User_id_User` INT NOT NULL,
  PRIMARY KEY (`id_Profilie`, `User_id_User`),
  INDEX `fk_User_Profilie_User1_idx` (`User_id_User` ASC) VISIBLE,
  CONSTRAINT `fk_User_Profilie_User1`
    FOREIGN KEY (`User_id_User`)
    REFERENCES `Kinopoisk`.`User` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Genre` (
  `id_Genre` INT NOT NULL,
  `Name_Genre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Genre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Country` (
  `id_Country` INT NOT NULL,
  `Name_Country` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Country`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Director` (
  `id_Director` INT NOT NULL,
  `Surname` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Director`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Actor` (
  `id_Actor` INT NOT NULL,
  `Surname` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_Actor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Films`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Films` (
  `id_film` INT NOT NULL,
  `Name_film` VARCHAR(45) NULL,
  `Year_of_realease` DATE NULL,
  `Time` TIME NULL,
  `Genre_id_Genre` INT NOT NULL,
  `Country_id_Country` INT NOT NULL,
  `Director_id_Director` INT NOT NULL,
  `Actor_id_Actor` INT NOT NULL,
  PRIMARY KEY (`id_film`, `Actor_id_Actor`, `Genre_id_Genre`, `Country_id_Country`, `Director_id_Director`),
  INDEX `fk_Films_Genre1_idx` (`Genre_id_Genre` ASC) VISIBLE,
  INDEX `fk_Films_Country1_idx` (`Country_id_Country` ASC) VISIBLE,
  INDEX `fk_Films_Director1_idx` (`Director_id_Director` ASC) VISIBLE,
  INDEX `fk_Films_Actor1_idx` (`Actor_id_Actor` ASC) VISIBLE,
  CONSTRAINT `fk_Films_Genre1`
    FOREIGN KEY (`Genre_id_Genre`)
    REFERENCES `Kinopoisk`.`Genre` (`id_Genre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Films_Country1`
    FOREIGN KEY (`Country_id_Country`)
    REFERENCES `Kinopoisk`.`Country` (`id_Country`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Films_Director1`
    FOREIGN KEY (`Director_id_Director`)
    REFERENCES `Kinopoisk`.`Director` (`id_Director`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Films_Actor1`
    FOREIGN KEY (`Actor_id_Actor`)
    REFERENCES `Kinopoisk`.`Actor` (`id_Actor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`View` (
  `id_View` INT NOT NULL,
  `Films_id_film` INT NOT NULL,
  `User_id_User` INT NOT NULL,
  PRIMARY KEY (`id_View`, `Films_id_film`, `User_id_User`),
  INDEX `fk_View_Films1_idx` (`Films_id_film` ASC) VISIBLE,
  INDEX `fk_View_User1_idx` (`User_id_User` ASC) VISIBLE,
  CONSTRAINT `fk_View_Films1`
    FOREIGN KEY (`Films_id_film`)
    REFERENCES `Kinopoisk`.`Films` (`id_film`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_View_User1`
    FOREIGN KEY (`User_id_User`)
    REFERENCES `Kinopoisk`.`User` (`id_User`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Film_Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Film_Director` (
  `id_Film_Director` INT NOT NULL,
  `Film_id` INT NULL,
  `Director_id_Director` INT NOT NULL,
  PRIMARY KEY (`id_Film_Director`),
  INDEX `fk_Film_Director_Director1_idx` (`Director_id_Director` ASC) VISIBLE,
  CONSTRAINT `fk_Film_Director_Director1`
    FOREIGN KEY (`Director_id_Director`)
    REFERENCES `Kinopoisk`.`Director` (`id_Director`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kinopoisk`.`Film_Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kinopoisk`.`Film_Actor` (
  `id_Film_Actor` INT NOT NULL,
  `Actor_id_Actor` INT NOT NULL,
  `Films_id_film` INT NOT NULL,
  PRIMARY KEY (`id_Film_Actor`),
  INDEX `fk_Film_Actor_Actor1_idx` (`Actor_id_Actor` ASC) VISIBLE,
  INDEX `fk_Film_Actor_Films1_idx` (`Films_id_film` ASC) VISIBLE,
  CONSTRAINT `fk_Film_Actor_Actor1`
    FOREIGN KEY (`Actor_id_Actor`)
    REFERENCES `Kinopoisk`.`Actor` (`id_Actor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Actor_Films1`
    FOREIGN KEY (`Films_id_film`)
    REFERENCES `Kinopoisk`.`Films` (`id_film`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
