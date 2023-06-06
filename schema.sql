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
