-- Create Database
 CREATE DATABASE clinic_booking_systemdb;

-- Use the Database;
USE clinic_booking_systemdb;

-- Creating 8 Tables

-- Create Clinic Table
    CREATE TABLE clinic (
    clinic_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20) UNIQUE
-- );

-- Create  Patient Table
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20) UNIQUE,
    date_of_birth DATE
);

-- Create Doctor Table
CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20) UNIQUE,
    clinic_id INT,
    FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id)
);

-- Create Specialization Table
CREATE TABLE specialization (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create DoctorSpecialization (Many-to-Many between Doctor and Specialization) Table
CREATE TABLE doctor_specialization (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES specialization(specialization_id)
);

-- Create Appointment Table
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    clinic_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (clinic_id) REFERENCES clinic(clinic_id)
);

-- Create Payment Table
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    method ENUM('Cash', 'Credit Card', 'Insurance') NOT NULL,
    status ENUM('Paid', 'Pending', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
);

-- Create Prescription Table
CREATE TABLE prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
);
