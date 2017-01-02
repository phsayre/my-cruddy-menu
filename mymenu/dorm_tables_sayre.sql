CREATE DATABASE  IF NOT EXISTS `dorm`;
USE `dorm`;

-- SQL script for creating dorm database with tables for tracking student room assignments
-- copyright 2016 Philip Sayre phsayre@gmail.com
-- made for CSC261 alternate project



-- Table structure for table `student`

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_name` varchar(45) DEFAULT NULL,
  `s_gender` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Dumping data for table `student`

LOCK TABLES `student` WRITE;
ALTER TABLE `student` DISABLE KEYS;
INSERT INTO `student` VALUES (1,'Jenna',0),(2,'Jeff',1),(3,'Michael',1),(4,'Susie',0),(5,'Allen',1),(6,'Alexa',0),(7,'Bobby',1),(8,'Simon',1),(9,'Ashley',0),(10,'Henry',1),(11,'Dillan',1),(12,'Joan',0),(13,'Jack',1),(14,'Taylor',0),(15,'Luis',1),(16,'Yan',1),(17,'Hanna',0),(18,'Frederick',1),(19,'Deidre',0),(20,'Wallace',1),(21,'Wilma',0),(22,'Cletus',1);
ALTER TABLE `student` ENABLE KEYS;
UNLOCK TABLES;


-- Table structure for table `hallroom`

DROP TABLE IF EXISTS `hallroom`;
CREATE TABLE `hallroom` (
  `hr_id` int(11) NOT NULL AUTO_INCREMENT,
  `hr_number` varchar(45) DEFAULT NULL UNIQUE,
  `hr_capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`hr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Dumping data for table `hallroom`

LOCK TABLES `hallroom` WRITE;
ALTER TABLE `hallroom` DISABLE KEYS;
INSERT INTO `hallroom` VALUES (1,'A1',2),(2,'A2',2),(3,'A3',2),(4,'A4',2),(5,'A5',2),(6,'A6',2),(7,'A7',2),(8,'A8',2),(9,'A9',2),(10,'A10',2),(11,'B1',2),(12,'B2',2),(13,'B3',2),(14,'B4',2),(15,'B5',2),(16,'B6',2),(17,'B7',2),(18,'B8',2),(19,'B9',2),(20,'B10',2),(21,'C1',3),(22,'C2',3),(23,'C3',3),(24,'C4',3),(25,'C5',3),(26,'C6',3),(27,'C7',3),(28,'C8',3),(29,'C9',3),(30,'C10',3);
ALTER TABLE `hallroom` ENABLE KEYS;
UNLOCK TABLES;


-- Table structure for table `assignment`

DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_id` int(11) DEFAULT NULL UNIQUE,
  `hr_id` int(11) DEFAULT NULL,
  `a_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`a_id`),
  INDEX (`s_id`),
  INDEX (`hr_id`),
  
  FOREIGN KEY (`s_id`)
	REFERENCES `student`(`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	
  FOREIGN KEY (`hr_id`)
	REFERENCES `hallroom`(`hr_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;


-- Dumping data for table `assignment`

LOCK TABLES `assignment` WRITE;
ALTER TABLE `assignment` DISABLE KEYS;
INSERT INTO `assignment` VALUES (1,2,1,DEFAULT),(2,5,1,DEFAULT),(3,1,2,DEFAULT),(4,4,2,DEFAULT),(5,3,3,DEFAULT),(6,7,3,DEFAULT),(7,6,4,DEFAULT),(8,9,4,DEFAULT),(9,8,11,DEFAULT),(10,10,11,DEFAULT),(11,13,12,DEFAULT),(12,11,12,DEFAULT),(13,12,13,DEFAULT),(14,14,13,DEFAULT),(15,15,14,DEFAULT),(16,16,14,DEFAULT),(17,22,21,DEFAULT),(18,18,21,DEFAULT),(19,20,21,DEFAULT),(20,17,22,DEFAULT),(21,19,22,DEFAULT),(22,21,22,DEFAULT);
ALTER TABLE `assignment` ENABLE KEYS;
UNLOCK TABLES;
