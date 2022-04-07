/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT animals_deleted;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals_deleted;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT ROUND(AVG(weight_kg)::numeric, 2) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, ROUND(AVG(escape_attempts)::numeric, 0) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;


-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT Animal, Species FROM (SELECT animals.name AS Animal, species.name as Species FROM animals, species WHERE animals.species_id = species.id) _ WHERE Species = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0 GROUP BY animals.name;
-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;
