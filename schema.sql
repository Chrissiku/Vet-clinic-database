/* Database schema to keep the structure of entire database. */
/* Database schema to keep the structure of entire database. */
-- Create a table to store animals.
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

--  Create a table to store owners.
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    full_name VARCHAR NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (id)
);

-- Create a table to store species.
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id)
);