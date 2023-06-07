/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  ('Agumon', '2020-02-03', 0, '1', 10.23),
  ('Gabumon', '2018-11-15', 2, '1', 8),
  ('Pikachu', '2021-01-07', 1, '0', 15.04),
  ('Devimon', '2017-05-12', 5, '1', 11)
;

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  ('Charmander', '2020-02-08', 0, '0', -11),
  ('Plantmon', '2021-11-15', 2, '1', -5.7),
  ('Squirtle', '1993-04-02', 3, '0', -12.13),
  ('Angemon', '2005-06-12', 1, '1', -45),
  ('Boarmon', '2005-06-07', 7, '1', 20.4),
  ('Blossom', '1998-10-13', 3, '1', 17),
  ('Ditto', '2022-05-14', 4, '1', 22)
;

-- Insert into the owners table
INSERT INTO owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38)
;

-- Insert into the species table
INSERT INTO species (name)
VALUES
  ('Pokemon'),
  ('Digimon')
;

-- Modify your inserted animals so it includes the species_id value
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id)
-- Sam Smith owns Agumon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');
