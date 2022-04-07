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
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100) NOT NULL,
    age integer,
    PRIMARY KEY(id)
);

-- Creating a table named species with the following columns:
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    PRIMARY KEY(id)
);

-- Modifying animals table by doing the following 🥶
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id integer;
ALTER TABLE animals ADD COLUMN owner_id integer;
