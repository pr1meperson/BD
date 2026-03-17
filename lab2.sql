SELECT title, complexity, start_date 
FROM projects 
WHERE complexity = 'High' 
   OR (complexity = 'Medium' AND start_date >= TO_DATE('2026-01-01', 'YYYY-MM-DD'))
ORDER BY start_date DESC;


SELECT qual_name AS "Кваліфікація", 
       hourly_rate AS "Ставка за годину ($)", 
       (hourly_rate * 8) AS "Денна ставка ($)"
FROM qualifications 
ORDER BY hourly_rate DESC;

SELECT e.full_name AS "Працівник", 
       p.title AS "Проект", 
       w.hours_worked AS "Години"
FROM employees e
JOIN work_logs w ON e.emp_id = w.emp_id
JOIN projects p ON w.project_id = p.project_id
WHERE w.hours_worked > 5 
  AND (p.complexity = 'High' OR p.complexity = 'Medium')
ORDER BY w.hours_worked DESC;


SELECT c.company_name AS "Замовник", 
       NVL(p.title, 'Немає активних проектів') AS "Проект"
FROM customers c
LEFT JOIN projects p ON c.customer_id = p.customer_id;

SELECT p.title AS "Проект", 
       SUM(w.hours_worked) AS "Всього годин"
FROM projects p
JOIN work_logs w ON p.project_id = w.project_id
GROUP BY p.title;

SELECT full_name AS "Працівники на складних проектах"
FROM employees 
WHERE emp_id IN (
    SELECT w.emp_id 
    FROM work_logs w
    JOIN projects p ON w.project_id = p.project_id
    WHERE p.complexity = 'High'
);

UPDATE qualifications 
SET hourly_rate = hourly_rate + 5 
WHERE qual_name = 'Junior';


DELETE FROM work_logs
WHERE hours_worked < 2;

COMMIT;
