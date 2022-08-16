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

--create table called invoice.
CREATE TABLE invoice (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL NOT NULL,
    generatet_at timestamp NOT NULL,
    payed_at timestamp,
    medical_history_id INT NOT NULL,
    foreign key (medical_history_id) references medical_histories(id)
);

-- create table named invoice_items.
CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    foreign key (invoice_id) references invoice(id)
);

-- creta table named treatments.
CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR NOT NULL,
    name VARCHAR NOT NULL
);

-- alter table invoice_items add foreign key treatment_id to treatment.id.
ALTER TABLE
    invoice_items
ADD
    CONSTRAINT FK_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id);