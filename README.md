# Student-Management

## 📌 project description

this project is a **university course management system** developed using **mysql**. it manages student information, courses, instructors, departments, and enrollments in an organized database structure.

the system demonstrates various sql concepts such as:

* crud operations
* joins
* aggregate functions
* subqueries
* window functions
* case expressions

---

## 🎯 objective

the main objective of this project is to:

* store and manage student records
* manage course and department details
* track student enrollments in courses
* analyze data using sql queries
* generate meaningful reports

---

## 🛠️ technologies used

* mysql (database)
* sql (structured query language)

---

## 🗂️ database schema

### tables used:

1. students
2. courses
3. instructors
4. enrollments
5. departments

---

## 🔗 relationships

* students ↔ enrollments (one-to-many)
* courses ↔ enrollments (one-to-many)
* departments ↔ courses (one-to-many)
* departments ↔ instructors (one-to-many)

---

## ⚙️ functionalities

### 1. crud operations

* insert, update, delete, and retrieve records

### 2. filtering & conditions

* where, having, limit

### 3. sql operators

* and, or

### 4. sorting & grouping

* order by, group by

### 5. aggregate functions

* sum, avg, count, max, min

### 6. joins

* inner join
* left join

### 7. subqueries

* nested queries for advanced data filtering

### 8. date functions

* extract year
* date comparison

### 9. string functions

* concat()

### 10. window functions

* running total

### 11. case expressions

* categorize students as senior or junior

---

## 📊 queries implemented

* retrieve students enrolled after 2022
* find courses in a specific department
* count students per course
* find students enrolled in multiple courses
* calculate average credits
* find maximum instructor salary
* perform joins between multiple tables
* apply subqueries and window functions

---

## 🔐 constraints

* primary keys for all tables
* foreign key relationships between tables
* unique constraint on student and course enrollment

---

## 🚀 how to run the project

1. create database in mysql
2. create all tables
3. insert sample data
4. execute queries step by step

---

## 📌 conclusion

this project shows a strong understanding of **relational database design and sql queries**. it can be extended into a full-stack application with frontend and backend integration.

---


