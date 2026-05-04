create database university_db;
use university_db;

create table students (
    studentid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    birthdate date,
    enrollmentdate date
);

insert into students values
(1,'john','doe','john@email.com','2000-01-15','2022-08-01'),
(2,'jane','smith','jane@email.com','1999-05-25','2021-08-01'),
(3,'rahul','patel','rahul@email.com','2001-03-12','2023-08-01'),
(4,'neha','shah','neha@email.com','2000-07-20','2022-08-01'),
(5,'amit','verma','amit@email.com','2002-02-10','2024-08-01');


create table departments (
    departmentid int primary key,
    departmentname varchar(100)
);

insert into departments values
(1,'computer science'),
(2,'mathematics'),
(3,'physics'),
(4,'commerce'),
(5,'arts');

create table courses (
    courseid int primary key,
    coursename varchar(100),
    departmentid int,
    credits int,
    foreign key (departmentid) references departments(departmentid)
);

insert into courses values
(101,'introduction to sql',1,3),
(102,'data structures',1,4),
(103,'calculus',2,4),
(104,'quantum physics',3,5),
(105,'accounting',4,3);

create table instructors (
    instructorid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    departmentid int,
    salary decimal(10,2),
    foreign key (departmentid) references departments(departmentid)
);


insert into instructors values
(1,'alice','johnson','alice@univ.com',1,50000),
(2,'bob','lee','bob@univ.com',2,55000),
(3,'carol','mehta','carol@univ.com',1,60000),
(4,'david','kumar','david@univ.com',3,52000),
(5,'emma','shah','emma@univ.com',4,48000);

create table enrollments (
    enrollmentid int primary key,
    studentid int,
    courseid int,
    enrollmentdate date,
    foreign key (studentid) references students(studentid),
    foreign key (courseid) references courses(courseid)
);

insert into enrollments values
(1,1,101,'2022-08-01'),
(2,2,102,'2021-08-01'),
(3,3,101,'2023-08-01'),
(4,4,103,'2022-08-01'),
(5,5,104,'2024-08-01');




-- update
update students
set email = 'ravi123@email.com'
where studentid = 6;

-- delete
delete from students
where studentid = 6;

-- select
select * from students;

select *
from students
where enrollmentdate > '2022-12-31';

select c.*
from courses c
join departments d on c.departmentid = d.departmentid
where d.departmentname = 'mathematics'
limit 5;

select courseid, count(studentid) as total_students
from enrollments
group by courseid
having count(studentid) > 5;

select s.studentid, s.firstname
from students s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid
where c.coursename in ('introduction to sql','data structures')
group by s.studentid
having count(distinct c.courseid) = 2;

select distinct s.*
from students s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid
where c.coursename in ('introduction to sql','data structures');

select avg(credits) as avg_credits
from courses;

select max(i.salary) as max_salary
from instructors i
join departments d on i.departmentid = d.departmentid
where d.departmentname = 'computer science';

select d.departmentname, count(e.studentid) as total_students
from departments d
join courses c on d.departmentid = c.departmentid
join enrollments e on c.courseid = e.courseid
group by d.departmentname;

select s.firstname, c.coursename
from students s
join enrollments e on s.studentid = e.studentid
join courses c on e.courseid = c.courseid;

select s.firstname, c.coursename
from students s
left join enrollments e on s.studentid = e.studentid
left join courses c on e.courseid = c.courseid;

select *
from students
where studentid in (
    select studentid
    from enrollments
    where courseid in (
        select courseid
        from enrollments
        group by courseid
        having count(studentid) > 10
    )
);


select firstname, year(enrollmentdate) as year
from students;

select concat(firstname,' ',lastname) as full_name
from instructors;

select courseid,
count(studentid) as total,
sum(count(studentid)) over(order by courseid) as running_total
from enrollments
group by courseid;

select firstname,
case
    when timestampdiff(year, enrollmentdate, curdate()) > 4 then 'senior'
    else 'junior'
end as status
from students;
