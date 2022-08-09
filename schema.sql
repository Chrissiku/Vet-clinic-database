/* Database schema to keep the structure of entire database. */
/* Database schema to keep the structure of entire database. */
-- Create a table to store the data.
CREATE TABLE animals(
    id INT,
    name VARCHAR,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);


-- Add a column species of type string to animals table
ALTER TABLE
    animals
ADD
    COLUMN species varchar;
