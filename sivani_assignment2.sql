-- DATABASE DESIGN:

--STUDENTS TABLE:
create table Students (student_id int Primary key,
first_name varchar(30),
last_name varchar(30),
dob date,
email varchar(40),
phonenumber varchar(20));

insert into Students(student_id,first_name,last_name,dob,email,phonenumber)
values(401,'sivani','kolla','2003-09-08','sivanikolla@gmail.com',9398097164),
(402,'joshika','dintakurthi','2003-10-016','joshikad@gmail.com',9398065166),
(403,'kusuma','sree','2003-06-02','kusumasree@gmail.com',9395696564),
(404,'likhitha','gannina','2002-08-28','likhithag@gmail.com',9322097587),
(405,'pavani','kumari','2002-10-20','kpavani@gmail.com',9491865758),
(406,'sahithi','krishna','2002-09-17','sahithik@gmail.com',9556971125)
(407,'praneetha','varri','2002-5-21','varripraneetha@gmail.com',9009003636),
(408,'hema','raj','2001-02-01','hemaraj@gmail.com',9023014555),
(409,'sri','harshitha','2001-11-27','honeykks@gmail.com',9556664871),
(410,'abhi','kumar','2001-03-22','abhik@gmail.com',9299605348)
select*from Students

--TEACHER TABLE:
create table Teacher(teacher_id int Primary Key
,first_name varchar(30)
,last_name varchar(30)
,email varchar(40));

insert into Teacher(teacher_id,first_name,last_name,email)
values(101,'avantika','bhatia','avantikab@gmail.com'),
(102,'shiva','kumar','shivakumar@gmail.com'),
(103,'kumar','varma','kumarvarma@gmail.com'),
(104,'kapil','dev','kapildev@gmail.com'),
(105,'mahendra','singh','msd@gmail.com'),
(106,'virat','kohli','viratkohli@gmail.com'),
(107,'pathirana','mateesha','mpathirana@gmail.com'),
(108,'jadeja','ravindra','ravijadeja@gmail.com'),
(109,'smriti','mandanna','smritim@gmail.com'),
(110,'nikhitha','durgam','nikithad@gmail.com')
select*from Teacher

--COURSES TABLE:

create table Courses(course_id int Primary Key,
course_name varchar(30),
credits int,teacher_id  int 
Foreign Key(teacher_id) references Teacher(teacher_id))

insert into Courses(course_id,course_name,credits,teacher_id)
values(1,'java',5,101),
(2,'sql',5,102),
(3,'c#',8,103),
(4,'python',3,104),
(5,'html',6,105),
(6,'css',3,106),
(7,'javascript',6,107),
(8,'cloud computing',3,108),
(9,'data structures',5,109),
(10,'web development',8,110)
select*from Courses

--ENROLLMENTS TABLE:
create table Enrollments(enrollment_id int Primary Key,
student_id int,
course_id int,
enrollment_date date
foreign key(student_id) references Students(student_id),
foreign key(course_id) references Courses(course_id))

insert into Enrollments(enrollment_id,student_id,course_id,enrollment_date)
values(201,401,1,'2024-01-12'),
(202,402,2,'2024-01-12'),
(203,403,3,'2024-01-18'),
(204,404,4,'2024-02-04'),
(205,405,5,'2024-02-12'),
(206,406,6,'2024-02-26'),
(207,407,7,'2024-03-10'),
(208,408,8,'2024-03-12'),
(209,409,9,'2024-03-21'),
(210,410,10,'2024-03-23')
select*from Enrollments

--PAYMENTS TABLE:
create table Payments(payment_id int Primary Key,
student_id int,
amount int,
payment_date date
foreign key (student_id) references Students(student_id))

insert into Payments(payment_id ,student_id,amount,payment_date)
values(301,401,1000,'2024-01-12'),
(302,402,1000,'2024-01-12'),
(303,403,2000,'2024-01-18'),
(304,404,500,'2024-02-04'),
(305,405,1400,'2024-02-12'),
(306,406,1000,'2024-02-26'),
(307,407,1600,'2024-03-10'),
(308,408,800,'2024-03-12'),
(309,409,1000,'2024-03-21'),
(310,410,1800,'2024-03-23')
select*from Payments
select*from Enrollments
select*from Courses
select*from Teacher
select*from Students


--TASK 2:
1:--Write an SQL query to insert a new student into the "Students" table with the following details:
a.-- First Name: John
b.-- Last Name: Doe
c.-- Date of Birth: 1995-08-15
d.-- Email: john.doe@example.com
e.-- Phone Number: 1234567890

insert into Students values(411,'john','doe','1995-08-15','john.doe@example.com', 1234567890)

2:--Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.

insert into Enrollments values(211,403,3,'2024-02-04')

3:--Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.

update Teacher set email='mahendrasingh@gmail.com' where teacher_id=105

4:--Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course.
delete from Enrollments where student_id=402 and course_id=2

5:--Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.

update Courses set teacher_id=104 where course_id=2

