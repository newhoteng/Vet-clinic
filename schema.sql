/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BIT NOT NULL,
  weight_kg DECIMAL(5, 2) NOT NULL,
  PRIMARY KEY (id)
);
