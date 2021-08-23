-- MySQL dump 10.17  Distrib 10.3.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: hospital_management
-- ------------------------------------------------------
-- Server version	10.3.25-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Allocated`
--

DROP TABLE IF EXISTS `Allocated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Allocated` (
  `Patient_ID` int(10) NOT NULL,
  `Room_ID` int(10) NOT NULL,
  `Bed_ID` int(10) NOT NULL,
  KEY `Allocated_1` (`Patient_ID`),
  KEY `Allocated_2` (`Room_ID`),
  CONSTRAINT `Allocated_1` FOREIGN KEY (`Patient_ID`) REFERENCES `InPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Allocated_2` FOREIGN KEY (`Room_ID`) REFERENCES `Rooms` (`Room_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Allocated`
--

LOCK TABLES `Allocated` WRITE;
/*!40000 ALTER TABLE `Allocated` DISABLE KEYS */;
INSERT INTO `Allocated` VALUES (21100,6116,2),(21100,6115,1),(21101,6116,3),(21101,6118,1),(21102,6116,10),(21102,6114,1),(21103,6117,1),(21103,6115,1),(21104,6113,13);
/*!40000 ALTER TABLE `Allocated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bill`
--

DROP TABLE IF EXISTS `Bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bill` (
  `Reciept_ID` int(10) NOT NULL,
  `Transaction_ID` int(10) NOT NULL,
  `Mode_of_Payment` varchar(20) DEFAULT NULL CHECK (`Mode_of_Payment` in ('Cash','Debit Card','Credit Card','Online','Insurance')),
  `Amount` int(10) NOT NULL,
  `Transaction_Date` date NOT NULL,
  PRIMARY KEY (`Reciept_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bill`
--

LOCK TABLES `Bill` WRITE;
/*!40000 ALTER TABLE `Bill` DISABLE KEYS */;
INSERT INTO `Bill` VALUES (100,10001,'Credit Card',75000,'2021-04-03'),(101,10002,'Insurance',95000,'2021-04-01'),(102,10003,'Debit Card',195000,'2020-04-17'),(103,10004,'Insurance',35000,'2021-04-03'),(104,10005,'Insurance',78000,'2021-04-05'),(201,10006,'Cash',3150,'2021-04-01'),(202,10007,'Online',1200,'2021-04-02'),(203,10008,'Cash',1800,'2021-04-02'),(204,10009,'Online',1400,'2021-04-02'),(205,10010,'Debit Card',1550,'2021-04-03');
/*!40000 ALTER TABLE `Bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `Department_ID` int(10) NOT NULL,
  `Department_name` varchar(20) NOT NULL,
  `Department_head` varchar(20) NOT NULL,
  PRIMARY KEY (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (10100,'Gastrology','Ramalingam'),(11000,'Reception','Arushi'),(11001,'EYE','Farhan'),(11002,'Cardiology','Albert'),(11003,'Internal Medicine','Sunita'),(11004,'Neurology','Victoria'),(11005,'GS','Appel'),(11100,'ENT','Phunsukh');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor`
--

DROP TABLE IF EXISTS `Doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Doctor` (
  `Doctor_ID` int(10) NOT NULL,
  `Employee_ID` int(10) NOT NULL,
  `Qualification` varchar(20) NOT NULL,
  `Specialization` varchar(20) NOT NULL,
  `Charges` int(5) DEFAULT NULL,
  PRIMARY KEY (`Doctor_ID`),
  KEY `Doctor_Employee` (`Employee_ID`),
  CONSTRAINT `Doctor_Employee` FOREIGN KEY (`Employee_ID`) REFERENCES `Employees` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor`
--

LOCK TABLES `Doctor` WRITE;
/*!40000 ALTER TABLE `Doctor` DISABLE KEYS */;
INSERT INTO `Doctor` VALUES (1417,2007,'MBBS','Gastrologist',500),(1441,2001,'MD','ENT',500),(1442,2002,'MBBS','Cardiologist',500),(1443,2003,'MD','Physician',500),(1444,2004,'MD','Cancer',500),(1445,2005,'MD','Neurologist',500),(1446,2006,'MD','General surgeon',500);
/*!40000 ALTER TABLE `Doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `Employee_ID` int(10) NOT NULL,
  `Department_ID` int(10) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Salary` int(7) NOT NULL,
  `E_mail` varchar(30) DEFAULT NULL,
  `Sex` varchar(4) DEFAULT NULL CHECK (`Sex` in ('M','F','O')),
  `Contact` int(10) NOT NULL,
  `Address` varchar(30) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  KEY `Employee_Dept` (`Department_ID`),
  CONSTRAINT `Employee_Dept` FOREIGN KEY (`Department_ID`) REFERENCES `Department` (`Department_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1000,10100,'Shweta',20000,'shweta@gmail.com','F',9985433,'Palakkad'),(1001,11003,'Isabella',30000,'Isabells@gmail.com','F',7845616,'Mumbai'),(1002,11005,'Jenny',35000,'Jenny@gmail.com','F',8561894,'Mumbai'),(1003,11002,'Emma',55000,'Emma@gmail.com','F',6941847,'Mumbai'),(1101,11100,'Shyam',20000,'shyam@gmail.com','M',9923445,'Mumbai'),(2001,11100,'Abhishek',100000,'abhishek@gmail.com','M',9999762,'Palakkad'),(2002,11002,'Albert',100000,'albert@gmail.com','M',6254697,'Chandigarh'),(2003,11003,'Sunita',60000,'SunitaMishra@gmail.com','F',6854684,'Gaziabad'),(2004,11003,'Vivek',90000,'Vivek@gmail.com','M',9856744,'Goa'),(2005,11004,'Victoria',120000,'Victoria123@gmail.com','F',9867235,'Pune'),(2006,11005,'Appel',80000,'Appel1@gmail.com','M',8754698,'Pune'),(2007,10100,'Priya',200000,'priya@gmail.com','F',9912234,'Mumbai'),(3000,11000,'Sonu',30000,'sonu@gmail.com','M',9128243,'Delhi'),(3001,11100,'Phunsukh',30000,'Phunsukh@gmail.com','M',9122343,'Delhi'),(3002,11001,'Farhan',30000,'Farhan@gmail.com','M',9167843,'Delhi'),(3003,10100,'Ramalingam',30000,'Ramalingam@gmail.com','M',9745343,'Delhi'),(3004,11000,'Arushi',30000,'Arushi@gmail.com','F',9000000,'Delhi'),(3111,11000,'Sweety',30000,'sweety@gmai.com','F',9557709,'Mumbai');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Facilities`
--

DROP TABLE IF EXISTS `Facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Facilities` (
  `Facility_ID` int(10) NOT NULL,
  `Facility_name` varchar(20) NOT NULL,
  `Cost` int(5) NOT NULL,
  `RoomNo` int(3) NOT NULL,
  PRIMARY KEY (`Facility_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Facilities`
--

LOCK TABLES `Facilities` WRITE;
/*!40000 ALTER TABLE `Facilities` DISABLE KEYS */;
INSERT INTO `Facilities` VALUES (1010,'X-Ray',200,30),(1011,'MRI',1000,12),(1012,'CT Scan',2000,12),(1013,'UltraSound',300,20),(1014,'Labroratory',1500,11),(1015,'Physiothreapy',500,10),(1016,'ECG',1000,13);
/*!40000 ALTER TABLE `Facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InHave`
--

DROP TABLE IF EXISTS `InHave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InHave` (
  `Patient_ID` int(10) NOT NULL,
  `Record_No` int(10) NOT NULL,
  KEY `InHave_1` (`Patient_ID`),
  KEY `InHave_2` (`Record_No`),
  CONSTRAINT `InHave_1` FOREIGN KEY (`Patient_ID`) REFERENCES `InPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `InHave_2` FOREIGN KEY (`Record_No`) REFERENCES `Records` (`Record_No`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InHave`
--

LOCK TABLES `InHave` WRITE;
/*!40000 ALTER TABLE `InHave` DISABLE KEYS */;
INSERT INTO `InHave` VALUES (21100,1),(21100,2),(21100,3),(21102,4),(21101,5),(21103,6),(21104,7);
/*!40000 ALTER TABLE `InHave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InPatient`
--

DROP TABLE IF EXISTS `InPatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InPatient` (
  `Patient_ID` int(10) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Sex` varchar(4) DEFAULT NULL CHECK (`Sex` in ('M','F','O')),
  `Date_Admitted` date NOT NULL,
  `Date_Discharged` date NOT NULL,
  `Contact` int(10) DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Doctor_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`),
  KEY `Attends_1` (`Doctor_ID`),
  CONSTRAINT `Attends_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `Doctor` (`Doctor_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InPatient`
--

LOCK TABLES `InPatient` WRITE;
/*!40000 ALTER TABLE `InPatient` DISABLE KEYS */;
INSERT INTO `InPatient` VALUES (21100,'John','M','2021-03-28','2021-04-03',9902143,'Mumbai',1417),(21101,'Taylor','M','2021-03-28','2021-04-01',9905169,'Mumbai',1442),(21102,'Ovi','M','2021-03-31','2021-04-17',9912349,'Delhi',1443),(21103,'James','M','2021-04-01','2021-04-03',8348355,'Gandhinagar',1441),(21104,'Maria','F','2021-04-02','2021-04-05',2015733,'Mumbai',1444);
/*!40000 ALTER TABLE `InPatient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InPayment`
--

DROP TABLE IF EXISTS `InPayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InPayment` (
  `Reciept_ID` int(10) NOT NULL,
  `Patient_ID` int(10) NOT NULL,
  KEY `InPayment_1` (`Reciept_ID`),
  KEY `InPayment_2` (`Patient_ID`),
  CONSTRAINT `InPayment_1` FOREIGN KEY (`Reciept_ID`) REFERENCES `Bill` (`Reciept_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `InPayment_2` FOREIGN KEY (`Patient_ID`) REFERENCES `InPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InPayment`
--

LOCK TABLES `InPayment` WRITE;
/*!40000 ALTER TABLE `InPayment` DISABLE KEYS */;
INSERT INTO `InPayment` VALUES (100,21100),(101,21101),(102,21102),(103,21103),(104,21104);
/*!40000 ALTER TABLE `InPayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InUses`
--

DROP TABLE IF EXISTS `InUses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InUses` (
  `Patient_ID` int(10) NOT NULL,
  `Facility_ID` int(10) NOT NULL,
  KEY `InUses_1` (`Patient_ID`),
  KEY `InUses_2` (`Facility_ID`),
  CONSTRAINT `InUses_1` FOREIGN KEY (`Patient_ID`) REFERENCES `InPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `InUses_2` FOREIGN KEY (`Facility_ID`) REFERENCES `Facilities` (`Facility_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InUses`
--

LOCK TABLES `InUses` WRITE;
/*!40000 ALTER TABLE `InUses` DISABLE KEYS */;
INSERT INTO `InUses` VALUES (21100,1014),(21100,1013),(21101,1016),(21104,1014),(21102,1014);
/*!40000 ALTER TABLE `InUses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Insurance`
--

DROP TABLE IF EXISTS `Insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Insurance` (
  `InsuranceNo` int(10) NOT NULL,
  `CompanyName` varchar(20) NOT NULL,
  `InsuranceType` varchar(20) DEFAULT NULL,
  `ClaimCoverage` int(11) NOT NULL,
  PRIMARY KEY (`InsuranceNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Insurance`
--

LOCK TABLES `Insurance` WRITE;
/*!40000 ALTER TABLE `Insurance` DISABLE KEYS */;
INSERT INTO `Insurance` VALUES (1001,'starlite','Health',1000000),(1002,'ICICI','Life',1000000),(1003,'HDFC','Motor',100000),(1004,'HDFC','Property',5000000);
/*!40000 ALTER TABLE `Insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Insured`
--

DROP TABLE IF EXISTS `Insured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Insured` (
  `Reciept_ID` int(10) NOT NULL,
  `InsuranceNo` int(10) NOT NULL,
  KEY `Insured_1` (`InsuranceNo`),
  KEY `Insured_2` (`Reciept_ID`),
  CONSTRAINT `Insured_1` FOREIGN KEY (`InsuranceNo`) REFERENCES `Insurance` (`InsuranceNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Insured_2` FOREIGN KEY (`Reciept_ID`) REFERENCES `Bill` (`Reciept_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Insured`
--

LOCK TABLES `Insured` WRITE;
/*!40000 ALTER TABLE `Insured` DISABLE KEYS */;
INSERT INTO `Insured` VALUES (101,1002),(103,1003),(104,1004);
/*!40000 ALTER TABLE `Insured` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manages`
--

DROP TABLE IF EXISTS `Manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manages` (
  `Receptionist_ID` int(10) NOT NULL,
  `Record_No` int(10) NOT NULL,
  KEY `Manages_1` (`Receptionist_ID`),
  KEY `Manages_2` (`Record_No`),
  CONSTRAINT `Manages_1` FOREIGN KEY (`Receptionist_ID`) REFERENCES `Receptionist` (`Receptionist_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Manages_2` FOREIGN KEY (`Record_No`) REFERENCES `Records` (`Record_No`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manages`
--

LOCK TABLES `Manages` WRITE;
/*!40000 ALTER TABLE `Manages` DISABLE KEYS */;
INSERT INTO `Manages` VALUES (2122,1),(2122,2),(2122,3),(2222,4),(2122,5),(2122,6),(2222,7),(2122,8),(2222,9),(2122,10),(2122,11),(2222,12);
/*!40000 ALTER TABLE `Manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medicine`
--

DROP TABLE IF EXISTS `Medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Medicine` (
  `Code` int(10) NOT NULL,
  `Price` int(10) NOT NULL,
  `Quantity` int(10) NOT NULL,
  `Expr_Date` date NOT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medicine`
--

LOCK TABLES `Medicine` WRITE;
/*!40000 ALTER TABLE `Medicine` DISABLE KEYS */;
INSERT INTO `Medicine` VALUES (10201,50,195,'2022-01-12'),(10202,100,105,'2022-05-01'),(10203,1000,25,'2022-12-01'),(10204,780,15,'2022-11-01'),(10205,10,50,'2022-08-01'),(10206,2350,43,'2022-07-21'),(10207,18,18,'2022-06-30');
/*!40000 ALTER TABLE `Medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Nurse`
--

DROP TABLE IF EXISTS `Nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Nurse` (
  `Nurse_ID` int(10) NOT NULL,
  `Employee_ID` int(10) NOT NULL,
  `Experience` int(5) NOT NULL,
  PRIMARY KEY (`Nurse_ID`),
  KEY `Nurse_Employee` (`Employee_ID`),
  CONSTRAINT `Nurse_Employee` FOREIGN KEY (`Employee_ID`) REFERENCES `Employees` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nurse`
--

LOCK TABLES `Nurse` WRITE;
/*!40000 ALTER TABLE `Nurse` DISABLE KEYS */;
INSERT INTO `Nurse` VALUES (1512,1000,7),(1513,1001,2),(1514,1002,3),(1515,1003,8),(1551,1101,5);
/*!40000 ALTER TABLE `Nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutHave`
--

DROP TABLE IF EXISTS `OutHave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutHave` (
  `Patient_ID` int(10) NOT NULL,
  `Record_No` int(10) NOT NULL,
  KEY `OutHave_1` (`Patient_ID`),
  KEY `OutHave_2` (`Record_No`),
  CONSTRAINT `OutHave_1` FOREIGN KEY (`Patient_ID`) REFERENCES `OutPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OutHave_2` FOREIGN KEY (`Record_No`) REFERENCES `Records` (`Record_No`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutHave`
--

LOCK TABLES `OutHave` WRITE;
/*!40000 ALTER TABLE `OutHave` DISABLE KEYS */;
INSERT INTO `OutHave` VALUES (31212,8),(31213,9),(31214,10),(31215,11),(31216,12);
/*!40000 ALTER TABLE `OutHave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutPatient`
--

DROP TABLE IF EXISTS `OutPatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutPatient` (
  `Patient_ID` int(10) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Sex` varchar(4) DEFAULT NULL CHECK (`Sex` in ('M','F','O')),
  `Date_Visited` date NOT NULL,
  `Contact` int(10) DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Doctor_ID` int(10) NOT NULL,
  PRIMARY KEY (`Patient_ID`),
  KEY `Appointment_2` (`Doctor_ID`),
  CONSTRAINT `Appointment_2` FOREIGN KEY (`Doctor_ID`) REFERENCES `Doctor` (`Doctor_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutPatient`
--

LOCK TABLES `OutPatient` WRITE;
/*!40000 ALTER TABLE `OutPatient` DISABLE KEYS */;
INSERT INTO `OutPatient` VALUES (31212,'Spock','M','2021-04-01',9546546,'Mumbai',1417),(31213,'Saurav','M','2021-04-02',9512345,'Kalyan',1443),(31214,'Raj','M','2021-04-02',9578901,'Thane',1443),(31215,'lara','F','2021-04-02',9514226,'Nashik',1445),(31216,'sofia','F','2021-04-03',1432345,'Pune',1443);
/*!40000 ALTER TABLE `OutPatient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutPayment`
--

DROP TABLE IF EXISTS `OutPayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutPayment` (
  `Reciept_ID` int(10) NOT NULL,
  `Patient_ID` int(10) NOT NULL,
  KEY `OutPayment_1` (`Reciept_ID`),
  KEY `OutPayment_2` (`Patient_ID`),
  CONSTRAINT `OutPayment_1` FOREIGN KEY (`Reciept_ID`) REFERENCES `Bill` (`Reciept_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OutPayment_2` FOREIGN KEY (`Patient_ID`) REFERENCES `OutPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutPayment`
--

LOCK TABLES `OutPayment` WRITE;
/*!40000 ALTER TABLE `OutPayment` DISABLE KEYS */;
INSERT INTO `OutPayment` VALUES (201,31212),(202,31213),(203,31214),(204,31215),(205,31216);
/*!40000 ALTER TABLE `OutPayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutUses`
--

DROP TABLE IF EXISTS `OutUses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutUses` (
  `Patient_ID` int(10) NOT NULL,
  `Facility_ID` int(10) NOT NULL,
  KEY `OutUses_1` (`Patient_ID`),
  KEY `OutUses_2` (`Facility_ID`),
  CONSTRAINT `OutUses_1` FOREIGN KEY (`Patient_ID`) REFERENCES `OutPatient` (`Patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OutUses_2` FOREIGN KEY (`Facility_ID`) REFERENCES `Facilities` (`Facility_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutUses`
--

LOCK TABLES `OutUses` WRITE;
/*!40000 ALTER TABLE `OutUses` DISABLE KEYS */;
INSERT INTO `OutUses` VALUES (31212,1013),(31213,1014),(31214,1014),(31216,1014);
/*!40000 ALTER TABLE `OutUses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prescription`
--

DROP TABLE IF EXISTS `Prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prescription` (
  `Reciept_ID` int(10) NOT NULL,
  `Code` int(10) NOT NULL,
  KEY `Prescription_1` (`Reciept_ID`),
  KEY `Prescription_2` (`Code`),
  CONSTRAINT `Prescription_1` FOREIGN KEY (`Reciept_ID`) REFERENCES `Bill` (`Reciept_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Prescription_2` FOREIGN KEY (`Code`) REFERENCES `Medicine` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prescription`
--

LOCK TABLES `Prescription` WRITE;
/*!40000 ALTER TABLE `Prescription` DISABLE KEYS */;
INSERT INTO `Prescription` VALUES (100,10201),(100,10206),(101,10206),(101,10203),(102,10203),(102,10204),(102,10206),(103,10207),(104,10201),(201,10201),(201,10202),(202,10202),(202,10204),(202,10207),(203,10201),(203,10205),(204,10205),(205,10202);
/*!40000 ALTER TABLE `Prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Receptionist`
--

DROP TABLE IF EXISTS `Receptionist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Receptionist` (
  `Receptionist_ID` int(10) NOT NULL,
  `Employee_ID` int(10) NOT NULL,
  PRIMARY KEY (`Receptionist_ID`),
  KEY `Recept_Employee` (`Employee_ID`),
  CONSTRAINT `Recept_Employee` FOREIGN KEY (`Employee_ID`) REFERENCES `Employees` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Receptionist`
--

LOCK TABLES `Receptionist` WRITE;
/*!40000 ALTER TABLE `Receptionist` DISABLE KEYS */;
INSERT INTO `Receptionist` VALUES (2122,3000),(2222,3111);
/*!40000 ALTER TABLE `Receptionist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Records`
--

DROP TABLE IF EXISTS `Records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Records` (
  `Record_No` int(10) NOT NULL,
  `Patient_ID` int(10) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Record_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Records`
--

LOCK TABLES `Records` WRITE;
/*!40000 ALTER TABLE `Records` DISABLE KEYS */;
INSERT INTO `Records` VALUES (1,21100,'2021-03-28','Stomach pain, Intestinal infection'),(2,21100,'2021-03-31','Fever'),(3,21100,'2021-04-01','Vomit'),(4,21102,'2021-03-31','COVID-19 positive'),(5,21101,'2021-03-28','Heart attack'),(6,21103,'2021-04-01','Ear surgery'),(7,21104,'2021-04-02','Blood cancer'),(8,31212,'2021-04-01','Stomach Pain'),(9,31213,'2021-04-02','Diabetes checkup'),(10,31214,'2021-04-02','Thyroid'),(11,31215,'2021-04-02','Migraine'),(12,31216,'2021-04-03','Viral infection');
/*!40000 ALTER TABLE `Records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rooms`
--

DROP TABLE IF EXISTS `Rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rooms` (
  `Room_ID` int(10) NOT NULL,
  `Room_Type` varchar(20) NOT NULL,
  `Floor` int(2) DEFAULT NULL CHECK (`Floor` between 0 and 4),
  `Ward_Type` varchar(20) NOT NULL,
  `No_of_Beds` int(5) NOT NULL,
  `Room_Charges` int(5) NOT NULL,
  PRIMARY KEY (`Room_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rooms`
--

LOCK TABLES `Rooms` WRITE;
/*!40000 ALTER TABLE `Rooms` DISABLE KEYS */;
INSERT INTO `Rooms` VALUES (6113,'OneStar',0,'General',15,500),(6114,'OneStar nonAC',1,'Private',1,1000),(6115,'OneStar AC',1,'Private',1,1000),(6116,'Critical',1,'ICU',10,10000),(6117,'Emergency',1,'Operation theatre',1,20000),(6118,'TwoStar',2,'Private',1,2500);
/*!40000 ALTER TABLE `Rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supervision`
--

DROP TABLE IF EXISTS `Supervision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Supervision` (
  `Room_ID` int(10) NOT NULL,
  `Nurse_ID` int(10) NOT NULL,
  KEY `Supervision_1` (`Room_ID`),
  KEY `Supervision_2` (`Nurse_ID`),
  CONSTRAINT `Supervision_1` FOREIGN KEY (`Room_ID`) REFERENCES `Rooms` (`Room_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Supervision_2` FOREIGN KEY (`Nurse_ID`) REFERENCES `Nurse` (`Nurse_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supervision`
--

LOCK TABLES `Supervision` WRITE;
/*!40000 ALTER TABLE `Supervision` DISABLE KEYS */;
INSERT INTO `Supervision` VALUES (6113,1551),(6114,1512),(6115,1513),(6116,1514),(6118,1515);
/*!40000 ALTER TABLE `Supervision` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-27 18:20:53
