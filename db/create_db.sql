SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `boredchores` ;
CREATE SCHEMA IF NOT EXISTS `boredchores` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `boredchores` ;

-- -----------------------------------------------------
-- Table `boredchores`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boredchores`.`users` ;

CREATE  TABLE IF NOT EXISTS `boredchores`.`users` (
  `iduser` INT NOT NULL AUTO_INCREMENT ,
  `nickname` VARCHAR(45) NOT NULL ,
  `firstname` VARCHAR(45) NULL ,
  `surname` VARCHAR(45) NULL ,
  `emailadress` VARCHAR(45) NOT NULL ,
  `accesstoken` VARCHAR(45) NULL ,
  `password` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`iduser`) ,
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC) ,
  UNIQUE INDEX `accesstoken_UNIQUE` (`accesstoken` ASC) ,
  UNIQUE INDEX `emailadress_UNIQUE` (`emailadress` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boredchores`.`choregroups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boredchores`.`choregroups` ;

CREATE  TABLE IF NOT EXISTS `boredchores`.`choregroups` (
  `idchoregroup` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`idchoregroup`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boredchores`.`codes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boredchores`.`codes` ;

CREATE  TABLE IF NOT EXISTS `boredchores`.`codes` (
  `idcode` INT NOT NULL ,
  `code` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`idcode`) ,
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boredchores`.`chores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boredchores`.`chores` ;

CREATE  TABLE IF NOT EXISTS `boredchores`.`chores` (
  `idchore` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  `fk_group` INT NOT NULL ,
  `startdate` DATE NOT NULL ,
  `enddate` DATE NULL ,
  `recurrence` INT NOT NULL ,
  `cd_recurrence_unit` INT NOT NULL ,
  `lenience_period` INT NOT NULL ,
  `cd_lenience_unit` INT NOT NULL ,
  `timestamp` TIMESTAMP NOT NULL ,
  `version` INT NOT NULL ,
  `value` INT NOT NULL ,
  PRIMARY KEY (`idchore`) ,
  INDEX `fk_group` (`fk_group` ASC) ,
  INDEX `cd_recurrence_unit` (`cd_recurrence_unit` ASC) ,
  INDEX `cd_lenience_unit` (`cd_lenience_unit` ASC) ,
  CONSTRAINT `fk_group`
    FOREIGN KEY (`fk_group` )
    REFERENCES `boredchores`.`choregroups` (`idchoregroup` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cd_recurrence_unit`
    FOREIGN KEY (`cd_recurrence_unit` )
    REFERENCES `boredchores`.`codes` (`idcode` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cd_lenience_unit`
    FOREIGN KEY (`cd_lenience_unit` )
    REFERENCES `boredchores`.`codes` (`idcode` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boredchores`.`user_chores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boredchores`.`user_chores` ;

CREATE  TABLE IF NOT EXISTS `boredchores`.`user_chores` (
  `iduser_chores` INT NOT NULL ,
  `fk_user` INT NOT NULL ,
  `fk_chore` INT NOT NULL ,
  PRIMARY KEY (`iduser_chores`) ,
  INDEX `fk_user` (`fk_user` ASC) ,
  INDEX `fk_chore` (`fk_chore` ASC) ,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`fk_user` )
    REFERENCES `boredchores`.`users` (`iduser` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chore`
    FOREIGN KEY (`fk_chore` )
    REFERENCES `boredchores`.`chores` (`idchore` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `boredchores`.`occurrences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boredchores`.`occurrences` ;

CREATE  TABLE IF NOT EXISTS `boredchores`.`occurrences` (
  `idoccurrence` INT NOT NULL ,
  `date` DATE NULL ,
  `fk_chore` INT NOT NULL ,
  `fk_user` INT NULL ,
  `comitted` DATETIME NULL ,
  `completed` DATETIME NULL ,
  `cd_status` INT NOT NULL ,
  PRIMARY KEY (`idoccurrence`) ,
  INDEX `fk_chore` (`fk_chore` ASC) ,
  INDEX `fk_user` (`fk_user` ASC) ,
  INDEX `cd_status` (`cd_status` ASC) ,
  CONSTRAINT `fk_chore`
    FOREIGN KEY (`fk_chore` )
    REFERENCES `boredchores`.`chores` (`idchore` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`fk_user` )
    REFERENCES `boredchores`.`users` (`iduser` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cd_status`
    FOREIGN KEY (`cd_status` )
    REFERENCES `boredchores`.`codes` (`idcode` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
