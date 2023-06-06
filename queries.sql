-- VET CLINIC DATABASE: CREATE ANIMALS TABLE

-- Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = '1' AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = '1';

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- VET CLINIC DATABASE: QUERY AND UPDATE ANIMALS TABLE

-- Set species column to unspecified then rollback changes, verify changes
BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;


-- Add species type to the species column
BEGIN;

UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

SELECT * FROM animals;


-- Delete all records in the animals table, then roll back the transaction
BEGIN;

TRUNCATE TABLE animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;


-- Using savepoint command
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;

SAVEPOINT sp1;

UPDATE animals SET weight_kg = weight_kg * -1;

SELECT * FROM animals;

ROLLBACK TO sp1;

SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT; 
