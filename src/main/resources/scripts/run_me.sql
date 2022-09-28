-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ca1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ca1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ca1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ca1` ;

-- -----------------------------------------------------
-- Table `ca1`.`PHONE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ca1`.`PHONE` (
                                             `id` INT NOT NULL AUTO_INCREMENT,
                                             `number` VARCHAR(45) NOT NULL,
    `description` VARCHAR(45) NULL,
    `isPrivate` TINYINT NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ca1`.`CITYINFO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ca1`.`CITYINFO` (
                                                `id` INT NOT NULL AUTO_INCREMENT,
                                                `zipCode` INT NOT NULL,
                                                `cityName` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ca1`.`ADDRESS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ca1`.`ADDRESS` (
                                               `id` INT NOT NULL AUTO_INCREMENT,
                                               `street` VARCHAR(45) NOT NULL,
    `additionalInfo` VARCHAR(45) NULL,
    `isPrivate` TINYINT NOT NULL,
    `CITYINFO_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_ADDRESS_CITYINFO1_idx` (`CITYINFO_id` ASC) VISIBLE,
    CONSTRAINT `fk_ADDRESS_CITYINFO1`
    FOREIGN KEY (`CITYINFO_id`)
    REFERENCES `ca1`.`CITYINFO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ca1`.`PERSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ca1`.`PERSON` (
                                              `id` INT NOT NULL AUTO_INCREMENT,
                                              `email` VARCHAR(45) NOT NULL,
    `firstName` VARCHAR(45) NOT NULL,
    `lastName` VARCHAR(45) NOT NULL,
    `PHONE_id` INT NOT NULL,
    `ADDRESS_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
    INDEX `fk_PERSON_PHONE_idx` (`PHONE_id` ASC) VISIBLE,
    INDEX `fk_PERSON_ADDRESS1_idx` (`ADDRESS_id` ASC) VISIBLE,
    CONSTRAINT `fk_PERSON_PHONE`
    FOREIGN KEY (`PHONE_id`)
    REFERENCES `ca1`.`PHONE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_PERSON_ADDRESS1`
    FOREIGN KEY (`ADDRESS_id`)
    REFERENCES `ca1`.`ADDRESS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ca1`.`HOBBY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ca1`.`HOBBY` (
                                             `id` INT NOT NULL AUTO_INCREMENT,
                                             `wikiLink` VARCHAR(255) NULL,
    `name` VARCHAR(45) NOT NULL,
    `category` VARCHAR(45) NOT NULL,
    `type` VARCHAR(45) NOT NULL,
    `description` VARCHAR(355) NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ca1`.`HOBBY_has_PERSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ca1`.`HOBBY_has_PERSON` (
                                                        `HOBBY_id` INT NOT NULL,
                                                        `PERSON_id` INT NOT NULL,
                                                        PRIMARY KEY (`HOBBY_id`, `PERSON_id`),
    INDEX `fk_HOBBY_has_PERSON_PERSON1_idx` (`PERSON_id` ASC) VISIBLE,
    INDEX `fk_HOBBY_has_PERSON_HOBBY1_idx` (`HOBBY_id` ASC) VISIBLE,
    CONSTRAINT `fk_HOBBY_has_PERSON_HOBBY1`
    FOREIGN KEY (`HOBBY_id`)
    REFERENCES `ca1`.`HOBBY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_HOBBY_has_PERSON_PERSON1`
    FOREIGN KEY (`PERSON_id`)
    REFERENCES `ca1`.`PERSON` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
