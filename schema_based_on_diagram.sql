/* Database schema to keep the structure of entire database. */
/* Database schema to keep the structure of entire database. */
-- creata table called patient with fild id, name and date_of_birth.
CREATE TABLE patient (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE
);