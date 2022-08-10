/*Queries that provide answers to the questions from all projects.*/
-- Find all animals whose name ends in "mon".
SELECT
    *
FROM
    animals
WHERE
    name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT
    *
FROM
    animals
WHERE
    date_of_birth BETWEEN '01/01/2016'
    AND '31/12/2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT
    name
FROM
    animals
WHERE
    neutered = TRUE
    AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT
    date_of_birth
FROM
    animals
WHERE
    name = 'Agumon'
    OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT
    name,
    escape_attempts
FROM
    animals
WHERE
    weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT
    *
FROM
    animals
WHERE
    neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT
    *
FROM
    animals
WHERE
    name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT
    *
FROM
    animals
WHERE
    weight_kg BETWEEN 10.4
    AND 17.3;

-- Inside a transaction Update the animals table by setting the species column to 'unspecified'
BEGIN;

SAVEPOINT sp1;

UPDATE
    animals
SET
    species = 'unspecified';

-- Verify that change was made
select
    *
from
    animals -- Roll back the change
    ROLLBACK TO sp1;

-- verify that the species columns went back to the state before the transaction
select
    *
from
    animals -- Commit the change 
    COMMIT;

/*This command end the transaction */
-- NEW TRANSACTION
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
SAVEPOINT sp1;

UPDATE
    animals
SET
    species = 'digimon'
WHERE
    name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
SAVEPOINT sp2;

UPDATE
    animals
SET
    species = 'pokemon '
WHERE
    species IS NULL;

-- Commit the transaction.
COMMIT;

/*END OF TRANSACTION*/
-- Verify that change was made and persists after commit.
SELECT
    *
FROM
    animals;

-- NEW TRANSACTION
BEGIN;

SAVEPOINT sp1;

--  delete all records in the animals table
DELETE FROM
    animals;

-- Roll back the transaction
ROLLBACK TO sp1;

-- Verify that the table is not empty
COMMIT;

/*END TRANSACTION*/
SELECT
    *
FROM
    animals;

-- NEW TRANSACTION
BEGIN;

SAVEPOINT sp1;

DELETE FROM
    animals
WHERE
    date_of_birth > '01/01/2022';

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE
    animals
SET
    weight_kg = (weight_kg * (-1));

-- Rollback to the savepoint
ROLLBACK TO sp1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE
    animals
SET
    weight_kg = (weight_kg * (-1))
WHERE
    weight_kg < 0;

-- Commit the transaction.
COMMIT;

/*QUESTIIONS QUERIES*/
-- How many animals are there? => 11
SELECT
    COUNT(*)
FROM
    animals;

-- How many animals have never tried to escape? => 2
SELECT
    COUNT(*)
FROM
    animals
where
    escape_attempts = 0;

-- What is the average weight of animals? => 16.1363636363636364
SELECT
    AVG(weight_kg)
FROM
    animals;

-- Who escapes the most, neutered or not neutered animals? => neutered
SELECT
    neutered,
    AVG(escape_attempts) as AVG_escape
FROM
    animals
GROUP BY
    neutered;

-- What is the minimum and maximum weight of each type of animal? => pokemon [MAX : 22kg, MIN : 11kg], digimon [MAX : 45kg, MIN : 5.7kg]
SELECT
    MAX(weight_kg),
    MIN(weight_kg),
    species
FROM
    animals
GROUP BY
    species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000? => pokemon [AVG : 3], digimon : NULL
SELECT
    species,
    AVG(escape_attempts)
FROM
    animals
WHERE
    date_of_birth BETWEEN '01/01/1990'
    AND '31/12/2000'
GROUP BY
    species;

-- Answer some questions using JOIN.
-- 1. What animals belong to Melody Pond? 
SELECT
    name
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Melody Pond';

-- => Squirtle, Charmander, Blossom.
-- 2. List of all animals that are pokemon.
SELECT
    animals.name
FROM
    animals
    JOIN species ON animals.species_id = species.id
WHERE
    species.name = 'Pokemon';

-- => Ditto, Pikachu, Blossom, Charmander, Squirtle
-- 3. List all owners and their animals.
SELECT
    owners.full_name,
    animals.name
FROM
    owners
    LEFT JOIN animals ON owners.id = animals.owner_id;

-- 4. How many animals are there per species?
SELECT
    species.name AS Specie_name,
    COUNT(animals.name) as Number_of_animals
FROM
    species
    JOIN animals ON species.id = animals.species_id
GROUP BY
    Specie_name;

