DROP DATABASE IF EXISTS hospital_db;
CREATE DATABASE hospital_db;
USE hospital_db;
SHOW TABLES;

set SQL_SAFE_UPDATES = 0;
DROP TABLE IF EXISTS medical_device_data;
DROP TABLE IF EXISTS billing;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(15),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100)
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    patient_id INT,
    amount DECIMAL(10,2),
    date_issued DATE,
    status VARCHAR(20),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE medical_device_data (
    data_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    device_type VARCHAR(50),
    value VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE
);


-- Index (Safe)

CREATE INDEX idx_patient_name ON patients(first_name, last_name);
CREATE INDEX idx_patient_email ON patients(email);
CREATE INDEX idx_appointment_date ON appointments(appointment_date);
CREATE INDEX idx_billing_status ON billing(status);



-- Doctor Data Insertion 

-- 20 base + 40 extended
-- IDs: 1 → 60
INSERT INTO doctors (first_name, last_name, specialization) VALUES
('Emily','White','Cardiology'),('John','Smith','Neurology'),('Aisha','Khan','Pediatrics'),
('Sarah','Chen','Dermatology'),('Michael','Brown','Orthopedics'),
('David','Lee','Gastroenterology'),('Jessica','Wilson','Oncology'),
('Daniel','Martinez','Radiology'),('Laura','Garcia','Endocrinology'),
('James','Rodriguez','Pulmonology'),
('Linda','Hernandez','Rheumatology'),('Robert','King','Urology'),
('Patricia','Lopez','Ophthalmology'),('Charles','Gonzalez','ENT'),
('Barbara','Perez','Psychiatry'),('William','Scott','General Surgery'),
('Elizabeth','Green','Gynecology'),('Thomas','Baker','Nephrology'),
('Jennifer','Adams','Allergy & Immunology'),
('Richard','Nelson','Infectious Disease');



-- Insert 20 Patients
INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address) VALUES
('Alice', 'Johnson', '1990-05-15', 'Female', '555-0101', 'alice@email.com', '123 Main St'),
('Bob', 'Smith', '1985-11-30', 'Male', '555-0102', 'bob@email.com', '456 Oak Ave'),
('Charlie', 'Davis', '2015-10-02', 'Male', '555-0103', 'charlie@email.com', '789 Pine Ln'),
('Diana', 'Evans', '1978-02-20', 'Female', '555-0104', 'diana@email.com', '101 Maple Dr'),
('Ethan', 'Taylor', '1992-07-14', 'Male', '555-0105', 'ethan@email.com', '202 Birch Rd'),
('Fiona', 'Harris', '1988-12-01', 'Female', '555-0106', 'fiona@email.com', '303 Cedar Pl'),
('George', 'Clark', '1955-03-25', 'Male', '555-0107', 'george@email.com', '404 Elm Blvd'),
('Hannah', 'Lewis', '2001-09-18', 'Female', '555-0108', 'hannah@email.com', '505 Spruce Way'),
('Ian', 'Walker', '1963-06-05', 'Male', '555-0109', 'ian@email.com', '606 Willow Ct'),
('Jasmine', 'Hall', '1995-01-22', 'Female', '555-0110', 'jasmine@email.com', '707 Aspen Ave'),
('Kevin', 'Allen', '1982-08-10', 'Male', '555-0111', 'kevin@email.com', '808 Redwood St'),
('Lily', 'Young', '1999-04-30', 'Female', '555-0112', 'lily@email.com', '909 Poplar Cir'),
('Mason', 'Wright', '2018-07-07', 'Male', '555-0113', 'mason@email.com', '111 Lakeview Dr'),
('Nora', 'King', '1976-11-12', 'Female', '555-0114', 'nora@email.com', '222 River Rd'),
('Oscar', 'Scott', '1949-05-28', 'Male', '555-0115', 'oscar@email.com', '333 Hilltop Ln'),
('Penelope', 'Green', '2005-02-14', 'Female', '555-0116', 'penelope@email.com', '444 Valley Rd'),
('Quinn', 'Baker', '1993-10-20', 'Non-binary', '555-0117', 'quinn@email.com', '555 Ocean Blvd'),
('Ryan', 'Adams', '1980-04-05', 'Male', '555-0118', 'ryan@email.com', '666 Mountain Ave'),
('Sophia', 'Nelson', '1969-08-15', 'Female', '555-0119', 'sophia@email.com', '777 Sunset Dr'),
('Tom', 'Carter', '1998-03-29', 'Male', '555-0120', 'tom@email.com', '888 Sunrise Pl');



SET FOREIGN_KEY_CHECKS = 0;

-- Insert 25 Appointments (linking patients and doctors)
-- These will generate appointment_id 1 through 25
INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2025-11-10 09:00:00', 'Annual Checkup', 'Scheduled'),
(2, 2, '2025-11-10 11:30:00', 'Consultation for headaches', 'Scheduled'),
(3, 3, '2025-11-11 10:00:00', 'Vaccination', 'Scheduled'),
(4, 5, '2025-11-12 15:00:00', 'Knee pain consultation', 'Scheduled'),
(1, 1, '2025-05-15 14:00:00', 'Follow-up visit', 'Completed'),
(5, 4, '2025-11-14 09:30:00', 'Mole check', 'Scheduled'),
(6, 6, '2025-11-15 11:00:00', 'Stomach pain', 'Scheduled'),
(7, 7, '2025-11-16 13:00:00', 'Cancer screening', 'Scheduled'),
(8, 8, '2025-11-17 14:30:00', 'X-Ray results', 'Scheduled'),
(9, 9, '2025-11-18 10:30:00', 'Diabetes management', 'Scheduled'),
(10, 10, '2025-08-20 16:00:00', 'Asthma check', 'Completed'),
(11, 11, '2025-11-20 08:45:00', 'Arthritis consultation', 'Scheduled'),
(12, 12, '2025-11-21 11:15:00', 'Kidney stone issue', 'Scheduled'),
(13, 13, '2025-11-22 14:00:00', 'Vision test', 'Scheduled'),
(14, 14, '2025-11-24 15:30:00', 'Hearing test', 'Scheduled'),
(15, 15, '2025-09-05 10:00:00', 'Therapy session', 'Completed'),
(16, 16, '2025-11-26 13:45:00', 'Pre-op consultation', 'Scheduled'),
(17, 17, '2025-11-27 09:15:00', 'Annual pap smear', 'Scheduled'),
(18, 18, '2025-11-28 16:30:00', 'Dialysis follow-up', 'Scheduled'),
(19, 19, '2025-10-01 11:00:00', 'Allergy testing', 'Completed'),
(20, 20, '2025-11-10 13:00:00', 'Fever and cough', 'Scheduled'),
(1, 4, '2025-11-19 10:00:00', 'Rash check', 'Scheduled'),
(2, 1, '2025-06-12 09:30:00', 'Heart palpitation follow-up', 'Completed'),
(4, 5, '2025-10-30 14:00:00', 'Post-op check', 'Completed'),
(8, 3, '2025-11-20 15:00:00', 'Flu shot', 'Scheduled');




