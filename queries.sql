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

====++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name, B.name As Species FROM animals A JOIN species B ON A.species_id = B.id WHERE B.name = 'Pokemon';
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

---
SELECT vets.name, date_of_visit, animals.name FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;
SELECT species.name FROM specializations s JOIN vets ON s.vets_id = vets.id JOIN visits ON visits.vets_id = vets.id JOIN species ON s.species_id = species.id WHERE vets.name = 'Stephanie Mendez' GROUP BY species.name;
SELECT vets.name AS vet_name, sp.name AS sp_name FROM vets FULL JOIN specializations s ON s.vets_id = vets.id LEFT JOIN species sp ON s.species_id = sp.id;
SELECT vt.name AS vet_name, a.name AS ani_name, date_of_visit FROM visits v JOIN animals a ON v.animals_id = a.id JOIN vets vt ON v.vets_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
SELECT name, COUNT(date_of_birth) FROM animals a JOIN visits v ON a.id = v.animals_id GROUP BY a.name ORDER BY count DESC LIMIT 1;
SELECT a.name, vt.name, date_of_visit FROM visits v JOIN vets vt ON v.vets_id = vt.id JOIN animals a ON v.animals_id = a.id WHERE vt.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;
SELECT a.name AS ani_name, vt.name AS vet_name, date_of_visit FROM visits v JOIN animals a ON v.animals_id = a.id JOIN vets vt ON v.vets_id = vt.id ORDER BY date_of_visit DESC LIMIT 1;
SELECT COUNT(sp.name), sp.name FROM visits v JOIN animals a ON v.animals_id = a.id JOIN species sp ON a.species_id = sp.id JOIN vets vt ON v.vets_id = vt.id WHERE vets_id = 2 GROUP BY(sp.name) limit 1;
SELECT COUNT(*) AS species FROM visits v FULL OUTER JOIN vets vt ON v.vets_id = vt.id FULL OUTER JOIN specializations s ON s.vets_id = vt.id WHERE species_id IS NULL;

