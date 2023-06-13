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

DELETE FROM animals;

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


-- How many animals are there?
SELECT COUNT(*) AS number_of_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS never_tried_to_escaped FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS heighest_escape_attempt FROM animals
GROUP BY neutered ORDER BY heighest_escape_attempt DESC;
-- neutered animals escape most

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as average_escape_attempt
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- VET CLINIC DATABASE: QUERY MULTIPLE TABLES
-- What animals belong to Melody Pond?
SELECT name AS animal, full_name AS owner FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name AS animal, species.name AS species FROM animals
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name AS owner, name AS animal FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name AS name_of_species, COUNT(*) AS number_of_animals
FROM species JOIN animals ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT animals.name AS animal FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS animal FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name AS name, COUNT(*) AS number_of_animals FROM owners
JOIN animals ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY number_of_animals DESC
LIMIT 1;


-- VET CLINIC DATABASE: QUERY AND UPDATE ANIMALS TABLE
-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS animal FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT(animal_id)) AS number_of_animals FROM visits
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet, species.name AS specialty FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit
BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name AS animal, COUNT(*) AS number_of_visits FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY number_of_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name AS animal, date_of_visit FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  animals.name AS animal,
  date_of_birth AS animal_DOB,
  escape_attempts,
  neutered,
  weight_kg AS animal_weight,
  vets.name AS vet,
  age AS vet_age,
  date_of_graduation AS vet_date_of_graduation,
  date_of_visit
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS number_of_visits FROM visits
JOIN animals ON animals.id = visits.animal_id
LEFT JOIN specializations ON animals.species_id = specializations.species_id
AND specializations.vet_id = visits.vet_id
WHERE specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS name_of_species, COUNT(*) AS number FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON animals.species_id = species.id
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species.name
ORDER BY number DESC
LIMIT 1;

-- PERFORMANCE AUDIT
-- Modify "SELECT COUNT(*) FROM visits where animal_id = 4;" query to below
-- Get the number of visits by animal_id = 4 from new column on animals table
explain analyze SELECT total_vet_visits FROM animals
WHERE id = 4;

-- Modify "SELECT * FROM visits where vet_id = 2;" query to below
-- Do query on newly created table
explain analyze SELECT * FROM vet_id2_visit_records;

-- Analyze after indexing email column on owners table
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';

