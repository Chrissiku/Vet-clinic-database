/* Database schema to keep the structure of entire database. */
/* Database schema to keep the structure of entire database. */
-- creata table called patient with fild id, name and date_of_birth.
CREATE TABLE patient (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE
);

-- creata table called medical histories.
CREATE TABLE medical_histories (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admited_at timestamp NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR NOT NULL
);

-- alter table medical_histories add foreign key patient_id to patient.id.
ALTER TABLE
    medical_histories
ADD
    CONSTRAINT FK_patient_id FOREIGN KEY (patient_id) REFERENCES patient(id);