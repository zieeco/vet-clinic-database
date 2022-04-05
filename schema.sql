/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name varchar(100) NOT NULL,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
)
ALTER TABLE animals ADD COLUMN species varchar(100);


