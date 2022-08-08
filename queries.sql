/*Queries that provide answers to the questions from all projects.*/
-- Find all animals whose name ends in "mon".
select *
from animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
select * from animals
WHERE date_of_birth 
BETWEEN '01/01/2016' AND '31/12/2019';
