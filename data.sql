INSERT into Insurance values
(1001, 'starlite', "Health", 10000),
(1002, "ICICI", "Life", 100000),
(1003, "HDFC", "ergo", 200000),
(1004, "LIC", "Life", 100000);
INSERT into Bill values
(100, 10001, 'Credit Card', 75000, '2021-04-03'),
(101, 10002, 'Insurance', 95000, '2021-04-01'),
(102, 10003, 'Debit Card', 195000, '2020-04-17'),
(103, 10004, 'Insurance', 35000, '2021-04-03'),
(104, 10005, 'Insurance', 78000, '2021-04-05'),
(201, 10006, 'Cash', 3150, '2021-04-01'),
(202, 10007, 'Online', 1200, '2021-04-02'),
(203, 10008, 'Cash', 1800, '2021-04-02'),
(204, 10009, 'Online', 1400, '2021-04-02'),
(205, 10010, 'Debit Card', 1550, '2021-04-03');
 
INSERT into Medicine values
(10201, 50, 195, '2022-01-12'),
(10202, 100, 105, '2022-05-01'),
(10203, 1000, 25, '2022-12-01'),
(10204, 780, 15, '2022-11-01'),
(10205, 10, 50, '2022-08-01'),
(10206, 2350, 43, '2022-07-21'),
(10207, 18, 18, '2022-06-30');
Insert into Facilities values
(1010, 'X-Ray', 200, 30),
(1011, 'MRI' , 1000, 12),
(1012, 'CT Scan', 2000, 12),
(1013, 'UltraSound',300,20),
(1014, 'Labroratory',1500,11),
(1015, 'Physiothreapy',500,10),
(1016, 'ECG',1000,13)
;
Insert into Department values
(11100, 'ENT', 'Phunsukh'),
(11001, 'EYE', 'Farhan'),
(10100, 'Gastrology','Ramalingam'),
(11000, 'Reception', 'Arushi'),
(11003,'Internal Medicine','Sunita'),
(11004,'Neurology','Victoria'),
(11005,'GS','Appel'),
(11002,'Cardiology','Albert');
Insert into Employees values
(2001, 11100, 'Abhishek', 100000, 'abhishek@gmail.com', 'M', 9999762, 'Palakkad'),
(2007, 10100, 'Priya', 200000, 'priya@gmail.com', 'F', 9912234, 'Mumbai'),
(1101, 11100, 'Shyam', 20000, 'shyam@gmail.com', 'M', 9923445, 'Mumbai'),
(1000, 10100, 'Shweta', 20000, 'shweta@gmail.com', 'F', 9985433, 'Palakkad'),
(3000, 11000, 'Sonu', 30000, 'sonu@gmail.com', 'M', 9128243, 'Delhi'),
(3001, 11100, 'Phunsukh', 30000, 'Phunsukh@gmail.com', 'M', 9122343, 'Delhi'),
(3002, 11001, 'Farhan', 30000, 'Farhan@gmail.com', 'M', 9167843, 'Delhi'),
(3003, 10100, 'Ramalingam', 30000, 'Ramalingam@gmail.com', 'M', 9745343, 'Delhi'),
(3004, 11000, 'Arushi', 30000, 'Arushi@gmail.com', 'F', 9000000, 'Delhi'),
(3111, 11000, 'Sweety', 30000, 'sweety@gmai.com', 'F', 9557709, 'Mumbai'), 
(2003,11003,'Sunita',60000,'SunitaMishra@gmail.com','F',6854684,'Gaziabad'),
(2004,11003,'Vivek',90000,'Vivek@gmail.com','M',9856744,'Goa'),
(2005,11004,'Victoria',120000,'Victoria123@gmail.com','F',9867235,'Pune'),
(2006,11005,'Appel',80000,'Appel1@gmail.com','M',8754698,'Pune'),
(2002,11002,'Albert',100000,'albert@gmail.com','M',6254697,'Chandigarh'),
(1001,11003,'Isabella',30000,'Isabells@gmail.com','F',7845616,'Mumbai'),
(1002,11005,'Jenny',35000,'Jenny@gmail.com','F',8561894,'Mumbai'),
(1003,11002,'Emma',55000,'Emma@gmail.com','F',6941847,'Mumbai')
;
Insert into Doctor values
(1441, 2001, 'MD','ENT', 500),
(1442, 2002, 'MBBS','Cardiologist', 500),
(1443, 2003, 'MD','Physician', 500),
(1444, 2004, 'MD','Cancer', 500),
(1445, 2005, 'MD','Neurologist', 500),
(1446, 2006, 'MD','General surgeon', 500),
(1417, 2007, 'MBBS', 'Gastrologist', 500);
Insert into Nurse values
(1551, 1101, 5),
(1512, 1000, 7),
(1513, 1001, 2),
(1514, 1002, 3),
(1515, 1003, 8);
Insert into Receptionist values
(2122, 3000),
(2123, 3001),
(2124, 3002),
(2125, 3003),
(2126, 3004),
(2222, 3111);
Insert into Rooms values
(6113, 'OneStar', 0, 'General', 15, 500),
(6114, 'OneStar non\AC', 1, 'Private', 1, 1000),
(6115, 'OneStar AC', 1, 'Private', 1, 1000),
(6116, 'Critical', 1, 'ICU', 10, 10000),
(6117, 'Emergency', 1, 'Operation theatre', 1, 20000),
(6118, 'TwoStar', 2, 'Private', 1, 2500);
Insert into Records values
(1, 21100, '2021-03-28', 'Stomach pain, Intestinal infection'),
(2, 21100, '2021-03-31', 'Fever'),
(3, 21100, '2021-04-01', 'Vomit'),
(4, 21102, '2021-03-31', 'COVID-19 positive'),
(5, 21101, '2021-03-28', 'Heart attack'),
(6, 21103, '2021-04-01', 'Ear surgery'),
(7, 21104, '2021-04-02', 'Blood cancer'),
(8, 31212, '2021-04-01', 'Stomach Pain'),
(9, 31213, '2021-04-02', 'Diabetes checkup'),
(10, 31214, '2021-04-02', 'Thyroid'),
(11, 31215, '2021-04-02', 'Migraine'),
(12, 31216, '2021-04-03', 'Viral infection');
Insert into Insured values
(101, 1002),
(103, 1003),
(104, 1004);
Insert into Prescription values
(100, 10201),
(100, 10206),
(101, 10206),
(101, 10203),
(102, 10203),
(102, 10204),
(102, 10206),
(103, 10207),
(104, 10201),
(201, 10201),
(201, 10202),
(202, 10202),
(202, 10204),
(202, 10207),
(203, 10201),
(203, 10205),
(204, 10205),
(205, 10202);
Insert into InPatient values
(21100, 'John', 'M', '2021-03-28','2021-04-03', 9902143, 'Mumbai', 1417),
(21101, 'Taylor', 'M', '2021-03-28','2021-04-01', 9905169, 'Mumbai', 1442),
(21102, 'Ovi', 'M', '2021-03-31','2021-04-17', 9912349, 'Delhi', 1443),
(21103, 'James', 'M', '2021-04-01','2021-04-03', 8348355, 'Gandhinagar', 1441),
(21104, 'Maria', 'F', '2021-04-02','2021-04-05', 2015733, 'Mumbai', 1444);
Insert into OutPatient values
(31212, 'Spock', 'M', '2021-04-01', 9546546, 'Mumbai', 1417),
(31213, 'Saurav', 'M', '2021-04-02', 9512345, 'Kalyan', 1443),
(31214, 'Raj', 'M', '2021-04-02', 9578901, 'Thane', 1443),
(31215, 'lara', 'F', '2021-04-02', 9514226, 'Nashik', 1445),
(31216, 'sofia', 'F', '2021-04-03', 1432345, 'Pune', 1443);
Insert into OutUses values
(31212, 1013),
(31213, 1014),
(31214, 1014),
(31216, 1014);
Insert into InUses values
(21100, 1014),
(21100, 1013),
(21101, 1016),
(21104, 1014),
(21102, 1014);
Insert into InPayment values
(100, 21100),
(101, 21101),
(102, 21102),
(103, 21103),
(104, 21104);
Insert into OutPayment values
(201, 31212),
(202, 31213),
(203, 31214),
(204, 31215),
(205, 31216);
Insert into OutHave values
(31212,8),
(31213,9),
(31214,10),
(31215,11),
(31216,12);
Insert into InHave values
(21100,1),
(21100,2),
(21100,3),
(21102,4),
(21101,5),
(21103,6),
(21104,7);
Insert into Manages values
(2122, 1),
(2122, 2),
(2122, 3),
(2222, 4),
(2122, 5),
(2122, 6),
(2222, 7),
(2122, 8),
(2222, 9),
(2122, 10),
(2122, 11),
(2222, 12);
Insert into Allocated values
(21100, 6116, 2),
(21100, 6115, 1),
(21101, 6116, 3),
(21101, 6118, 1),
(21102, 6116, 10),
(21102, 6114, 1),
(21103, 6117, 1),
(21103, 6115, 1),
(21104, 6113, 13);
Insert into Supervision values
(6113, 1551),
(6114, 1512),
(6115, 1513),
(6116, 1514),
(6118, 1515);
 
  
 

