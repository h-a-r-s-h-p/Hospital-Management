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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-27 18:21:10
