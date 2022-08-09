/*Queries that provide answers to the questions from all projects.*/
-- Find all animals whose name ends in "mon".
SELECT *
FROM animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * 
FROM animals
WHERE date_of_birth 
BETWEEN '01/01/2016' AND '31/12/2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name 
FROM animals
WHERE neutered=TRUE 
AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth 
FROM animals
WHERE name='Agumon' 
OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts 
FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered=TRUE;

-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name!='Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg 
BETWEEN 10.4 AND 17.3;


-- Inside a transaction Update the animals table by setting the species column to 'unspecified'
BEGIN;
SAVEPOINT sp1;
UPDATE animals 
SET species = 'unspecified';

-- Verify that change was made
select * from animals

-- Roll back the change
ROLLBACK TO sp1;
-- verify that the species columns went back to the state before the transaction
select * from animals
-- Commit the change 
COMMIT; /*This command end the transaction */

-- NEW TRANSACTION
BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
SAVEPOINT sp1;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
SAVEPOINT sp2;
UPDATE animals 
SET species = 'pokemon '
WHERE species IS NULL;

-- Commit the transaction.
COMMIT; /*END OF TRANSACTION*/
-- Verify that change was made and persists after commit.
SELECT * FROM animals;



-- NEW TRANSACTION
BEGIN;
SAVEPOINT sp1;
--  delete all records in the animals table
DELETE FROM animals;
-- Roll back the transaction
ROLLBACK TO sp1;
-- Verify that the table is not empty
COMMIT; /*END TRANSACTION*/
SELECT * FROM animals;