-- Insert 20 Billing Records (linked to appointments and patients)
-- Note: The (appointment_id, patient_id) pairs match the appointments above.





INSERT INTO billing (appointment_id, patient_id, amount, date_issued, status) VALUES
(1, 1, 150.00, '2025-11-10', 'Unpaid'),
(2, 2, 220.00, '2025-11-10', 'Unpaid'),
(3, 3, 50.00, '2025-11-11', 'Unpaid'),
(4, 4, 180.00, '2025-11-12', 'Unpaid'),
(5, 1, 75.00, '2025-05-15', 'Paid'),
(6, 5, 175.00, '2025-11-14', 'Unpaid'),
(7, 6, 300.00, '2025-11-15', 'Unpaid'),
(8, 7, 450.00, '2025-11-16', 'Unpaid'),
(9, 8, 120.00, '2025-11-17', 'Pending'),
(10, 9, 80.00, '2025-08-20', 'Paid'),
(11, 10, 160.00, '2025-11-20', 'Unpaid'),
(12, 11, 250.00, '2025-11-21', 'Unpaid'),
(13, 12, 100.00, '2025-11-22', 'Unpaid'),
(14, 13, 90.00, '2025-11-24', 'Unpaid'),
(15, 14, 200.00, '2025-09-05', 'Paid'),
(16, 15, 400.00, '2025-11-26', 'Pending'),
(17, 16, 130.00, '2025-11-27', 'Unpaid'),
(18, 17, 350.00, '2025-11-28', 'Unpaid'),
(19, 18, 210.00, '2025-10-01', 'Paid'),
(20, 19, 75.00, '2025-11-10', 'Unpaid');



-- Insert 25 Medical Device Data Records (linked to patients)
INSERT INTO medical_device_data (patient_id, device_type, value, timestamp) VALUES
(1, 'Heart Rate Monitor', '72 bpm', '2025-11-10 09:02:15'),
(1, 'Blood Pressure', '118/76 mmHg', '2025-11-10 09:03:45'),
(2, 'Heart Rate Monitor', '85 bpm', '2025-11-10 11:31:05'),
(2, 'Blood Pressure', '130/85 mmHg', '2025-11-10 11:32:20'),
(4, 'Heart Rate Monitor', '68 bpm', '2025-11-12 15:01:00'),
(9, 'Glucose Meter', '105 mg/dL', '2025-11-18 08:00:00'),
(9, 'Glucose Meter', '140 mg/dL', '2025-11-18 12:30:00'),
(10, 'Oximeter', '99% SpO2', '2025-08-20 16:05:10'),
(1, 'Heart Rate Monitor', '68 bpm', '2025-05-15 14:02:00'),
(1, 'Blood Pressure', '115/75 mmHg', '2025-05-15 14:03:00'),
(18, 'Blood Pressure', '140/90 mmHg', '2025-11-28 16:35:00'),
(7, 'Heart Rate Monitor', '75 bpm', '2025-11-16 13:02:00'),
(13, 'Oximeter', '97% SpO2', '2025-10-01 11:05:00'),
(13, 'Heart Rate Monitor', '78 bpm', '2025-10-01 11:06:00'),
(5, 'Heart Rate Monitor', '81 bpm', '2025-11-14 09:31:00'),
(6, 'Blood Pressure', '125/80 mmHg', '2025-11-15 11:01:00'),
(9, 'Glucose Meter', '98 mg/dL', '2025-11-19 08:00:00'),
(15, 'Heart Rate Monitor', '88 bpm', '2025-09-05 10:01:00'),
(18, 'Blood Pressure', '142/88 mmHg', '2025-11-29 09:00:00'),
(20, 'Oximeter', '96% SpO2', '2025-11-10 13:01:00'),
(20, 'Heart Rate Monitor', '95 bpm', '2025-11-10 13:01:30'),
(1, 'Heart Rate Monitor', '70 bpm', '2025-11-19 10:01:00'),
(2, 'Heart Rate Monitor', '74 bpm', '2025-06-12 09:31:00'),
(4, 'Oximeter', '98% SpO2', '2025-10-30 14:02:00'),
(8, 'Heart Rate Monitor', '65 bpm', '2025-11-20 15:01:00');


SET FOREIGN_KEY_CHECKS = 1;


SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;
SELECT * FROM billing;
SELECT * FROM medical_device_data;


CREATE VIEW monthly_revenue_report AS
SELECT 
    DATE_FORMAT(date_issued, '%Y-%m') AS month,
    SUM(amount) AS total_revenue,
    COUNT(*) AS bills
FROM billing
WHERE status = 'Paid'
GROUP BY YEAR(date_issued), MONTH(date_issued);


SELECT * FROM monthly_revenue_report;



-- --------------------------------------------------------
-- ADDITIONAL DATA (≈3000 VALUES TOTAL)
-- --------------------------------------------------------

-- New Doctors (starting doctor_id from 21)
INSERT INTO doctors (first_name, last_name, specialization) VALUES
('Aaron', 'Mitchell', 'Cardiology'),
('Bella', 'Turner', 'Neurology'),
('Carlos', 'Nguyen', 'Pediatrics'),
('Daisy', 'Rivera', 'Dermatology'),
('Evan', 'Woods', 'Orthopedics'),
('Faith', 'Coleman', 'Gastroenterology'),
('Gavin', 'Reed', 'Oncology'),
('Hailey', 'Morgan', 'Radiology'),
('Isaac', 'Bell', 'Endocrinology'),
('Jenna', 'Murphy', 'Pulmonology'),
('Kyle', 'Bailey', 'Rheumatology'),
('Lara', 'Cox', 'Urology'),
('Miles', 'Watson', 'Ophthalmology'),
('Nina', 'Brooks', 'ENT'),
('Oliver', 'Sanders', 'Psychiatry'),
('Paula', 'Long', 'General Surgery'),
('Quentin', 'Foster', 'Gynecology'),
('Riley', 'Howard', 'Nephrology'),
('Stella', 'Ward', 'Allergy & Immunology'),
('Travis', 'Gray', 'Infectious Disease'),
('Uma', 'Watkins', 'Cardiology'),
('Victor', 'Russell', 'Neurology'),
('Wendy', 'Griffin', 'Pediatrics'),
('Xavier', 'Diaz', 'Orthopedics'),
('Yara', 'Butler', 'Radiology'),
('Zane', 'Sullivan', 'Psychiatry'),
('Abby', 'Fleming', 'Oncology'),
('Bryan', 'Sharp', 'Urology'),
('Clara', 'Tucker', 'Endocrinology'),
('Derek', 'Hale', 'Rheumatology'),
('Ella', 'Bryant', 'Dermatology'),
('Finn', 'Murray', 'Cardiology'),
('Grace', 'Parker', 'Gastroenterology'),
('Henry', 'Hicks', 'Neurology'),
('Isabel', 'Stone', 'Gynecology'),
('Jack', 'Dean', 'Pulmonology'),
('Kara', 'Bates', 'ENT'),
('Leo', 'Knight', 'Psychiatry'),
('Maya', 'Cook', 'General Surgery'),
('Noah', 'Palmer', 'Oncology');

