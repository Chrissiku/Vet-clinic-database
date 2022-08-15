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

-- Edit the animals table to drop the species column.
ALTER TABLE
    animals DROP COLUMN species;

-- Add primary key to id column of animals table.
ALTER TABLE
    animals
ADD
    PRIMARY KEY (id);

-- set id column of animals table as autoincrement primary key.
ALTER TABLE
    animals
ALTER COLUMN
    id
SET
    DEFAULT nextval('animals_pkey');

-- Add columns species_id as foreign key to animals table.
ALTER TABLE
    animals
ADD
    COLUMN species_id INT REFERENCES species(id);

-- Add columns owner_id as foreign key to animals table.
ALTER TABLE
    animals
ADD
    COLUMN owner_id INT REFERENCES owners(id);

-- Create the vets to store vets.
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR NOT NULL,
    age INT NOT NULL,
    date_fo_graduation DATE,
    PRIMARY KEY (id)
);

-- Create a join table to store species and vets.
CREATE TABLE specialization(
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

-- Create a join table to store animals and vets.
CREATE TABLE visits(
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
);

-- Add new column to owners table.
ALTER TABLE owners ADD COLUMN email VARCHAR(120);