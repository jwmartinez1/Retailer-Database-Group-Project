-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema team_09_inventory_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema team_09_inventory_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `team_09_inventory_db` DEFAULT CHARACTER SET utf8 ;
USE `team_09_inventory_db` ;

-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Inventory` (
  `InventoryID` INT NOT NULL AUTO_INCREMENT,
  `List_Price` INT NOT NULL,
  `Wholesale_Price` INT NOT NULL,
  `Item_descrip` VARCHAR(60) NOT NULL,
  `Item Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`InventoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Vendors` (
  `VendID` INT NOT NULL AUTO_INCREMENT,
  `VendName` VARCHAR(45) NOT NULL,
  `VendAdd` VARCHAR(60) NOT NULL,
  `VendState` VARCHAR(2) NOT NULL,
  `VendZip` SMALLINT(5) NOT NULL,
  `VendCity` VARCHAR(45) NOT NULL,
  `VendPhone` INT NOT NULL,
  `VendContact` VARCHAR(45) NOT NULL,
  `VendEmail` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`VendID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Orders` (
  `OrdersID` INT NOT NULL AUTO_INCREMENT,
  `Vendors_VendID` INT NOT NULL,
  `Order_total` INT NOT NULL,
  `Order_date` DATE NOT NULL,
  PRIMARY KEY (`OrdersID`),
  INDEX `fk_Orders_Vendors1_idx` (`Vendors_VendID` ASC),
  CONSTRAINT `fk_Orders_Vendors1`
    FOREIGN KEY (`Vendors_VendID`)
    REFERENCES `team_09_inventory_db`.`Vendors` (`VendID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Incoming_Order_Line_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Incoming_Order_Line_Items` (
  `IncOrderID` INT NOT NULL AUTO_INCREMENT,
  `Inventory_InventoryID` INT NOT NULL,
  `Orders_OrdersID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`IncOrderID`),
  INDEX `fk_Incoming Orders_Inventory_idx` (`Inventory_InventoryID` ASC),
  INDEX `fk_Incoming Orders_Orders1_idx` (`Orders_OrdersID` ASC),
  CONSTRAINT `fk_Incoming Orders_Inventory`
    FOREIGN KEY (`Inventory_InventoryID`)
    REFERENCES `team_09_inventory_db`.`Inventory` (`InventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incoming Orders_Orders1`
    FOREIGN KEY (`Orders_OrdersID`)
    REFERENCES `team_09_inventory_db`.`Orders` (`OrdersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustFirstName` VARCHAR(45) NOT NULL,
  `CustLastName` VARCHAR(45) NOT NULL,
  `CustAdd` VARCHAR(60) NULL,
  `CustState` VARCHAR(2) NULL,
  `CustZip` SMALLINT(5) NULL,
  `CustCity` VARCHAR(45) NULL,
  `CustPhone` INT NULL,
  `CustEmail` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Sales` (
  `SalesID` INT NOT NULL AUTO_INCREMENT,
  `Customers_CustomerID` INT NOT NULL,
  `Sale_Date` DATE NOT NULL,
  PRIMARY KEY (`SalesID`),
  INDEX `fk_Sales_Customers1_idx` (`Customers_CustomerID` ASC),
  CONSTRAINT `fk_Sales_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `team_09_inventory_db`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Sales_Order_Line_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Sales_Order_Line_Items` (
  `SalesOrderID` INT NOT NULL AUTO_INCREMENT,
  `Inventory_InventoryID` INT NOT NULL,
  `Sales_SalesID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`SalesOrderID`),
  INDEX `fk_Sales Orders_Inventory1_idx` (`Inventory_InventoryID` ASC),
  INDEX `fk_Sales Orders_Sales1_idx` (`Sales_SalesID` ASC),
  CONSTRAINT `fk_Sales Orders_Inventory1`
    FOREIGN KEY (`Inventory_InventoryID`)
    REFERENCES `team_09_inventory_db`.`Inventory` (`InventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales Orders_Sales1`
    FOREIGN KEY (`Sales_SalesID`)
    REFERENCES `team_09_inventory_db`.`Sales` (`SalesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Lost Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Lost Items` (
  `LostItemID` INT NOT NULL AUTO_INCREMENT,
  `Inventory_InventoryID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `Inventory_Check_Date` DATE NOT NULL,
  PRIMARY KEY (`LostItemID`),
  INDEX `fk_Lost Items_Inventory1_idx` (`Inventory_InventoryID` ASC),
  CONSTRAINT `fk_Lost Items_Inventory1`
    FOREIGN KEY (`Inventory_InventoryID`)
    REFERENCES `team_09_inventory_db`.`Inventory` (`InventoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_09_inventory_db`.`Payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `team_09_inventory_db`.`Payments` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `Orders_OrdersID` INT NOT NULL,
  `Payment_Amount` INT NOT NULL,
  `Payment_Date` DATE NOT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `fk_Payments_Orders1_idx` (`Orders_OrdersID` ASC),
  CONSTRAINT `fk_Payments_Orders1`
    FOREIGN KEY (`Orders_OrdersID`)
    REFERENCES `team_09_inventory_db`.`Orders` (`OrdersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