-- New Patients (starting patient_id from 21)
INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address) VALUES
('Uma', 'White', '1983-04-05', 'Female', '555-0121', 'uma.white@email.com', '12 Garden St'),
('Victor', 'Brown', '1975-02-11', 'Male', '555-0122', 'victor.brown@email.com', '34 Ocean Dr'),
('Wendy', 'Miller', '2000-06-09', 'Female', '555-0123', 'wendy.miller@email.com', '56 Skyview Rd'),
('Xander', 'Lopez', '1997-07-17', 'Male', '555-0124', 'xander.lopez@email.com', '78 Sunshine Blvd'),
('Yvonne', 'Perez', '1994-01-25', 'Female', '555-0125', 'yvonne.perez@email.com', '90 Moonlight Ln'),
('Zack', 'Torres', '1989-03-22', 'Male', '555-0126', 'zack.torres@email.com', '101 Cloud Ct'),
('Ava', 'Patel', '1991-08-19', 'Female', '555-0127', 'ava.patel@email.com', '202 Blossom Rd'),
('Ben', 'Sharma', '1973-05-30', 'Male', '555-0128', 'ben.sharma@email.com', '303 Daisy Ave'),
('Cara', 'Iyer', '1987-09-13', 'Female', '555-0129', 'cara.iyer@email.com', '404 Horizon Dr'),
('Dev', 'Rao', '1995-02-28', 'Male', '555-0130', 'dev.rao@email.com', '505 Coral St');

-- --------------------------------------------------------
-- CONTINUATION OF DATA (2,650 additional values)
-- --------------------------------------------------------

-- 50 More New Patients (IDs 31-80) [50 rows * 9 cols = 450 values]
INSERT INTO patients (first_name, last_name, dob, gender, phone, email, address) VALUES
('Ella', 'Singh', '1998-11-01', 'Female', '555-0131', 'ella.singh@email.com', '606 River Way'),
('Finn', 'Gupta', '1982-07-20', 'Male', '555-0132', 'finn.gupta@email.com', '707 Grove St'),
('Grace', 'Chen', '1979-12-12', 'Female', '555-0133', 'grace.chen@email.com', '808 Hilltop Rd'),
('Henry', 'Kim', '2003-01-08', 'Male', '555-0134', 'henry.kim@email.com', '909 Valley Dr'),
('Ivy', 'Das', '1990-10-14', 'Female', '555-0135', 'ivy.das@email.com', '121 Lake Rd'),
('Jack', 'Ali', '1988-06-25', 'Male', '555-0136', 'jack.ali@email.com', '232 Park Ave'),
('Kate', 'Mehta', '1992-04-18', 'Female', '555-0137', 'kate.mehta@email.com', '343 Creek Ln'),
('Leo', 'James', '1965-09-03', 'Male', '555-0138', 'leo.james@email.com', '454 Pine Cir'),
('Mia', 'Roy', '2010-08-11', 'Female', '555-0139', 'mia.roy@email.com', '565 Maple Ct'),
('Noah', 'Sen', '1996-05-07', 'Male', '555-0140', 'noah.sen@email.com', '676 Birch Pl'),
('Olivia', 'Johansson', '1981-03-30', 'Female', '555-0141', 'olivia.j@email.com', '787 Cedar Ave'),
('Paul', 'Svensson', '1976-11-23', 'Male', '555-0142', 'paul.s@email.com', '898 Oak Blvd'),
('Quinn', 'Nielsen', '1999-07-19', 'Non-binary', '555-0143', 'quinn.n@email.com', '1010 Elm Way'),
('Rachel', 'Jensen', '1984-02-04', 'Female', '555-0144', 'rachel.j@email.com', '1111 Spruce Rd'),
('Sam', 'Andersen', '2005-09-16', 'Male', '555-0145', 'sam.a@email.com', '1212 Willow Dr'),
('Tara', 'Larsen', '1993-01-28', 'Female', '555-0146', 'tara.l@email.com', '1313 Aspen St'),
('Usman', 'Hansen', '1970-04-02', 'Male', '555-0147', 'usman.h@email.com', '1414 Pinecone Ln'),
('Vera', 'Olsen', '1968-10-21', 'Female', '555-0148', 'vera.o@email.com', '1515 Redwood Ct'),
('Will', 'Christensen', '1997-08-15', 'Male', '555-0149', 'will.c@email.com', '1616 Forest Ave'),
('Xena', 'Mortensen', '1986-12-07', 'Female', '555-0150', 'xena.m@email.com', '1717 Mountain Rd'),
('Yusuf', 'Ibrahim', '2001-02-18', 'Male', '555-0151', 'yusuf.i@email.com', '1818 Oceanview Ter'),
('Zara', 'Ahmed', '1994-11-11', 'Female', '555-0152', 'zara.a@email.com', '1919 Shoreline Dr'),
('Adam', 'Novak', '1980-05-22', 'Male', '555-0153', 'adam.n@email.com', '2020 Summit Pl'),
('Bela', 'Horvath', '1977-03-14', 'Female', '555-0154', 'bela.h@email.com', '2121 Sunrise Ct'),
('Caleb', 'Dvorak', '1991-09-09', 'Male', '555-0155', 'caleb.d@email.com', '2222 Sunset Blvd'),
('Dana', 'Kovac', '1983-06-01', 'Female', '555-0156', 'dana.k@email.com', '2323 Meadow Ln'),
('Evan', 'Popescu', '2008-01-26', 'Male', '555-0157', 'evan.p@email.com', '2424 Riverbend Rd'),
('Faye', 'Ionescu', '1995-10-10', 'Female', '555-0158', 'faye.i@email.com', '2525 Hillcrest Ave'),
('Gael', 'Antonescu', '1989-07-03', 'Male', '555-0159', 'gael.a@email.com', '2626 Lakeview Dr'),
('Hana', 'Toth', '1972-04-27', 'Female', '555-0160', 'hana.t@email.com', '2727 Stone Way'),
('Ivan', 'Molnar', '1963-08-31', 'Male', '555-0161', 'ivan.m@email.com', '2828 Brickell Ave'),
('Jana', 'Rusu', '1993-02-13', 'Female', '555-0162', 'jana.r@email.com', '2929 Coral Gables'),
('Karl', 'Balog', '1987-11-05', 'Male', '555-0163', 'karl.b@email.com', '3030 Victory Rd'),
('Lina', 'Szabo', '2000-06-17', 'Female', '555-0164', 'lina.s@email.com', '3131 Patriot Dr'),
('Milo', 'Nagy', '1996-03-24', 'Male', '555-0165', 'milo.n@email.com', '3232 Liberty Ln'),
('Nora', 'Varga', '1981-01-02', 'Female', '555-0166', 'nora.v@email.com', '3333 Freedom St'),
('Omar', 'Kozak', '1974-09-29', 'Male', '555-0167', 'omar.k@email.com', '3434 Justice Ave'),
('Pia', 'Jankowski', '1990-07-12', 'Female', '555-0168', 'pia.j@email.com', '3535 Equality Rd'),
('Ravi', 'Nowak', '1985-12-19', 'Male', '555-0169', 'ravi.n@email.com', '3636 Unity Pl'),
('Sara', 'Kowalski', '1998-08-08', 'Female', '555-0170', 'sara.k@email.com', '3737 Community Ct'),
('Tom', 'Wisniewski', '1971-05-04', 'Male', '555-0171', 'tom.w@email.com', '3838 Harmony Dr'),
('Ula', 'Zielinski', '1992-10-27', 'Female', '555-0172', 'ula.z@email.com', '3939 Peace Blvd'),
('Vlad', 'Kaminski', '1984-06-11', 'Male', '555-0173', 'vlad.k@email.com', '4040 Hope St'),
('Wera', 'Szymanski', '1978-02-21', 'Female', '555-0174', 'wera.s@email.com', '4141 Trust Way'),
('Yuri', 'Wozniak', '1997-04-15', 'Male', '555-0175', 'yuri.w@email.com', '4242 Kindness Ave'),
('Zoe', 'Dabrowski', '1988-11-18', 'Female', '555-0176', 'zoe.d@email.com', '4343 Grace Ln'),
('Liam', 'Levy', '1991-01-31', 'Male', '555-0177', 'liam.l@email.com', '4444 Faith Rd'),
('Maya', 'Cohen', '1986-07-26', 'Female', '555-0178', 'maya.c@email.com', '4545 Joy St'),
('Noam', 'Mizrahi', '2002-03-09', 'Male', '555-0179', 'noam.m@email.com', '4646 Calm Ct'),
('Talia', 'Peretz', '1994-06-23', 'Female', '555-0180', 'talia.p@email.com', '4747 Zen Dr');

