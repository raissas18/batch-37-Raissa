
CREATE DATABASE hr_core;

USE hr_core;

CREATE TABLE company (
    id_company INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL
);

CREATE TABLE role (
    id_role INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);
   
CREATE TABLE users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    id_company INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,

    FOREIGN KEY (id_company)
    REFERENCES company(id_company)
);


CREATE TABLE department (
    id_department INT AUTO_INCREMENT PRIMARY KEY,
    id_company INT NOT NULL,
    department_name VARCHAR(255) NOT NULL,

    FOREIGN KEY (id_company)
    REFERENCES company(id_company)
);

CREATE TABLE employee (
    id_employee INT AUTO_INCREMENT PRIMARY KEY,
    id_company INT NOT NULL,
    id_department INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    job_role VARCHAR(255),
    hire_date DATE,
    salary DECIMAL(15,2),
    manager_id INT,

    FOREIGN KEY (id_company)
    REFERENCES company(id_company),

    FOREIGN KEY (id_department)
    REFERENCES department(id_department),

    FOREIGN KEY (manager_id)
    REFERENCES employee(id_employee)
);

CREATE TABLE payroll_period (
    id_period INT AUTO_INCREMENT PRIMARY KEY,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    payment_date DATE,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE payroll (
    id_payroll INT AUTO_INCREMENT PRIMARY KEY,
    id_employee INT NOT NULL,
    id_period INT NOT NULL,
    gross_pay DECIMAL(15,2) NOT NULL,
    deductions DECIMAL(15,2) DEFAULT 0,
    net_pay DECIMAL(15,2) NOT NULL,
    status VARCHAR(50) NOT NULL,

    FOREIGN KEY (id_employee)
    REFERENCES employee(id_employee),

    FOREIGN KEY (id_period)
    REFERENCES payroll_period(id_period)
);


CREATE TABLE payroll_detail (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_payroll INT NOT NULL,
    component_name VARCHAR(255) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,

    FOREIGN KEY (id_payroll)
    REFERENCES payroll(id_payroll)
);




INSERT INTO employee (
    id_company,
    id_department,
    full_name,
    email,
    phone,
    job_role,
    hire_date,
    salary,
    manager_id
)
VALUES
(1, 1, 'Andi Saputra', 'andi@gmail.com', '081234567801', 'HR Manager', '2023-01-10', 8000000, NULL),

(1, 1, 'Budi Santoso', 'budi@gmail.com', '081234567802', 'HR Staff', '2023-02-15', 5000000, 1),

(1, 1, 'Siti Amelia', 'siti@gmail.com', '081234567803', 'Recruitment Staff', '2023-03-20', 5500000, 1),

(1, 1, 'Dewi Anggraini', 'dewi@gmail.com', '081234567804', 'HR Admin', '2023-04-12', 4500000, 1),

(1, 1, 'Rina Marlina', 'rina@gmail.com', '081234567805', 'Training Staff', '2023-05-18', 5000000, 1),

(1, 2, 'Rudi Hartono', 'rudi@gmail.com', '081234567806', 'Finance Manager', '2022-01-10', 9000000, NULL),

(1, 2, 'Agus Setiawan', 'agus@gmail.com', '081234567807', 'Finance Staff', '2023-06-10', 5500000, 6),

(1, 2, 'Dina Permata', 'dina@gmail.com', '081234567808', 'Accountant', '2023-07-15', 6000000, 6),

(1, 2, 'Fajar Nugroho', 'fajar@gmail.com', '081234567809', 'Tax Staff', '2023-08-20', 5500000, 6),

(1, 2, 'Lina Kartika', 'lina@gmail.com', '081234567810', 'Finance Admin', '2023-09-12', 4500000, 6),

(1, 3, 'Doni Pratama', 'doni@gmail.com', '081234567811', 'IT Manager', '2022-02-10', 9500000, NULL),

(1, 3, 'Rizky Maulana', 'rizky@gmail.com', '081234567812', 'Programmer', '2023-10-15', 7000000, 11),

(1, 3, 'Yoga Firmansyah', 'yoga@gmail.com', '081234567813', 'Web Developer', '2023-11-20', 6500000, 11),

(1, 3, 'Nanda Putri', 'nanda@gmail.com', '081234567814', 'UI UX Designer', '2024-01-12', 6000000, 11),

(1, 3, 'Arif Ramadhan', 'arif@gmail.com', '081234567815', 'IT Support', '2024-02-18', 5000000, 11),

(1, 4, 'Hendra Wijaya', 'hendra@gmail.com', '081234567816', 'Marketing Manager', '2022-03-10', 8500000, NULL),

(1, 4, 'Putri Lestari', 'putri@gmail.com', '081234567817', 'Marketing Staff', '2024-03-15', 5000000, 16),

(1, 4, 'Dimas Prakoso', 'dimas@gmail.com', '081234567818', 'Digital Marketing', '2024-04-20', 5500000, 16),

(1, 4, 'Bella Safitri', 'bella@gmail.com', '081234567819', 'Content Creator', '2024-05-12', 5000000, 16),

(1, 4, 'Rian Kurniawan', 'rian@gmail.com', '081234567820', 'Marketing Admin', '2024-06-18', 4500000, 16);


CREATE OR REPLACE VIEW view_employee AS
SELECT
    employee.id_employee,
    employee.full_name,
    employee.email,
    employee.phone,
    department.department_name,
    employee.job_role,
    employee.hire_date,
    employee.salary,
    manager.full_name AS manager_name
FROM employee

JOIN department
ON employee.id_department = department.id_department

LEFT JOIN employee AS manager
ON employee.manager_id = manager.id_employee;


CREATE OR REPLACE VIEW view_payroll_hub AS
SELECT
    payroll.id_payroll,
    employee.full_name,
    payroll_period.period_start,
    payroll_period.period_end,
    payroll_period.payment_date,
    payroll.gross_pay,
    payroll.deductions,
    payroll.net_pay,
    payroll.status
FROM payroll

JOIN employee
ON payroll.id_employee = employee.id_employee

JOIN payroll_period
ON payroll.id_period = payroll_period.id_period;





CREATE OR REPLACE VIEW view_payroll_periods AS
SELECT
    payroll_period.id_period,
    payroll_period.period_start,
    payroll_period.period_end,

    COUNT(DISTINCT payroll.id_employee) AS total_employees,

    COALESCE(SUM(payroll.net_pay), 0) AS total_amount,

    payroll_period.status

FROM payroll_period

LEFT JOIN payroll
ON payroll_period.id_period = payroll.id_period

GROUP BY
    payroll_period.id_period,
    payroll_period.period_start,
    payroll_period.period_end,
    payroll_period.status;


