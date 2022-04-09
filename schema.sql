/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id  INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species varchar(100);

-- Creating a table named owners with the following columns:
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    age integer
);

-- Creating a table named species with the following columns:
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

-- Modifying animals table by doing the following 🥶
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

-- Creating a table named vets with the following columns:
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100) NOT NULL,
    age INT,
    date_of_graduation date
);

-- Joining Table for vets & species table: 🥶
CREATE TABLE specializations (
    vets_id INT NOT NULL,
    species_id INT NOT NULL,
    FOREIGN KEY (vets_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(vets_id, species_id)
);

-- Joining Table for animals & vets table: 🥶
CREATE TABLE visits (
    animals_id INT NOT NULL,
    vets_id INT NOT NULL,
    date_of_visit date,
    FOREIGN KEY (animals_id) REFERENCES animals(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (vets_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (animals_id, vets_id)
);
