CREATE DATABASE university_db;
USE university_db;
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT,
    credits INT
);

CREATE TABLE Assignment (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    assignment_name VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Task (
    task_id INT PRIMARY KEY,
    assignment_id INT,
    task_name VARCHAR(100),
    FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    major VARCHAR(100)
);

CREATE TABLE Completion (
    completion_id INT PRIMARY KEY,
    student_id INT,
    task_id INT,
    completion_time DATE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (task_id) REFERENCES Task(task_id)
);

CREATE TABLE Grade (
    student_id INT,
    course_id INT,
    grade DECIMAL(4,2),
    credits_earned INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);
