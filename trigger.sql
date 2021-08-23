DROP TRIGGER IF EXISTS record_check;
delimiter $$
CREATE TRIGGER record_check BEFORE INSERT ON Records
FOR EACH ROW
BEGIN 
IF EXISTS (SELECT Patient_ID from InPatient where Patient_ID = NEW.Patient_ID) THEN
SET @date_admit = (SELECT  Date_Admitted from InPatient where Patient_ID = NEW.Patient_ID);
SET @date_discharge = (SELECT Date_Discharged from InPatient where Patient_ID = NEW.Patient_ID);
IF NOT (NEW.Date BETWEEN @date_admit AND @date_discharge) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR:
            DATE is not between';
END IF;
END IF;

IF EXISTS (SELECT Patient_ID from OutPatient where Patient_ID = NEW.Patient_ID) THEN
SET @date_visited = (SELECT Date_Visited from OutPatient where Patient_ID = NEW.Patient_ID);
IF NOT (NEW.Date = @date_visited) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR:
            DATE is not okay';
END IF;
END IF;
END; $$
delimiter ;

DROP TRIGGER IF EXISTS attendence_toggle_Records;
delimiter $$
CREATE TRIGGER attendence_toggle_Records AFTER INSERT ON Manages
FOR EACH ROW
BEGIN 
UPDATE Employees
SET present = 'Present'
WHERE Employee_ID = (SELECT Employee_ID from Receptionist where Receptionist_ID = NEW.Receptionist_ID);
END; $$
delimiter ;


