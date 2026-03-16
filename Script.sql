

-- 1. СТВОРЕННЯ ПОСЛІДОВНОСТЕЙ (Sequences)
CREATE SEQUENCE seq_positions START WITH 1;
CREATE SEQUENCE seq_qualifications START WITH 1;
CREATE SEQUENCE seq_employees START WITH 1;
CREATE SEQUENCE seq_customers START WITH 1;
CREATE SEQUENCE seq_projects START WITH 1;
CREATE SEQUENCE seq_work_logs START WITH 1;

-- 2. СТВОРЕННЯ ТАБЛИЦЬ (DDL)
CREATE TABLE positions (
    pos_id NUMBER DEFAULT seq_positions.NEXTVAL PRIMARY KEY,
    pos_name VARCHAR2(100) NOT NULL UNIQUE,
    bonus_coeff NUMBER(3,2) CHECK (bonus_coeff >= 1.0)
);

CREATE TABLE qualifications (
    qual_id NUMBER DEFAULT seq_qualifications.NEXTVAL PRIMARY KEY,
    qual_name VARCHAR2(100) NOT NULL UNIQUE,
    hourly_rate NUMBER(10,2) CHECK (hourly_rate > 0)
);

CREATE TABLE employees (
    emp_id NUMBER DEFAULT seq_employees.NEXTVAL PRIMARY KEY,
    full_name VARCHAR2(150) NOT NULL,
    pos_id NUMBER NOT NULL,
    qual_id NUMBER NOT NULL,
    CONSTRAINT fk_emp_pos FOREIGN KEY (pos_id) REFERENCES positions(pos_id),
    CONSTRAINT fk_emp_qual FOREIGN KEY (qual_id) REFERENCES qualifications(qual_id)
);

CREATE TABLE customers (
    customer_id NUMBER DEFAULT seq_customers.NEXTVAL PRIMARY KEY,
    company_name VARCHAR2(150) NOT NULL UNIQUE,
    has_debt NUMBER(1) DEFAULT 0 CHECK (has_debt IN (0, 1))
);

CREATE TABLE projects (
    project_id NUMBER DEFAULT seq_projects.NEXTVAL PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    customer_id NUMBER NOT NULL,
    manager_id NUMBER NOT NULL,
    complexity VARCHAR2(50) CHECK (complexity IN ('Low', 'Medium', 'High')),
    start_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_proj_cust FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_proj_mgr FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE work_logs (
    log_id NUMBER DEFAULT seq_work_logs.NEXTVAL PRIMARY KEY,
    emp_id NUMBER NOT NULL,
    project_id NUMBER NOT NULL,
    hours_worked NUMBER(4,2) CHECK (hours_worked > 0 AND hours_worked <= 10),
    description VARCHAR2(500),
    CONSTRAINT fk_log_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    CONSTRAINT fk_log_proj FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- 3. НАПОВНЕННЯ ДАНИМИ (DML)
INSERT INTO positions (pos_name, bonus_coeff) VALUES ('Developer', 1.1);
INSERT INTO positions (pos_name, bonus_coeff) VALUES ('QA', 1.0);
INSERT INTO positions (pos_name, bonus_coeff) VALUES ('Team Lead', 1.25);

INSERT INTO qualifications (qual_name, hourly_rate) VALUES ('Junior', 20);
INSERT INTO qualifications (qual_name, hourly_rate) VALUES ('Middle', 35);
INSERT INTO qualifications (qual_name, hourly_rate) VALUES ('Senior', 50);

INSERT INTO employees (full_name, pos_id, qual_id) VALUES ('Alex Dev', 1, 1);
INSERT INTO employees (full_name, pos_id, qual_id) VALUES ('Max Manager', 3, 3);
INSERT INTO employees (full_name, pos_id, qual_id) VALUES ('Anna QA', 2, 2);

INSERT INTO customers (company_name, has_debt) VALUES ('Google', 0);
INSERT INTO customers (company_name, has_debt) VALUES ('Nova Poshta', 0);

INSERT INTO projects (title, customer_id, manager_id, complexity) VALUES ('AI Search', 1, 2, 'High');
INSERT INTO projects (title, customer_id, manager_id, complexity) VALUES ('Delivery App', 2, 2, 'Medium');

INSERT INTO work_logs (emp_id, project_id, hours_worked, description) VALUES (1, 1, 8, 'Coding backend');
INSERT INTO work_logs (emp_id, project_id, hours_worked, description) VALUES (3, 2, 6, 'Testing app');

COMMIT;