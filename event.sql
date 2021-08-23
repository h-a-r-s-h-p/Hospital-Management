SET GLOBAL event_scheduler = ON;
delimiter //
CREATE EVENT day_reset
    ON SCHEDULE EVERY 1 DAY
            STARTS '2021-05-01 23:59:59' 
    DO
        BEGIN 
            DELETE FROM appointment 
            WHERE status = 'Done';
            SET @date = curdate();
            SET @newdate = DATE_ADD(@date,INTERVAL 1 DAY);
            UPDATE appointment
            SET appt_date = @newdate
            WHERE status = 'Pending' and appt_date <= @date; 

        END //
delimiter ;

delimiter // 
CREATE EVENT toggle
    ON SCHEDULE
        EVERY 8 HOUR
            STARTS '2021-05-06 08:00:00'
    DO
        BEGIN
            UPDATE Employees
            SET present = 'Absent';
        END //
delimiter ;