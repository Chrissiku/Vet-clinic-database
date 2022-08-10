/* Populate database with sample data. */
-- Instert data into animals table.
INSERT INTO
    animals(
        id,
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    (1, 'Agumon', '03/02/2020', 0, TRUE, 10.23),
    (2, 'Gabumon', '15/11/2018', 2, TRUE, 8.0),
    (3, 'Pikachu', '07/01/2021', 1, FALSE, 15.04),
    (4, 'Devimon', '12/05/2017', 5, TRUE, 11.0);

-- Instert new data into animals table.
INSERT INTO
    animals(
        id,
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    (5, 'Charmander', '08/02/2020', 0, FALSE, -11.0),
    (6, 'Plantmon', '15/11/2021', 2, TRUE, -5.7),
    (7, 'Squirtle', '02/04/1993', 3, FALSE, -12.13),
    (8, 'Angemon', '12/06/2005', 1, TRUE, -45.0),
    (9, 'Boarmon', '07/06/2005', 7, TRUE, 20.4),
    (10, 'Blossom', '13/10/1998', 3, TRUE, 17.0),
    (11, 'Ditto', '14/05/2022', 4, TRUE, 22.0);

-- Instert new data into owners table.
INSERT INTO
    owners(full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Wincheste', 14),
    ('Jodie Whittaker', 38);

-- Insert new data into species table.
INSERT INTO
    species(name)
VALUES
    ('Pokemon'),
    ('Digimon');

-- Edit species column for the animals table.
UPDATE
    animals
SET
    species_id = 1
WHERE
    species_id IS NULL;

-- Edit owner_id column for the animals table.
UPDATE
    animals
SET
    owner_id = 1
WHERE
    name = 'Agumon';

UPDATE
    animals
SET
    owner_id = 2
WHERE
    name IN ('Gabumon', 'Pikachu');

UPDATE
    animals
SET
    owner_id = 3
WHERE
    name IN ('Devimon', 'Plantmon');

UPDATE
    animals
SET
    owner_id = 4
WHERE
    name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE
    animals
SET
    owner_id = 5
WHERE
    name IN ('Angemon', 'Boarmon');

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