-- 100 More New Appointments (IDs 28-127) [100 rows * 6 cols = 600 values]
-- (Linking new and old patients/doctors)

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(21, 21, '2025-12-01 09:00:00', 'Follow-up Checkup', 'Scheduled'),
(22, 22, '2025-12-02 11:30:00', 'Neurology Review', 'Scheduled'),
(23, 23, '2025-12-03 10:00:00', 'Pediatric Checkup', 'Scheduled'),
(24, 24, '2025-12-04 14:00:00', 'Skin rash', 'Scheduled'),
(25, 25, '2025-12-05 09:30:00', 'Knee pain', 'Scheduled'),
(26, 26, '2025-12-06 11:00:00', 'Digestive issues', 'Scheduled'),
(27, 27, '2025-12-08 13:00:00', 'Follow-up consultation', 'Scheduled'),
(28, 28, '2025-12-09 14:30:00', 'Scan results', 'Scheduled'),
(29, 29, '2025-12-10 10:30:00', 'Hormone level check', 'Scheduled'),
(30, 30, '2025-12-11 16:00:00', 'Breathing test', 'Scheduled'),
(31, 31, '2025-12-12 08:45:00', 'Joint pain', 'Scheduled'),
(32, 32, '2025-12-15 11:15:00', 'Kidney check', 'Scheduled'),
(33, 33, '2025-12-16 14:00:00', 'Eye exam', 'Scheduled'),
(34, 34, '2025-12-17 15:30:00', 'Sore throat', 'Scheduled'),
(35, 35, '2025-12-18 10:00:00', 'Anxiety follow-up', 'Scheduled'),
(36, 36, '2025-12-19 13:45:00', 'Pre-surgical clearance', 'Scheduled'),
(37, 37, '2025-12-22 09:15:00', 'Annual exam', 'Scheduled'),
(38, 38, '2025-12-23 16:30:00', 'Dialysis check', 'Scheduled'),
(39, 39, '2025-12-24 11:00:00', 'Allergy test results', 'Scheduled'),
(40, 40, '2025-12-29 13:00:00', 'Fever check', 'Scheduled'),
(41, 41, '2026-01-05 09:00:00', 'Heart checkup', 'Scheduled'),
(42, 42, '2026-01-05 11:30:00', 'Headache follow-up', 'Scheduled'),
(43, 43, '2026-01-06 10:00:00', 'Vaccinations', 'Scheduled'),
(44, 44, '2026-01-06 14:00:00', 'Acne treatment', 'Scheduled'),
(45, 45, '2026-01-07 09:30:00', 'Back pain', 'Scheduled'),
(46, 46, '2026-01-07 11:00:00', 'Acid reflux', 'Scheduled'),
(47, 47, '2026-01-08 13:00:00', 'Screening', 'Scheduled'),
(48, 48, '2026-01-08 14:30:00', 'Ultrasound results', 'Scheduled'),
(49, 49, '2026-01-09 10:30:00', 'Thyroid check', 'Scheduled'),
(50, 50, '2026-01-09 16:00:00', 'Cough', 'Scheduled'),
(1, 51, '2026-01-12 08:45:00', 'Rheumatism check', 'Scheduled'),
(2, 52, '2026-01-12 11:15:00', 'Bladder issue', 'Scheduled'),
(3, 53, '2026-01-13 14:00:00', 'Contact lens fitting', 'Scheduled'),
(4, 54, '2026-01-13 15:30:00', 'Hearing aid check', 'Scheduled'),
(5, 55, '2026-01-14 10:00:00', 'Depression follow-up', 'Scheduled'),
(6, 56, '2026-01-14 13:45:00', 'Gallbladder consult', 'Scheduled'),
(7, 57, '2026-01-15 09:15:00', 'IUD check', 'Scheduled'),
(8, 58, '2026-01-15 16:30:00', 'Kidney function test', 'Scheduled'),
(9, 59, '2026-01-16 11:00:00', 'Food allergy panel', 'Scheduled'),
(10, 60, '2026-01-16 13:00:00', 'Travel medicine', 'Scheduled'),
(11, 1, '2026-01-19 09:00:00', 'Stress test consult', 'Scheduled'),
(12, 2, '2026-01-19 11:30:00', 'Nerve pain', 'Scheduled'),
(13, 3, '2026-01-20 10:00:00', 'Well-child visit', 'Scheduled'),
(14, 4, '2026-01-20 14:00:00', 'Psoriasis check', 'Scheduled'),
(15, 5, '2026-01-21 09:30:00', 'Hip pain', 'Scheduled'),
(16, 6, '2026-01-21 11:00:00', 'Colonoscopy consult', 'Scheduled'),
(17, 7, '2026-01-22 13:00:00', 'Biopsy follow-up', 'Scheduled'),
(18, 8, '2026-01-22 14:30:00', 'CT scan review', 'Scheduled'),
(19, 9, '2026-01-23 10:30:00', 'Diabetes check-in', 'Scheduled'),
(20, 10, '2026-01-23 16:00:00', 'Sleep apnea consult', 'Scheduled'),
(51, 11, '2026-01-26 08:45:00', 'Lupus management', 'Scheduled'),
(52, 12, '2026-01-26 11:15:00', 'Prostate exam', 'Scheduled'),
(53, 13, '2026-01-27 14:00:00', 'Glaucoma test', 'Scheduled'),
(54, 14, '2026-01-27 15:30:00', 'Tinnitus check', 'Scheduled'),
(55, 15, '2026-01-28 10:00:00', 'Medication management', 'Scheduled'),
(56, 16, '2026-01-28 13:45:00', 'Hernia check', 'Scheduled'),
(57, 17, '2026-01-29 09:15:00', 'Menopause symptoms', 'Scheduled'),
(58, 18, '2026-01-29 16:30:00', 'Blood pressure check', 'Scheduled'),
(59, 19, '2026-01-30 11:00:00', 'Asthma check', 'Scheduled'),
(60, 20, '2026-01-30 13:00:00', 'Flu symptoms', 'Scheduled'),
(61, 21, '2026-02-02 09:00:00', 'Echocardiogram', 'Scheduled'),
(62, 22, '2026-02-02 11:30:00', 'Memory test', 'Scheduled'),
(63, 23, '2026-02-03 10:00:00', 'Child development check', 'Scheduled'),
(64, 24, '2026-02-03 14:00:00', 'Mole removal consult', 'Scheduled'),
(65, 25, '2026-02-04 09:30:00', 'Sports injury', 'Scheduled'),
(66, 26, '2026-02-04 11:00:00', 'IBD follow-up', 'Scheduled'),
(67, 27, '2026-02-05 13:00:00', 'Chemo side effects', 'Scheduled'),
(68, 28, '2026-02-05 14:30:00', 'X-ray follow-up', 'Scheduled'),
(69, 29, '2026-02-06 10:30:00', 'Osteoporosis screening', 'Scheduled'),
(70, 30, '2026-02-06 16:00:00', 'Pulmonary function test', 'Scheduled'),
(71, 31, '2026-02-09 08:45:00', 'Gout follow-up', 'Scheduled'),
(72, 32, '2026-02-09 11:15:00', 'UTI symptoms', 'Scheduled'),
(73, 33, '2026-02-10 14:00:00', 'New glasses prescription', 'Scheduled'),
(74, 34, '2026-02-10 15:30:00', 'Vertigo check', 'Scheduled'),
(75, 35, '2026-02-11 10:00:00', 'ADHD consultation', 'Scheduled'),
(76, 36, '2026-02-11 13:45:00', 'Appendix follow-up', 'Scheduled'),
(77, 37, '2026-02-12 09:15:00', 'Birth control consult', 'Scheduled'),
(78, 38, '2026-02-12 16:30:00', 'CKD management', 'Scheduled'),
(79, 39, '2026-02-13 11:00:00', 'Eczema flare-up', 'Scheduled'),
(80, 40, '2026-02-13 13:00:00', 'Post-COVID check', 'Scheduled'),
(1, 41, '2025-11-20 09:00:00', 'Annual Checkup', 'Completed'),
(2, 42, '2025-11-20 11:30:00', 'Consultation for headaches', 'Completed'),
(3, 43, '2025-11-21 10:00:00', 'Vaccination', 'Completed'),
(4, 44, '2025-11-21 15:00:00', 'Mole check', 'Completed'),
(5, 45, '2025-11-24 14:00:00', 'Knee pain consultation', 'Completed'),
(6, 46, '2025-11-24 09:30:00', 'Stomach pain', 'Completed'),
(7, 47, '2025-11-25 11:00:00', 'Cancer screening', 'Completed'),
(8, 48, '2025-11-25 13:00:00', 'X-Ray results', 'Completed'),
(9, 49, '2025-11-26 14:30:00', 'Diabetes management', 'Completed'),
(10, 50, '2025-11-26 10:30:00', 'Asthma check', 'Completed'),
(11, 51, '2025-11-27 16:00:00', 'Arthritis consultation', 'Completed'),
(12, 52, '2025-11-27 08:45:00', 'Kidney stone issue', 'Completed'),
(13, 53, '2025-11-28 11:15:00', 'Vision test', 'Completed'),
(14, 54, '2025-11-28 14:00:00', 'Hearing test', 'Completed');

