DELIMITER //
CREATE PROCEDURE init_attendance()
BEGIN
ALTER TABLE Employees ADD present varchar(10) NOT NULL DEFAULT('Absent');
ALTER TABLE Employees ADD password INT(10) NOT NULL DEFAULT(12345678);
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE mark_attendance(IN ID int(10))
BEGIN
IF (ID in (SELECT Employee_ID FROM Employees))
THEN UPDATE Employees SET present = 'Present' WHERE Employee_ID=ID;
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE drop_attendance(IN ID int(10))
BEGIN
IF (ID in (SELECT Employee_ID FROM Employees))
THEN UPDATE Employees SET present = 'Absent' WHERE Employee_ID=ID;
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE init_appointment()
BEGIN
CREATE TABLE appointment(Doctor_ID int(10), 
Patient_ID int(10) NOT NULL PRIMARY KEY,
appt_date DATE,
status varchar(10) NOT NULL CHECK(status IN('Pending','Done')));
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_appointment(
    IN Name VARCHAR(20),
    IN Sex VARCHAR(4),
    IN appt_date DATE,
    IN Contact INT(10),
    IN Address VARCHAR(30),
    IN Doctor_ID int(10))
BEGIN
SET @ID = (select Patient_ID from OutPatient order by Patient_ID DESC Limit 1)+1;
INSERT INTO OutPatient VALUES(@ID,Name,Sex,appt_date,Contact,Address,Doctor_ID);
INSERT INTO appointment VALUES(Doctor_ID,@ID,appt_date,'Pending');
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE mark_appointment(IN D_ID int(10), IN P_ID int(10))
BEGIN
IF((D_ID,P_ID) IN (SELECT Doctor_ID,Patient_ID FROM appointment))
THEN
UPDATE appointment SET status = 'Done' WHERE Doctor_ID=D_ID AND Patient_ID=P_ID;
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE flush_appointment(IN D_ID int(10))
BEGIN
IF(D_ID IN (SELECT Doctor_ID FROM appointment))
THEN
DELETE FROM appointment WHERE Doctor_ID=D_ID AND status = 'Done';
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE admit_patient(IN P_ID int(10),IN discharge_date DATE)
BEGIN
IF(P_ID in (select Patient_ID from OutPatient))
THEN
SET @ID = (select Patient_ID from InPatient order by Patient_ID DESC Limit 1)+1;
INSERT INTO InPatient SELECT @ID,Name,Sex,Date_Visited,discharge_date,Contact,
Address,Doctor_ID FROM OutPatient WHERE Patient_ID = P_ID;
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_record(IN eid int(10),IN pid int(10),IN rdate DATE, IN info VARCHAR(100))
BEGIN
set @id = (select Record_No from Records order by Record_No DESC limit 1)+1;
IF(eid in (select Employee_ID from Receptionist))
THEN
set @rid = (select Receptionist_ID from Receptionist where Employee_ID = eid);
Insert into Records values(@id,pid,rdate,info);
Insert into Manages values(@rid,@id);
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_facility(IN pid int(10),IN fid int(10))
BEGIN
IF(pid in (select Patient_ID from InPatient))
THEN
INSERT INTO InUses VALUES(pid,fid);
ELSE
IF(pid in (select Patient_ID from OutPatient))
THEN
INSERT INTO OutUses VALUES(pid,fid);
END IF;
END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_bill(IN pid int(10),IN mode varchar(20), amt int(10), tdate date)
BEGIN
SET @tid = (select Transaction_ID from Bill order by Transaction_ID desc limit 1)+1;
IF(pid in (select Patient_ID from InPatient))
THEN
SET @rid = (select Reciept_ID from InPayment order by Reciept_ID desc limit 1)+1;
INSERT INTO Bill VALUES(@rid,@tid,mode,amt,tdate);
INSERT INTO InPayment VALUES(@rid,pid);
ELSE
IF(pid in (select Patient_ID from OutPatient))
THEN
SET @rid = (select Reciept_ID from OutPayment order by Reciept_ID desc limit 1)+1;
INSERT INTO Bill VALUES(@rid,@tid,mode,amt,tdate);
INSERT INTO OutPayment VALUES(@rid,pid);
END IF;
END IF;
END;
//
DELIMITER ;


CALL init_attendance();
CALL init_appointment();