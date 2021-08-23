create view Doctor_name as select D.Doctor_ID, E.Name, D.Specialization from Doctor as D natural join Employees as E; 
create view Patient_doctor as (select p.Patient_ID, p.Name as patient_name, p.Doctor_ID , d.Name as doctor_name from (select Patient_ID,Name,Doctor_ID from InPatient union select Patient_ID,Name,Doctor_ID from OutPatient) as p inner join Doctor_name as d on p.Doctor_ID=d.Doctor_ID);
create view Nurse_schedule as select * from Rooms natural join Supervision natural join Nurse natural join (select Name, Employee_ID from Employees) as e;
create view Record_log as select * from Patient_doctor natural inner join Records;
create view Medicine_log as select * from Patient_doctor natural inner join (select * from InPayment union select * from OutPayment) as p natural inner join Bill natural inner join Prescription natural inner join Medicine;
