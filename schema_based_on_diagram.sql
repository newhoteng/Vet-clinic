-- Create patients table
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL
);

-- Create medical_histories table
CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT REFERENCES patients(id) ON UPDATE CASCADE ON DELETE CASCADE,
  status VARCHAR(50) NOT NULL
);

-- Create invoices table
CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL(10, 2) NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT REFERENCES medical_histories(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE invoices(
  id SERIAL PRIMARY KEY NOT NULL,
  total_amount decimal,
  generated_at timestamp,
  payed_at timestamp,
  medical_history_id int,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY NOT NULL,
  type varchar(255),
  name  varchar(255)
);

CREATE TABLE medical_histories_treatment (
  id SERIAL PRIMARY KEY NOT NULL, 
  medical_histories_id int REFERENCES medical_histories(id),
  treatment_id int REFERENCES treatment(id)
);
