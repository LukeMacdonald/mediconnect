CREATE DATABASE user;

USE user;

CREATE TABLE user (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT
);

desc user;

ALTER TABLE user 
	ADD first_name VARCHAR(50) NOT NULL,
    ADD last_name VARCHAR(50) NOT NULL,
    ADD email VARCHAR(255) NOT NULL,
    ADD password VARCHAR(255) NOT NULL,
    ADD role ENUM("patient", "doctor", "superuser")
;

desc user;


CREATE TABLE `communication` (
  `senderID` INT NOT NULL,
  `receiverID` INT NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `messageID` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`messageID`)
  );
