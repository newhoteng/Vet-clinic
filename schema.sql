-- Create animals table
CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BIT NOT NULL,
  weight_kg DECIMAL(5, 2) NOT NULL,
  PRIMARY KEY (id)
);

-- Add species column to already created animals table
ALTER TABLE animals ADD species VARCHAR(50);

-- Create owners table
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(50) NOT NULL,
  age INT NOT NULL
);

-- Create species table
CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- Remove column species for animals table
BEGIN;
ALTER TABLE animals DROP COLUMN species;
SELECT * FROM animals;
COMMIT;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id INT,
ADD CONSTRAINT species_fk FOREIGN KEY (species_id) REFERENCES species(id)
ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT,
ADD CONSTRAINT owner_fk FOREIGN KEY (owner_id) REFERENCES owners(id)
ON DELETE CASCADE;

-- Create vets table
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE NOT NULL
);

CREATE TABLE specialization (
  species_id INT REFERENCES species(id) ON UPDATE CASCADE ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY (species_id, vet_id)
);

INSERT INTO specialization (species_id, vet_id)
VALUES 
  ('Agumon', '2020-02-03', 0, '1', 10.23),
  ('Gabumon', '2018-11-15', 2, '1', 8),
  ('Pikachu', '2021-01-07', 1, '0', 15.04),
  ('Devimon', '2017-05-12', 5, '1', 11)
;

CREATE TABLE visits (
  animal_id INT REFERENCES animals(id) ON UPDATE CASCADE ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON UPDATE CASCADE ON DELETE CASCADE,
  date_of_visit DATE NOT NULL,
  PRIMARY KEY (animal_id, vet_id)
);
