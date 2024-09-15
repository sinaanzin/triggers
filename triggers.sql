create table teachers (id int , name varchar(20), subject varchar(20), experience int, salary int);
insert into teachers(id ,name, subject, experience,  salary) values 
(1,'Anu', 'Mathematics', 5, 50000),
(2,'JAchy', 'Science', 8, 55000),
(3,'Carol', 'English', 12, 60000),
(4,'Yash', 'History', 6, 52000),
(5,'Renji', 'Art', 4, 47000),
(6,'Neymar', 'Geography', 11, 58000),
(7,'Lusy', 'Physics', 9, 53000),
(8,'Hank', 'Chemistry', 7, 51000);
select * from teachers;

delimiter $$
create trigger before_insert_teacher 
before insert on teachers for each row
begin
if new.salary<0 then
signal sqlstate '45000' set message_text ='Salary cannot be negative';
end if;
end $$
delimiter ;
/*insert into teachers(id ,name, subject, experience,  salary) values 
(9,'habee', 'Hindi', 9, -1);*/

create table teacher_log(log_id int ,teacher_id int, action varchar(20),timestamp datetime);
delimiter $$
create trigger after_insert_teacher 
after insert on teachers for each row
begin
insert into teacher_log(teacher_id,action,timestamp) values
(new.id,'insert',now());
end $$
delimiter ;

delimiter $$
create trigger before_delete_teacher
before delete on teachers for each row
begin
if old.experience>7 then
signal sqlstate '45000' set message_text= 'Cant delete teachers with experience more then 7';
end if;
end $$
delimiter ;

delimiter $$
create trigger after_delete_teacher 
after delete on teachers for each row
begin
insert into teacher_log(teacher_id,action,timestamp) values
(old.id,'delete',now());
end $$
delimiter ;


