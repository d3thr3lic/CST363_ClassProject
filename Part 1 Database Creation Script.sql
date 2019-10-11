-- MySQL Script generated by MySQL Workbench
-- Thu Oct  3 14:01:15 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`inventory` ;

CREATE TABLE IF NOT EXISTS `mydb`.`inventory` (
  `partcode` VARCHAR(15) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `list_price` DECIMAL(5, 2) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`partcode`),
  UNIQUE INDEX `partcode_UNIQUE` (`partcode` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customers` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customer_id` VARCHAR(10) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_header`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order_header` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order_header` (
  `order_number` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_date` DATE NOT NULL DEFAULT (CURRENT_DATE),
  `total_order_value` DECIMAL(2) UNSIGNED NOT NULL,
  `customer_id` VARCHAR(10) NOT NULL COMMENT 'Allows traceablity back to customer even after address change.',
  `ship_address` VARCHAR(100) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `ship_zip_code` VARCHAR(5) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `ship_state` VARCHAR(2) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `ship_phone` VARCHAR(20) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `bill_address` VARCHAR(100) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `bill_zip_code` VARCHAR(5) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `bill_state` VARCHAR(2) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  `bill_phone` VARCHAR(20) NOT NULL COMMENT 'Recorded to keep record of ship/bill address information in case of address change.',
  PRIMARY KEY (`order_number`),
  UNIQUE INDEX `invoice_number_UNIQUE` (`order_number` ASC) VISIBLE,
  INDEX `customer_number_fk_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `customer_number_fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order_lines` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order_lines` (
  `order_number` INT UNSIGNED NOT NULL,
  `order_seq` INT NOT NULL AUTO_INCREMENT,
  `partcode` VARCHAR(15) NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `line_value` DECIMAL(2) UNSIGNED NOT NULL,
  PRIMARY KEY (`order_seq`, `order_number`),
  INDEX `order_number_fk_idx` (`order_number` ASC) VISIBLE,
  INDEX `partcode_fk_idx` (`partcode` ASC) VISIBLE,
  CONSTRAINT `order_number_fk`
    FOREIGN KEY (`order_number`)
    REFERENCES `mydb`.`order_header` (`order_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `partcode_fk`
    FOREIGN KEY (`partcode`)
    REFERENCES `mydb`.`inventory` (`partcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer_addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer_addresses` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer_addresses` (
  `customer_id` VARCHAR(10) NOT NULL,
  `address_type` VARCHAR(4) NOT NULL COMMENT '\"BILL\" or \"SHIP\"',
  `address` VARCHAR(100) NOT NULL,
  `zip_code` VARCHAR(5) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`customer_id`, `address_type`),
  INDEX `fk_customer_addresses_customers1_idx` (`customer_id` ASC) INVISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