-- 100 More Billing Records (IDs 23-122) [100 rows * 6 cols = 600 values]
-- (Matching the 100 appointments above, IDs 28-127)




-- your entire INSERT block here


INSERT INTO billing (appointment_id, patient_id, amount, date_issued, status) VALUES
(28, 23, 75.00, '2025-12-03', 'Paid'),
(29, 24, 175.00, '2025-12-04', 'Unpaid'),
(30, 25, 180.00, '2025-12-05', 'Pending'),
(31, 26, 300.00, '2025-12-06', 'Unpaid'),
(32, 27, 450.00, '2025-12-08', 'Paid'),
(33, 28, 120.00, '2025-12-09', 'Unpaid'),
(34, 29, 80.00, '2025-12-10', 'Paid'),
(35, 30, 160.00, '2025-12-11', 'Unpaid'),
(36, 31, 160.00, '2025-12-12', 'Unpaid'),
(37, 32, 250.00, '2025-12-15', 'Pending'),
(38, 33, 100.00, '2025-12-16', 'Unpaid'),
(39, 34, 90.00, '2025-12-17', 'Paid'),
(40, 35, 200.00, '2025-12-18', 'Unpaid'),
(41, 36, 400.00, '2025-12-19', 'Unpaid'),
(42, 37, 130.00, '2025-12-22', 'Paid'),
(43, 38, 350.00, '2025-12-23', 'Unpaid'),
(44, 39, 210.00, '2025-12-24', 'Pending'),
(45, 40, 75.00, '2025-12-29', 'Unpaid'),
(46, 41, 150.00, '2026-01-05', 'Unpaid'),
(47, 42, 220.00, '2026-01-05', 'Paid'),
(48, 43, 50.00, '2026-01-06', 'Unpaid'),
(49, 44, 175.00, '2026-01-06', 'Unpaid'),
(50, 45, 180.00, '2026-01-07', 'Pending'),
(51, 46, 300.00, '2026-01-07', 'Unpaid'),
(52, 47, 450.00, '2026-01-08', 'Paid'),
(53, 48, 120.00, '2026-01-08', 'Unpaid'),
(54, 49, 80.00, '2026-01-09', 'Unpaid'),
(55, 50, 160.00, '2026-01-09', 'Paid'),
(56, 1, 160.00, '2026-01-12', 'Unpaid'),
(57, 2, 250.00, '2026-01-12', 'Unpaid'),
(58, 3, 100.00, '2026-01-13', 'Pending'),
(59, 4, 90.00, '2026-01-13', 'Unpaid'),
(60, 5, 200.00, '2026-01-14', 'Paid'),
(61, 6, 400.00, '2026-01-14', 'Unpaid'),
(62, 7, 130.00, '2026-01-15', 'Unpaid'),
(63, 8, 350.00, '2026-01-15', 'Paid'),
(64, 9, 210.00, '2026-01-16', 'Unpaid'),
(65, 10, 75.00, '2026-01-16', 'Pending'),
(66, 11, 150.00, '2026-01-19', 'Unpaid'),
(67, 12, 220.00, '2026-01-19', 'Paid'),
(68, 13, 50.00, '2026-01-20', 'Unpaid'),
(69, 14, 175.00, '2026-01-20', 'Unpaid'),
(70, 15, 180.00, '2026-01-21', 'Paid'),
(71, 16, 300.00, '2026-01-21', 'Unpaid'),
(72, 17, 450.00, '2026-01-22', 'Pending'),
(73, 18, 120.00, '2026-01-22', 'Unpaid'),
(74, 19, 80.00, '2026-01-23', 'Paid'),
(75, 20, 160.00, '2026-01-23', 'Unpaid'),
(76, 51, 160.00, '2026-01-26', 'Unpaid'),
(77, 52, 250.00, '2026-01-26', 'Paid'),
(78, 53, 100.00, '2026-01-27', 'Unpaid'),
(79, 54, 90.00, '2026-01-27', 'Pending'),
(80, 55, 200.00, '2026-01-28', 'Unpaid'),
(81, 56, 400.00, '2026-01-28', 'Paid'),
(82, 57, 130.00, '2026-01-29', 'Unpaid'),
(83, 58, 350.00, '2026-01-29', 'Unpaid'),
(84, 59, 210.00, '2026-01-30', 'Paid'),
(85, 60, 75.00, '2026-01-30', 'Unpaid'),
(86, 61, 150.00, '2026-02-02', 'Pending'),
(87, 62, 220.00, '2026-02-02', 'Unpaid'),
(88, 63, 50.00, '2026-02-03', 'Paid'),
(89, 64, 175.00, '2026-02-03', 'Unpaid'),
(90, 65, 180.00, '2026-02-04', 'Unpaid'),
(91, 66, 300.00, '2026-02-04', 'Paid'),
(92, 67, 450.00, '2026-02-05', 'Unpaid'),
(93, 68, 120.00, '2026-02-05', 'Pending'),
(94, 69, 80.00, '2026-02-06', 'Unpaid'),
(95, 70, 160.00, '2026-02-06', 'Paid'),
(96, 71, 160.00, '2026-02-09', 'Unpaid'),
(97, 72, 250.00, '2026-02-09', 'Unpaid'),
(98, 73, 100.00, '2026-02-10', 'Paid'),
(99, 74, 90.00, '2026-02-10', 'Unpaid'),
(100, 75, 200.00, '2026-02-11', 'Pending'),
(101, 76, 400.00, '2026-02-11', 'Unpaid'),
(102, 77, 130.00, '2026-02-12', 'Paid'),
(103, 78, 350.00, '2026-02-12', 'Unpaid'),
(104, 79, 210.00, '2026-02-13', 'Unpaid'),
(105, 80, 75.00, '2026-02-13', 'Paid'),
(106, 1, 150.00, '2025-11-20', 'Paid'),
(107, 2, 220.00, '2025-11-20', 'Paid'),
(108, 3, 50.00, '2025-11-21', 'Paid'),
(109, 4, 175.00, '2025-11-21', 'Paid'),
(110, 5, 180.00, '2025-11-24', 'Paid'),
(111, 6, 300.00, '2025-11-24', 'Paid'),
(112, 7, 450.00, '2025-11-25', 'Paid'),
(113, 8, 120.00, '2025-11-25', 'Paid'),
(114, 9, 80.00, '2025-11-26', 'Paid'),
(115, 10, 160.00, '2025-11-26', 'Paid'),
(116, 11, 160.00, '2025-11-27', 'Paid'),
(117, 12, 250.00, '2025-11-27', 'Paid'),
(118, 13, 100.00, '2025-11-28', 'Paid'),
(119, 14, 90.00, '2025-11-28', 'Paid'),
(120, 21, 200.00, '2025-12-01', 'Unpaid'),
(121, 22, 175.00, '2025-12-02', 'Paid'),
(122, 26, 200.00, '2025-12-01', 'Unpaid'),
(123, 27, 175.00, '2025-12-02', 'Paid'),
(124, 28, 75.00, '2025-12-03', 'Paid'),
(125, 29, 175.00, '2025-12-04', 'Unpaid'),
(126, 30, 180.00, '2025-12-05', 'Pending'),
(127, 31, 300.00, '2025-12-06', 'Unpaid');

