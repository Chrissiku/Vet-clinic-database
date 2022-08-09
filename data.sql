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
    (2, 'Gabumon', '15/11/2018', 2, TRUE, 8),
    (3, 'Pikachu', '07/01/2021', 1, FALSE, 15.04),
    (4, 'Devimon', '12/05/2017', 5, TRUE, 11);

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
    (5, 'Charmander', '08/02/2020', 0, FALSE, -11),
    (6, 'Plantmon', '15/11/2021', 2, TRUE, -5.7),
    (7, 'Squirtle', '02/04/1993', 3, FALSE, -12.13),
    (8, 'Angemon', '12/06/205', 1, TRUE, -45),
    (9, 'Boarmon', '07/06/2005', 7, TRUE, 20.4),
    (10, 'Blossom', '13/10/1998', 3, TRUE, 17),
    (11, 'Ditto', '14/05/2022', 4, TRUE, 22);