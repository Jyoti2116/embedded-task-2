SELECT 
    a.assignment_id,
    t.task_name,
    c.course_name
FROM Assignment a
JOIN Task t ON a.assignment_id = t.assignment_id
JOIN Course c ON a.course_id = c.course_id;

-- Task 2
SELECT 
    a.assignment_id,
    a.assignment_name,
    t.task_name,
    c.course_name
FROM Assignment a
JOIN Task t ON a.assignment_id = t.assignment_id
JOIN Course c ON a.course_id = c.course_id;

-- task 3
SELECT
    c.completion_id,
    c.completion_time,
    a.assignment_id,
    t.task_name
FROM Completion c
JOIN Task t ON c.task_id = t.task_id
JOIN Assignment a ON t.assignment_id = a.assignment_id;

-- task 4
SELECT
    c.completion_id,
    c.completion_time,
    a.assignment_name,
    t.task_name
FROM Completion c
JOIN Task t ON c.task_id = t.task_id
JOIN Assignment a ON t.assignment_id = a.assignment_id;

-- ts\k 5
SELECT
    s.student_name,
    c.course_name,
    g.grade,
    g.credits_earned
FROM Grade g
JOIN Student s ON g.student_id = s.student_id
JOIN Course c ON g.course_id = c.course_id;

-- task 6
SELECT
    s.student_name,
    c.course_name,
    g.grade
FROM Grade g
JOIN Student s ON g.student_id = s.student_id
JOIN Course c ON g.course_id = c.course_id;


-- tsk 7
SELECT
    s.student_name,
    t.task_name,
    c.completion_time
FROM Completion c
JOIN Student s ON c.student_id = s.student_id
JOIN Task t ON c.task_id = t.task_id;

-- task 8

SELECT
    c.course_name,
    COUNT(a.assignment_id) AS assignment_count
FROM Course c
LEFT JOIN Assignment a ON c.course_id = a.course_id
GROUP BY c.course_name;

-- task 9
SELECT
    c.course_name,
    c.course_description
FROM Course c
LEFT JOIN Assignment a ON c.course_id = a.course_id
WHERE a.assignment_id IS NULL;

-- task 10
SELECT
    a.assignment_id,
    t.task_name,
    c.completion_time
FROM Completion c
JOIN Task t ON c.task_id = t.task_id
JOIN Assignment a ON t.assignment_id = a.assignment_id
WHERE c.completion_time > '2025-01-01';

-- task 11

SELECT
    s.student_name,
    s.major
FROM Student s
LEFT JOIN Grade g ON s.student_id = g.student_id
WHERE g.credits_earned IS NULL;

-- task 12
SELECT
    c.course_name,
    COUNT(DISTINCT g.student_id) AS total_students,
    AVG(g.grade) AS average_grade,
    SUM(g.credits_earned) AS total_credits
FROM Course c
JOIN Grade g ON c.course_id = g.course_id
GROUP BY c.course_name;