-- 200 More Medical Device Data Records (IDs 28-227) [200 rows * 5 cols = 1000 values]
INSERT INTO medical_device_data (patient_id, device_type, value, timestamp) VALUES
(23, 'Heart Rate Monitor', '78 bpm', '2025-12-03 10:05:00'),
(23, 'Oximeter', '99% SpO2', '2025-12-03 10:05:30'),
(24, 'Heart Rate Monitor', '71 bpm', '2025-12-04 14:02:00'),
(25, 'Blood Pressure', '122/80 mmHg', '2025-12-05 09:32:00'),
(26, 'Heart Rate Monitor', '69 bpm', '2025-12-06 11:03:00'),
(27, 'Blood Pressure', '130/85 mmHg', '2025-12-08 13:02:00'),
(28, 'Heart Rate Monitor', '80 bpm', '2025-12-09 14:31:00'),
(29, 'Glucose Meter', '95 mg/dL', '2025-12-10 08:00:00'),
(30, 'Oximeter', '97% SpO2', '2025-12-11 16:02:00'),
(31, 'Heart Rate Monitor', '76 bpm', '2025-12-12 08:47:00'),
(32, 'Blood Pressure', '135/88 mmHg', '2025-12-15 11:17:00'),
(33, 'Heart Rate Monitor', '68 bpm', '2025-12-16 14:02:00'),
(34, 'Oximeter', '98% SpO2', '2025-12-17 15:31:00'),
(35, 'Heart Rate Monitor', '82 bpm', '2025-12-18 10:02:00'),
(36, 'Blood Pressure', '118/75 mmHg', '2025-12-19 13:47:00'),
(37, 'Heart Rate Monitor', '70 bpm', '2025-12-22 09:17:00'),
(38, 'Blood Pressure', '140/90 mmHg', '2025-12-23 16:32:00'),
(39, 'Oximeter', '99% SpO2', '2025-12-24 11:02:00'),
(40, 'Heart Rate Monitor', '90 bpm', '2025-12-29 13:02:00'),
(41, 'Heart Rate Monitor', '72 bpm', '2026-01-05 09:02:00'),
(42, 'Blood Pressure', '128/82 mmHg', '2026-01-05 11:32:00'),
(43, 'Oximeter', '100% SpO2', '2026-01-06 10:02:00'),
(44, 'Heart Rate Monitor', '73 bpm', '2026-01-06 14:02:00'),
(45, 'Blood Pressure', '120/78 mmHg', '2026-01-07 09:32:00'),
(46, 'Heart Rate Monitor', '75 bpm', '2026-01-07 11:02:00'),
(47, 'Blood Pressure', '115/70 mmHg', '2026-01-08 13:02:00'),
(48, 'Heart Rate Monitor', '67 bpm', '2026-01-08 14:32:00'),
(49, 'Glucose Meter', '110 mg/dL', '2026-01-09 08:15:00'),
(50, 'Oximeter', '96% SpO2', '2026-01-09 16:02:00'),
(1, 'Heart Rate Monitor', '77 bpm', '2026-01-12 08:47:00'),
(2, 'Blood Pressure', '131/81 mmHg', '2026-01-12 11:17:00'),
(3, 'Oximeter', '99% SpO2', '2026-01-13 14:02:00'),
(4, 'Heart Rate Monitor', '70 bpm', '2026-01-13 15:32:00'),
(5, 'Blood Pressure', '123/79 mmHg', '2026-01-14 10:02:00'),
(6, 'Heart Rate Monitor', '74 bpm', '2026-01-14 13:47:00'),
(7, 'Oximeter', '98% SpO2', '2026-01-15 09:17:00'),
(8, 'Blood Pressure', '139/89 mmHg', '2026-01-15 16:32:00'),
(9, 'Glucose Meter', '102 mg/dL', '2026-01-16 09:00:00'),
(10, 'Oximeter', '97% SpO2', '2026-01-16 13:02:00'),
(11, 'Heart Rate Monitor', '69 bpm', '2026-01-19 09:02:00'),
(12, 'Blood Pressure', '127/83 mmHg', '2026-01-19 11:32:00'),
(13, 'Oximeter', '99% SpO2', '2026-01-20 10:02:00'),
(14, 'Heart Rate Monitor', '72 bpm', '2026-01-20 14:02:00'),
(15, 'Blood Pressure', '125/80 mmHg', '2026-01-21 09:32:00'),
(16, 'Heart Rate Monitor', '76 bpm', '2026-01-21 11:02:00'),
(17, 'Blood Pressure', '119/76 mmHg', '2026-01-22 13:02:00'),
(18, 'Heart Rate Monitor', '68 bpm', '2026-01-22 14:32:00'),
(19, 'Glucose Meter', '98 mg/dL', '2026-01-23 08:30:00'),
(20, 'Oximeter', '98% SpO2', '2026-01-23 16:02:00'),
(51, 'Heart Rate Monitor', '78 bpm', '2026-01-26 08:47:00'),
(52, 'Blood Pressure', '133/85 mmHg', '2026-01-26 11:17:00'),
(53, 'Oximeter', '99% SpO2', '2026-01-27 14:02:00'),
(54, 'Heart Rate Monitor', '71 bpm', '2026-01-27 15:32:00'),
(55, 'Blood Pressure', '126/81 mmHg', '2026-01-28 10:02:00'),
(56, 'Heart Rate Monitor', '73 bpm', '2026-01-28 13:47:00'),
(57, 'Oximeter', '97% SpO2', '2026-01-29 09:17:00'),
(58, 'Blood Pressure', '141/91 mmHg', '2026-01-29 16:32:00'),
(59, 'Oximeter', '98% SpO2', '2026-01-30 11:02:00'),
(60, 'Heart Rate Monitor', '88 bpm', '2026-01-30 13:02:00'),
(61, 'Heart Rate Monitor', '74 bpm', '2026-02-02 09:02:00'),
(62, 'Blood Pressure', '129/84 mmHg', '2026-02-02 11:32:00'),
(63, 'Oximeter', '99% SpO2', '2026-02-03 10:02:00'),
(64, 'Heart Rate Monitor', '70 bpm', '2026-02-03 14:02:00'),
(65, 'Blood Pressure', '121/77 mmHg', '2026-02-04 09:32:00'),
(66, 'Heart Rate Monitor', '76 bpm', '2026-02-04 11:02:00'),
(67, 'Blood Pressure', '124/80 mmHg', '2026-02-05 13:02:00'),
(68, 'Heart Rate Monitor', '69 bpm', '2026-02-05 14:32:00'),
(69, 'Glucose Meter', '105 mg/dL', '2026-02-06 08:00:00'),
(70, 'Oximeter', '97% SpO2', '2026-02-06 16:02:00'),
(71, 'Heart Rate Monitor', '79 bpm', '2026-02-09 08:47:00'),
(72, 'Blood Pressure', '134/86 mmHg', '2026-02-09 11:17:00'),
(73, 'Oximeter', '98% SpO2', '2026-02-10 14:02:00'),
(74, 'Heart Rate Monitor', '72 bpm', '2026-02-10 15:32:00'),
(75, 'Blood Pressure', '128/83 mmHg', '2026-02-11 10:02:00'),
(76, 'Heart Rate Monitor', '75 bpm', '2026-02-11 13:47:00'),
(77, 'Oximeter', '99% SpO2', '2026-02-12 09:17:00'),
(78, 'Blood Pressure', '142/92 mmHg', '2026-02-12 16:32:00'),
(79, 'Heart Rate Monitor', '73 bpm', '2026-02-13 11:02:00'),
(80, 'Heart Rate Monitor', '85 bpm', '2026-02-13 13:02:00'),
(1, 'Heart Rate Monitor', '70 bpm', '2025-11-20 09:02:00'),
(1, 'Blood Pressure', '118/76 mmHg', '2025-11-20 09:03:00'),
(2, 'Heart Rate Monitor', '84 bpm', '2025-11-20 11:32:00'),
(2, 'Blood Pressure', '130/85 mmHg', '2025-11-20 11:33:00'),
(3, 'Oximeter', '99% SpO2', '2025-11-21 10:02:00'),
(4, 'Heart Rate Monitor', '71 bpm', '2025-11-21 15:02:00'),
(5, 'Blood Pressure', '122/78 mmHg', '2025-11-24 14:02:00'),
(6, 'Heart Rate Monitor', '76 bpm', '2025-11-24 09:32:00'),
(7, 'Blood Pressure', '116/74 mmHg', '2025-11-25 11:02:00'),
(8, 'Heart Rate Monitor', '68 bpm', '2025-11-25 13:02:00'),
(9, 'Glucose Meter', '108 mg/dL', '2025-11-26 14:32:00'),
(10, 'Oximeter', '98% SpO2', '2025-11-26 10:32:00'),
(11, 'Heart Rate Monitor', '78 bpm', '2025-11-27 16:02:00'),
(12, 'Blood Pressure', '136/88 mmHg', '2025-11-27 08:47:00'),
(13, 'Oximeter', '99% SpO2', '2025-11-28 11:17:00'),
(14, 'Heart Rate Monitor', '70 bpm', '2025-11-28 14:02:00'),
(15, 'Glucose Meter', '92 mg/dL', '2025-12-01 09:00:00'),
(16, 'Blood Pressure', '120/80 mmHg', '2025-12-01 10:00:00'),
(17, 'Heart Rate Monitor', '75 bpm', '2025-12-01 11:00:00'),
(18, 'Oximeter', '97% SpO2', '2025-12-01 14:00:00'),
(19, 'Glucose Meter', '115 mg/dL', '2025-12-01 16:00:00'),
(20, 'Blood Pressure', '125/75 mmHg', '2025-12-02 09:00:00'),
(21, 'Heart Rate Monitor', '71 bpm', '2025-12-02 10:00:00'),
(22, 'Oximeter', '98% SpO2', '2025-12-02 11:00:00'),
(23, 'Glucose Meter', '99 mg/dL', '2025-12-02 14:00:00'),
(24, 'Blood Pressure', '130/82 mmHg', '2025-12-02 16:00:00'),
(25, 'Heart Rate Monitor', '80 bpm', '2025-12-03 09:00:00'),
(26, 'Oximeter', '96% SpO2', '2025-12-03 10:00:00'),
(27, 'Glucose Meter', '103 mg/dL', '2025-12-03 11:00:00'),
(28, 'Blood Pressure', '128/79 mmHg', '2025-12-03 14:00:00'),
(29, 'Heart Rate Monitor', '73 bpm', '2025-12-03 16:00:00'),
(30, 'Oximeter', '98% SpO2', '2025-12-04 09:00:00'),
(31, 'Glucose Meter', '100 mg/dL', '2025-12-04 10:00:00'),
(32, 'Blood Pressure', '132/84 mmHg', '2025-12-04 11:00:00'),
(33, 'Heart Rate Monitor', '69 bpm', '2025-12-04 14:00:00'),
(34, 'Oximeter', '99% SpO2', '2025-12-04 16:00:00'),
(35, 'Glucose Meter', '97 mg/dL', '2025-12-05 09:00:00'),
(36, 'Blood Pressure', '119/77 mmHg', '2025-12-05 10:00:00'),
(37, 'Heart Rate Monitor', '72 bpm', '2025-12-05 11:00:00'),
(38, 'Oximeter', '98% SpO2', '2025-12-05 14:00:00'),
(39, 'Glucose Meter', '108 mg/dL', '2025-12-05 16:00:00'),
(40, 'Blood Pressure', '121/78 mmHg', '2025-12-08 09:00:00'),
(41, 'Heart Rate Monitor', '77 bpm', '2025-12-08 10:00:00'),
(42, 'Oximeter', '97% SpO2', '2025-12-08 11:00:00'),
(43, 'Glucose Meter', '101 mg/dL', '2025-12-08 14:00:00'),
(44, 'Blood Pressure', '126/81 mmHg', '2025-12-08 16:00:00'),
(45, 'Heart Rate Monitor', '74 bpm', '2025-12-09 09:00:00'),
(46, 'Oximeter', '98% SpO2', '2025-12-09 10:00:00'),
(47, 'Glucose Meter', '95 mg/dL', '2025-12-09 11:00:00'),
(48, 'Blood Pressure', '133/83 mmHg', '2025-12-09 14:00:00'),
(49, 'Heart Rate Monitor', '70 bpm', '2025-12-09 16:00:00'),
(50, 'Oximeter', '99% SpO2', '2025-12-10 09:00:00'),
(51, 'Glucose Meter', '102 mg/dL', '2025-12-10 10:00:00'),
(52, 'Blood Pressure', '124/79 mmHg', '2025-12-10 11:00:00'),
(53, 'Heart Rate Monitor', '78 bpm', '2025-12-10 14:00:00'),
(54, 'Oximeter', '97% SpO2', '2025-12-10 16:00:00'),
(55, 'Glucose Meter', '98 mg/dL', '2025-12-11 09:00:00'),
(56, 'Blood Pressure', '127/80 mmHg', '2025-12-11 10:00:00'),
(57, 'Heart Rate Monitor', '72 bpm', '2025-12-11 11:00:00'),
(58, 'Oximeter', '98% SpO2', '2025-12-11 14:00:00'),
(59, 'Glucose Meter', '110 mg/dL', '2025-12-11 16:00:00'),
(60, 'Blood Pressure', '129/81 mmHg', '2025-12-12 09:00:00'),
(61, 'Heart Rate Monitor', '76 bpm', '2025-12-12 10:00:00'),
(62, 'Oximeter', '99% SpO2', '2025-12-12 11:00:00'),
(63, 'Glucose Meter', '94 mg/dL', '2025-12-12 14:00:00'),
(64, 'Blood Pressure', '122/76 mmHg', '2025-12-12 16:00:00'),
(65, 'Heart Rate Monitor', '71 bpm', '2025-12-15 09:00:00'),
(66, 'Oximeter', '98% SpO2', '2025-12-15 10:00:00'),
(67, 'Glucose Meter', '104 mg/dL', '2025-12-15 11:00:00'),
(68, 'Blood Pressure', '131/82 mmHg', '2025-12-15 14:00:00'),
(69, 'Heart Rate Monitor', '73 bpm', '2025-12-15 16:00:00'),
(70, 'Oximeter', '97% SpO2', '2025-12-16 09:00:00'),
(71, 'Glucose Meter', '99 mg/dL', '2025-12-16 10:00:00'),
(72, 'Blood Pressure', '128/78 mmHg', '2025-12-16 11:00:00'),
(73, 'Heart Rate Monitor', '75 bpm', '2025-12-16 14:00:00'),
(74, 'Oximeter', '98% SpO2', '2025-12-16 16:00:00'),
(75, 'Glucose Meter', '101 mg/dL', '2025-12-17 09:00:00'),
(76, 'Blood Pressure', '123/79 mmHg', '2025-12-17 10:00:00'),
(77, 'Heart Rate Monitor', '70 bpm', '2025-12-17 11:00:00'),
(78, 'Oximeter', '99% SpO2', '2025-12-17 14:00:00'),
(79, 'Glucose Meter', '96 mg/dL', '2025-12-17 16:00:00'),
(80, 'Blood Pressure', '127/80 mmHg', '2025-12-18 09:00:00');


SET FOREIGN_KEY_CHECKS = 1;
set SQL_SAFE_UPDATES = 1;




USE hospital_db;

SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;
SELECT * FROM billing;
SELECT * FROM medical_device_data;






