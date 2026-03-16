
-- ЛАБОРАТОРНА РОБОТА №3 (Процедури)


CREATE OR REPLACE PROCEDURE update_complexity (
    p_proj_id IN NUMBER,
    p_new_complexity IN VARCHAR2
) AS
BEGIN
    UPDATE projects
    SET complexity = p_new_complexity
    WHERE project_id = p_proj_id;
    COMMIT;
END;


BEGIN
    update_complexity(1, 'Medium');
END;



SELECT project_id, title, complexity 
FROM projects 
WHERE project_id = 1;