6:--Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity
ALTER TABLE Enrollments
DROP CONSTRAINT FK_Studentid; 
ALTER TABLE Enrollments
ADD CONSTRAINT FK_Studentid 
FOREIGN KEY (student_id) REFERENCES Students(student_id)
ON DELETE CASCADE;

7:--Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.
update Payments set amount=800 where payment_id=304

--TASK 3:

1:-- Write an SQL query to calculate the total payments made by a specific student. You will need to
--join the "Payments" table with the "Students" table based on the student's ID.
SELECT s.student_id,s.first_name,s.last_name,sum(p.amount) as total_payment
FROM Payments p
JOIN Students s ON p.student_id=s.student_id
WHERE s.student_id=406
GROUP BY s.student_id,s.first_name,s.last_name

alter table Payments alter column amount int;

2:--Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. 
--Use a JOIN operation between the "Courses" table and the "Enrollments" table.

SELECT Courses.course_id,Courses.course_name, 
COUNT(Enrollments.student_id) AS enrolled_students_count from Courses
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
GROUP BY Courses.course_id, Courses.course_name;

3:--Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table 
--to identify students without enrollments.
SELECT Students.first_name,Students.last_name FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
Where Enrollments.student_id IS NULL;

4:--Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in.
--Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.

SELECT  Students.first_name, Students.last_name, Courses.course_name FROM  Students
JOIN  Enrollments ON Students.student_id = Enrollments.student_id
JOIN  Courses ON Enrollments.course_id = Courses.course_id;

5:--Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

SELECT CONCAT(Teacher.first_name, ' ', Teacher.last_name) AS teacher_name, Courses.course_name
FROM Teacher
JOIN Courses ON Teacher.teacher_id = Courses.teacher_id;

6:--Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables

SELECT Students.first_name,Students.last_name,Enrollments.enrollment_date from Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
WHERE Courses.course_name = 'java'

7:--Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.

SELECT Students.first_name,Students.last_name from Students
LEFT JOIN Payments ON Students.student_id = Payments.student_id
WHERE Payments.student_id IS NULL;

8:--Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and
--filter for courses with NULL enrollment records.

SELECT Courses.course_name from Courses
LEFT JOIN Enrollments on Courses.course_id=Enrollments.course_id
WHERE Enrollments.course_id IS NULL;

9:--Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.
SELECT DISTINCT e1.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM Enrollments e1
JOIN Enrollments e2 ON e1.student_id = e2.student_id AND e1.course_id <> e2.course_id
JOIN Students s ON e1.student_id = s.student_id;

10:-- Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.
SELECT CONCAT(Teacher.first_name, ' ', Teacher.last_name) AS teacher_name, Courses.course_name FROM Teacher
INNER JOIN Courses on Teacher.teacher_id=Courses.teacher_id
where Courses.teacher_id is NULL


TASK 4:
select*from Payments
select*from Enrollments
select*from Courses
select*from Teacher
select*from Students

1:--Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.
select course_id, avg(enrollmentcount) as avgenrollment
from (select course_id, count(student_id) as enrollmentcount
from enrollments 
group by course_id
) as totenrollment
group by course_id

2:--Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.select student_id,amount from Payments where amount=(
select max(amount) from Payments)

3:--Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count.
select course_id, course_name, 
(select COUNT(*) from Enrollments where Enrollments.course_id = Courses.course_id) as enrollment_count
from Courses
order by enrollment_count DESC


4:--Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses. select teacher_id, sum(payment) as totalpayments
from(select c.teacher_id, p.amount as payment
from courses c
join enrollments e on c.course_id = e.course_id
join payments p on e.student_id = p.student_id
) as payments
group by teacher_id

5:--Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.select student_id from enrollments
group by student_id
having count(distinct course_id)=(
select count(distinct course_id) from courses)

6:--Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.
select first_name,last_name from teacher
where teacher_id not in(
select  teacher_id from courses)

7:--Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.
select avg(student_age) as average_age
from(select DATEDIFF(YEAR, dob, GETDATE()) AS student_age
from Students) 
as student_age

8:--Identify courses with no enrollments. Use subqueries to find courses without enrollment records.select course_id,course_name from Courseswhere course_id not in(select course_id from enrollments)9:--Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments.select e.student_id,sum(amount) as totalpayments from payments p
join enrollments e on p.student_id = e.student_id
group by e.student_id

10:-- Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student
--and filter for those with counts greater than one.
select s.student_id, payment_count.totalpayments from students s
join (select p.student_id, count(p.payment_id) as totalpayments
from payments p
group by p.student_id
having count(p.payment_id) > 1
)as payment_count on s.student_id = payment_count.student_id

11:--Write an SQL query to calculate the total payments made by each student.
--Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
select s.student_id,s.first_name,sum(p.amount) as totalpayment from Students s
join payments p on s.student_id = p.student_id
group by s.student_id, s.first_name

12:--. Retrieve a list of course names along with the count of students enrolled in each course. 
--Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.
select c.course_name, count(e.student_id) as noofstudents from courses c
join enrollments e on c.course_id = e.course_id
group by c.course_name

13:--Calculate the average payment amount made by students.
--Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.
select s.first_name,avg(p.amount) as avgpayment from students s
JOIN Payments p on s.student_id=p.student_id
group by s.first_name

