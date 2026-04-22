create database if not exists HospitalManagement;
use HospitalManagement;

create table Patients (
    patient_id int primary key auto_increment,
    patient_name varchar(100) not null,
    age int,
    gender varchar(20)
);


create table Doctors (
    doctor_id int primary key auto_increment,
    doctor_name varchar(100) not null,
    specialization varchar(100)
);


create table Appointments (
    appointment_id int primary key auto_increment,
    patient_id int,
    doctor_id int,
    appointment_date date,

    foreign key (patient_id) references Patients(patient_id),
    foreign key (doctor_id) references Doctors(doctor_id)
);


create table Treatments (
    treatment_id int primary key auto_increment,
    patient_id int,
    diagnosis varchar(150),
    cost decimal(10,2),
    treatment_date date,

    foreign key (patient_id) references Patients(patient_id)
);


INSERT INTO Patients (patient_name, age, gender)
VALUES
('SriRam', 22, 'Male'),
('Sneha', 21, 'Female'),
('Arjun', 24, 'Male'),
('Priya', 23, 'Female'),
('Kiran', 25, 'Male'),
('Anjali', 20, 'Female');


INSERT INTO Doctors (doctor_name, specialization)
VALUES
('Dr. Sharma', 'Cardiologist'),
('Dr. Priya', 'Dermatologist'),
('Dr. Poojitha', 'Neurologist'),
('Dr. Kumar', 'Orthopedic'),
('Dr. Meena', 'General Physician'),
('Dr. Ravi', 'ENT Specialist');


INSERT INTO Appointments (patient_id, doctor_id, appointment_date)
VALUES
(1, 1, '2026-04-01'),
(2, 2, '2026-04-02'),
(3, 3, '2026-04-03'),
(4, 1, '2026-04-05'),
(5, 4, '2026-04-06'),
(6, 5, '2026-04-07'),
(1, 2, '2026-04-10'),
(2, 1, '2026-04-12'),
(3, 5, '2026-04-15'),
(4, 3, '2026-04-18');


INSERT INTO Treatments (patient_id, diagnosis, cost, treatment_date)
VALUES
(1, 'Fever', 1500.00, '2026-04-01'),
(2, 'Skin Allergy', 2200.00, '2026-04-02'),
(3, 'Migraine', 3000.00, '2026-04-03'),
(4, 'Heart Checkup', 5000.00, '2026-04-05'),
(5, 'Fracture', 7000.00, '2026-04-06'),
(6, 'Cold and Cough', 1200.00, '2026-04-07'),
(1, 'Diabetes', 3500.00, '2026-04-10'),
(2, 'Fever', 1800.00, '2026-04-12'),
(3, 'Fever', 1600.00, '2026-04-15'),
(4, 'Skin Allergy', 2500.00, '2026-04-18');


-- Find most consulted doctors 
select
    Doctors.doctor_name,
    Doctors.specialization,
    count(*) as TotalConsultations
from 
Appointments join Doctors
on Appointments.doctor_id = Doctors.doctor_id
group by Doctors.doctor_name, Doctors.specialization
order by TotalConsultations desc;


-- Calculate total revenue per month
select 
    month(treatment_date) as Month,
    sum(cost) as TotalRevenue
from Treatments
group by month(treatment_date)
order by Month;


-- Identify most common diagnoses
select 
    diagnosis,
    count(*) as TotalPatients
from Treatments
group by diagnosis
order by TotalPatients desc;


-- Track patient visit frequency
select
    Patients.patient_name,
    count(*) as TotalVisits
from 
Appointments join Patients
on Appointments.patient_id = Patients.patient_id
group by Patients.patient_name
order by TotalVisits desc;


-- Analyze doctor performance 
select
    Doctors.doctor_name,
    Doctors.specialization,
    count(Appointments.patient_id) as TotalPatientsHandled
from 
Appointments join Doctors
on Appointments.doctor_id = Doctors.doctor_id
group by Doctors.doctor_name, Doctors.specialization
order by TotalPatientsHandled desc;