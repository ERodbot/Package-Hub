-- MySQL Script generated by MySQL Workbench
-- Tue Nov 14 03:37:45 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema human-resources
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `human-resources` ;

-- -----------------------------------------------------
-- Schema human-resources
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `human-resources` DEFAULT CHARACTER SET utf8 ;
USE `human-resources` ;

-- -----------------------------------------------------
-- Table `human-resources`.`Departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Departments` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Departments` (
  `idDepartments` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(45) NOT NULL,
  `description` NVARCHAR(100) NOT NULL,
  `enabled` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idDepartments`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Role` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Role` (
  `idRole` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(45) NOT NULL,
  `description` NVARCHAR(100) NOT NULL,
  `idDepartments` INT NOT NULL,
  `enabled` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idRole`),
  INDEX `fk_Role_Departments1_idx` (`idDepartments` ASC) VISIBLE,
  CONSTRAINT `fk_Role_Departments1`
    FOREIGN KEY (`idDepartments`)
    REFERENCES `human-resources`.`Departments` (`idDepartments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`ContactType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`ContactType` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`ContactType` (
  `idContactType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContactType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`ContactInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`ContactInfo` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`ContactInfo` (
  `idContactInfo` INT NOT NULL AUTO_INCREMENT,
  `phone` NVARCHAR(45) NOT NULL,
  `email` NVARCHAR(80) NOT NULL,
  `idContactType` INT NOT NULL,
  `enabled` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idContactInfo`),
  INDEX `fk_ContactInfo_ContactType1_idx` (`idContactType` ASC) VISIBLE,
  CONSTRAINT `fk_ContactInfo_ContactType1`
    FOREIGN KEY (`idContactType`)
    REFERENCES `human-resources`.`ContactType` (`idContactType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`PayHourPerEmployee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`PayHourPerEmployee` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`PayHourPerEmployee` (
  `idPayHourPerEmployee` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(6,2) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`idPayHourPerEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`AddressType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`AddressType` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`AddressType` (
  `idAddressType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAddressType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Currency` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Currency` (
  `idCurrency` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `symbol` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`idCurrency`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Country` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Country` (
  `idCountry` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(45) NOT NULL,
  `idCurrency` INT NOT NULL,
  PRIMARY KEY (`idCountry`),
  INDEX `fk_Country_Currency1_idx` (`idCurrency` ASC) VISIBLE,
  CONSTRAINT `fk_Country_Currency1`
    FOREIGN KEY (`idCurrency`)
    REFERENCES `human-resources`.`Currency` (`idCurrency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`State`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`State` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`State` (
  `idState` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `idCountry` INT NOT NULL,
  PRIMARY KEY (`idState`),
  INDEX `fk_State_Country1_idx` (`idCountry` ASC) VISIBLE,
  CONSTRAINT `fk_State_Country1`
    FOREIGN KEY (`idCountry`)
    REFERENCES `human-resources`.`Country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`City`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`City` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`City` (
  `idCity` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `idState` INT NOT NULL,
  PRIMARY KEY (`idCity`),
  INDEX `fk_City_State1_idx` (`idState` ASC) VISIBLE,
  CONSTRAINT `fk_City_State1`
    FOREIGN KEY (`idState`)
    REFERENCES `human-resources`.`State` (`idState`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Address` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(80) NOT NULL,
  `postalCode` INT NOT NULL,
  `idAddressType` INT NOT NULL,
  `idCity` INT NOT NULL,
  `enabled` INT NOT NULL DEFAULT 1,
  `geoposition` GEOMETRY NOT NULL,
  PRIMARY KEY (`idAddress`),
  INDEX `fk_Address_AddressType1_idx` (`idAddressType` ASC) VISIBLE,
  INDEX `fk_Address_City1_idx` (`idCity` ASC) VISIBLE,
  CONSTRAINT `fk_Address_AddressType1`
    FOREIGN KEY (`idAddressType`)
    REFERENCES `human-resources`.`AddressType` (`idAddressType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_City1`
    FOREIGN KEY (`idCity`)
    REFERENCES `human-resources`.`City` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Employee` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(45) NOT NULL,
  `lastName` NVARCHAR(45) NOT NULL,
  `lastName2` NVARCHAR(45) NOT NULL,
  `idRole` INT NOT NULL,
  `idContactInfo` INT NOT NULL,
  `idPayHourPerEmployee` INT NOT NULL,
  `enabled` INT NOT NULL DEFAULT 1,
  `idAddress` INT NOT NULL,
  PRIMARY KEY (`idEmployee`),
  INDEX `fk_Employee_Role_idx` (`idRole` ASC) VISIBLE,
  INDEX `fk_Employee_ContactInfo1_idx` (`idContactInfo` ASC) VISIBLE,
  INDEX `fk_Employee_PayHourPerEmployee1_idx` (`idPayHourPerEmployee` ASC) VISIBLE,
  INDEX `fk_Employee_Address1_idx` (`idAddress` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Role`
    FOREIGN KEY (`idRole`)
    REFERENCES `human-resources`.`Role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_ContactInfo1`
    FOREIGN KEY (`idContactInfo`)
    REFERENCES `human-resources`.`ContactInfo` (`idContactInfo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_PayHourPerEmployee1`
    FOREIGN KEY (`idPayHourPerEmployee`)
    REFERENCES `human-resources`.`PayHourPerEmployee` (`idPayHourPerEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Address1`
    FOREIGN KEY (`idAddress`)
    REFERENCES `human-resources`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Payroll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Payroll` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Payroll` (
  `idPayroll` INT NOT NULL AUTO_INCREMENT,
  `hours` INT NOT NULL,
  `date` DATE NOT NULL,
  `idEmployee` INT NOT NULL,
  PRIMARY KEY (`idPayroll`),
  INDEX `fk_Payroll_Employee1_idx` (`idEmployee` ASC) VISIBLE,
  CONSTRAINT `fk_Payroll_Employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `human-resources`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Reduction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Reduction` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Reduction` (
  `idReduction` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(45) NOT NULL,
  `description` NVARCHAR(100) NOT NULL,
  PRIMARY KEY (`idReduction`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`ReductionbyCountry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`ReductionbyCountry` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`ReductionbyCountry` (
  `idReductionbyCountry` INT NOT NULL AUTO_INCREMENT,
  `percentage` DECIMAL(3,2) NOT NULL,
  `idReduction` INT NOT NULL,
  `idCountry` INT NOT NULL,
  PRIMARY KEY (`idReductionbyCountry`),
  INDEX `fk_ReductionbyCountry_Reduction1_idx` (`idReduction` ASC) VISIBLE,
  INDEX `fk_ReductionbyCountry_Country1_idx` (`idCountry` ASC) VISIBLE,
  CONSTRAINT `fk_ReductionbyCountry_Reduction1`
    FOREIGN KEY (`idReduction`)
    REFERENCES `human-resources`.`Reduction` (`idReduction`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReductionbyCountry_Country1`
    FOREIGN KEY (`idCountry`)
    REFERENCES `human-resources`.`Country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`PayByEmployee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`PayByEmployee` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`PayByEmployee` (
  `payid` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `grossSalary` DECIMAL(12,2) NOT NULL,
  `netSalary` DECIMAL(12,2) NOT NULL,
  `idEmployee` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`payid`),
  INDEX `fk_table1_Employee1_idx` (`idEmployee` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `human-resources`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`PerformanceMetrics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`PerformanceMetrics` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`PerformanceMetrics` (
  `idPerformanceMetrics` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(45) NOT NULL,
  `description` NVARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPerformanceMetrics`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`PerfomanceByEmployee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`PerfomanceByEmployee` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`PerfomanceByEmployee` (
  `idPerfomanceByEmployee` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `rating` DECIMAL(3,2) NOT NULL,
  `idEmpleado` INT NOT NULL,
  `idPerformanceMetrics` INT NOT NULL,
  PRIMARY KEY (`idPerfomanceByEmployee`),
  INDEX `fk_PerfomanceByEmployee_Employee1_idx` (`idEmpleado` ASC) VISIBLE,
  INDEX `fk_PerfomanceByEmployee_PerformanceMetrics1_idx` (`idPerformanceMetrics` ASC) VISIBLE,
  CONSTRAINT `fk_PerfomanceByEmployee_Employee1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `human-resources`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PerfomanceByEmployee_PerformanceMetrics1`
    FOREIGN KEY (`idPerformanceMetrics`)
    REFERENCES `human-resources`.`PerformanceMetrics` (`idPerformanceMetrics`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`Training`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`Training` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`Training` (
  `idTraining` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `trainer` INT NOT NULL,
  `trainee` INT NOT NULL,
  `observations` NVARCHAR(100) NOT NULL,
  PRIMARY KEY (`idTraining`),
  INDEX `fk_Training_Employee1_idx` (`trainer` ASC) VISIBLE,
  INDEX `fk_Training_Employee2_idx` (`trainee` ASC) VISIBLE,
  CONSTRAINT `fk_Training_Employee1`
    FOREIGN KEY (`trainer`)
    REFERENCES `human-resources`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Training_Employee2`
    FOREIGN KEY (`trainee`)
    REFERENCES `human-resources`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `human-resources`.`PaymentLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `human-resources`.`PaymentLog` ;

CREATE TABLE IF NOT EXISTS `human-resources`.`PaymentLog` (
  `idPaymentLog` INT NOT NULL AUTO_INCREMENT,
  `posttime` DATETIME NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  `paymentid` INT NOT NULL,
  PRIMARY KEY (`idPaymentLog`),
  INDEX `fk_PaymentLog_PayByEmployee1_idx` (`paymentid` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentLog_PayByEmployee1`
    FOREIGN KEY (`paymentid`)
    REFERENCES `human-resources`.`PayByEmployee` (`payid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
