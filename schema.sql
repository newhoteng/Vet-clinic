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
ALTER TABLE animals ADD owners_id INT,
ADD CONSTRAINT owners_fk FOREIGN KEY (owners_id) REFERENCES owners(id)
ON DELETE CASCADE;
