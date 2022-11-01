CREATE DATABASE IF NOT EXISTS abc_management;

CREATE TABLE IF NOT EXISTS `abc_management`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `state` VARCHAR(45) NULL,
  `address_line_1` VARCHAR(100) NOT NULL,
  `address_line_2` VARCHAR(100) NULL,
  `country` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`address_id`));

CREATE TABLE IF NOT EXISTS `abc_management`.`abc_client` (
  `abc_client_id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(100) NOT NULL,
  `company_address_id` INT NULL,
  `phone_number` VARCHAR(45) NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`abc_client_id`),
  INDEX `address_client_fk_idx` (`company_address_id` ASC) VISIBLE,
  CONSTRAINT `address_client_fk`
    FOREIGN KEY (`company_address_id`)
    REFERENCES `abc_management`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `abc_management`.`contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `email_address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`contact_id`));
  
CREATE TABLE IF NOT EXISTS `abc_management`.`client_contacts` (
  `client_contacts_id` INT NOT NULL AUTO_INCREMENT,
  `abc_client_id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`client_contacts_id`),
  INDEX `client_fk_idx` (`abc_client_id` ASC) VISIBLE,
  INDEX `contact_fk_idx` (`contact_id` ASC) VISIBLE,
  CONSTRAINT `client_fk`
    FOREIGN KEY (`abc_client_id`)
    REFERENCES `abc_management`.`abc_client` (`abc_client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contact_fk`
    FOREIGN KEY (`contact_id`)
    REFERENCES `abc_management`.`contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `abc_management`.`storage_type` (
  `storage_type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`storage_type_id`));

CREATE TABLE IF NOT EXISTS `abc_management`.`inventory` (
  `inventory_id` INT NOT NULL AUTO_INCREMENT,
  `abc_client_id` INT NOT NULL,
  `inventory_name` VARCHAR(45) NOT NULL,
  `storage_type_id` INT NOT NULL,
  `max_item_capacity` BIGINT NOT NULL,
  `address_id` INT NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`inventory_id`),
  INDEX `client_fk_idx` (`abc_client_id` ASC) VISIBLE,
  INDEX `storage_fk_idx` (`storage_type_id` ASC) VISIBLE,
  INDEX `address_fk_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `client_inventory_fk`
    FOREIGN KEY (`abc_client_id`)
    REFERENCES `abc_management`.`abc_client` (`abc_client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `storage_inventory_fk`
    FOREIGN KEY (`storage_type_id`)
    REFERENCES `abc_management`.`storage_type` (`storage_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_inventory_fk`
    FOREIGN KEY (`address_id`)
    REFERENCES `abc_management`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `abc_management`.`resource_type` (
  `resource_type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) NULL,
  `modified_date` DATETIME NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`resource_type_id`));


CREATE TABLE IF NOT EXISTS `abc_management`.`abc_resource` (
  `abc_resource_id` INT NOT NULL AUTO_INCREMENT,
  `inventory_id` INT NOT NULL,
  `resource_type_id` INT NOT NULL,
  `resource_name` VARCHAR(45) NOT NULL,
  `max_number_of_resources` BIGINT NOT NULL,
  `current_number_of_resources` BIGINT NOT NULL,
  `created_by` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` VARCHAR(45) DEFAULT NULL,
  `modified_date` DATETIME DEFAULT NULL,
  `is_deleted` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`abc_resource_id`),
  KEY `abc_resource_resource_type_idx` (`resource_type_id`),
  KEY `abc_resource_inventory_fk_idx` (`inventory_id`),
  CONSTRAINT `abc_resource_inventory_fk` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`),
  CONSTRAINT `abc_resource_resource_type` FOREIGN KEY (`resource_type_id`) REFERENCES `resource_type` (`resource_type_id`)
);

CREATE TABLE IF NOT EXISTS `abc_management`.`access_log` (
  `access_log_id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `action` VARCHAR(45) NOT NULL,
  `table_name` VARCHAR(45) NULL,
  `field_name` VARCHAR(45) NULL,
  `screen_name` VARCHAR(45) NULL,
  `log_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`access_log_id`));