--=>specie_name | number_of_animals
-- -------------+-------------------
--  Pokemon     |                 5
--  Digimon     |                 6
-- (2 lignes)
-- 5. List all Digimon owned by jennifer Orwell.
SELECT
    animals.name
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Jennifer Orwell';

-- =>  Pikachu, Gabumon
-- 6. List all animals owned by Dean Wincheste that haven't tried to escape.
SELECT
    animals.name
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Dean Wincheste'
    AND animals.escape_attempts = 0;

-- => 0;
-- 7. Who owns the most animals?   
SELECT
    owners.full_name as owner_full_name,
    COUNT(animals.name) AS Number_of_animals
FROM
    owners
    LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY
    owner_full_name
ORDER BY
    Number_of_animals DESC;

--================================================================================================
-- Answer some questions.
-- 1. Who was the last animal seen by William Tatcher?
-- => Blossom
SELECT
    animals.name
FROM
    animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'William Tatcher'
    AND visits.date_of_visit = (
        SELECT
            MAX(visits.date_of_visit)
        FROM
            visits
            JOIN vets ON vets.id = visits.vet_id
        WHERE
            vets.name = 'William Tatcher'
    );

-- 2. How many different animals did Stephanie Mendez see?
-- => 4;
SELECT
    DISTINCT COUNT(animals.name)
FROM
    animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Stephanie Mendez';

-- 3. List all vets and their specialties, including vets with no specialties.
--        name       |  name
-- ------------------+---------
--  William Tatcher  | Pokemon
--  Maisy Smith      |
--  Stephanie Mendez | Pokemon
--  Jack Harkness    | Digimon
SELECT
    vets.name,
    species.name
FROM
    vets
    LEFT JOIN specialization ON vets.id = specialization.vet_id
    LEFT JOIN species ON species.id = specialization.species_id
ORDER BY
    vets.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
-- => Agumon and Blossom
SELECT
    animals.name
FROM
    animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Stephanie Mendez'
    AND visits.date_of_visit BETWEEN '01/04/2020'
    AND '30/08/2020';

-- 5. What animal has the most visits to vets?
-- => Boarmon
SELECT
    animals.name,
    COUNT(animals.name) AS total_visits
FROM
    animals
    LEFT JOIN visits ON animals.id = visits.animal_id
GROUP BY
    animals.name
ORDER BY
    total_visits DESC;

-- 6. Who was Maisy Smith's first visit?
-- => Boarmon
SELECT
    animals.name
FROM
    animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON vets.id = visits.vet_id
WHERE
    vets.name = 'Maisy Smith'
    AND visits.date_of_visit = (
        SELECT
            MIN(visits.date_of_visit)
        FROM
            visits
            JOIN vets ON vets.id = visits.vet_id
        WHERE
            vets.name = 'Maisy Smith'
    );

-- 7. Details for most recent visit: animal information, vet information, and date of visit.
-- =>
--  Anmal's_name | date_of_birth_of_animal |     vet_name     | species | date_of_visit
-- --------------+-------------------------+------------------+---------+---------------
--  Devimon      | 2017-05-12              | Stephanie Mendez | Digimon | 2021-05-04
SELECT
    animals.name as "Anmal's_name",
    animals.date_of_birth as date_of_birth_of_animal,
    vets.name as Vet_name,
    species.name as Species,
    visits.date_of_visit as Date_of_visit
FROM
    animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON vets.id = visits.vet_id
    JOIN species on species.id = animals.species_id
WHERE
    Date_of_visit = (
        SELECT
            MAX(Date_of_visit)
        FROM
            visits
            JOIN vets ON vets.id = visits.vet_id
    );

-- 8. How many visits were with a vet that did not specialize in that animal's species?
-- => 9;
SELECT
    count(vets.name)
FROM
    vets FULL
    JOIN specialization ON specialization.vet_id = vets.id FULL
    JOIN visits ON visits.vet_id = vets.id
where
    specialization.vet_id is null;

-- 9. What specialty should Maisy Smith consider getting? Look for the species she gets the most.
-- => Digimon
SELECT
    species.name AS "Species name",
    COUNT(*)
FROM
    animals
    JOIN visits on visits.animal_id = animals.id
    JOIN vets on vets.id = visits.vet_id
    JOIN species on species.id = animals.species_id
WHERE
    vets.name = 'Maisy Smith'
GROUP by
    species.name
ORDER BY
    count DESC
lIMIT
    1;