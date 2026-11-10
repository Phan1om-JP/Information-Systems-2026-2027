USE sakila;
-- List names of all the languages in the database (sorted alphabetically)?

CREATE VIEW  all_language AS 
SELECT l.name
FROM language as l
ORDER BY l.name ASC;

SELECT * FROM all_language;

-- List full names of actors with “GER” in their last name, ordered by their first name

CREATE VIEW GER_actor AS 
SELECT CONCAT(a.first_name, ' ', a.last_name) as full_name
FROM actor as a
WHERE a.last_name LIKE "%GER%";

SELECT * FROM GER_actor ORDER BY full_name ASC;

-- Find all the addresses where postal code starts with “57”, and return addresses sorted.

CREATE VIEW postal_57 AS
SELECT addr.postal_code
FROM address as addr
WHERE addr.postal_code LIKE "57%"
ORDER BY addr.postal_code ASC;

SELECT * FROM postal_57;

-- How many films involve a “DWARF” in their titles?

CREATE VIEW dwarf_film AS
SELECT COUNT(f.title)
FROM film as f
WHERE f.title LIKE "%DWARF%";

SELECT * FROM dwarf_film;

-- Find full names of actors who played in a film involving ‘WAR’ in title and longer than 2.5 hours, along with the title, runlength and release year of the movie, sorted by the actors’ last names.

CREATE VIEW war_actor AS
SELECT CONCAT(a.first_name, ' ', a.last_name) AS full_name, f.title, f.length, f.release_year
FROM actor as a
JOIN film_actor as fa ON a.actor_id = fa.actor_id
JOIN film as f ON fa.film_id = f.film_id
WHERE f.title LIKE "%WAR%" AND f.length > 150
ORDER BY a.last_name ASC;

SELECT * FROM war_actor;

-- Find all the film categories in which there are between 55 and 65 films. 
-- Return the names of these categories and the number of films per category, 
-- sorted by the number of films descending.

SELECT c.name, COUNT(*) AS film_count
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
HAVING COUNT(*) BETWEEN 55 AND 65
ORDER BY film_count DESC;

-- In how many film categories is the average difference between the film replacement cost and the rental rate larger than 17?

SELECT COUNT(*) AS num_categories
FROM (
SELECT fc.category_id
FROM film_category AS fc
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY fc.category_id
HAVING AVG(f.replacement_cost - f.rental_rate) > 17
) AS big_categories;

-- Find the address district(s) name(s) such that the minimal postal code in the district(s) is maximal over all the districts. Make sure your query ignores empty postal codes and district names.

SELECT district, MIN(postal_code) AS min_postal
FROM address
WHERE postal_code <> '' AND district <> ''
GROUP BY district
HAVING MIN(postal_code) = (
SELECT MAX(min_pc)
FROM (
SELECT MIN(postal_code) AS min_pc
FROM address
WHERE postal_code <> '' AND district <> ''
GROUP BY district
) AS per_district
);


-- Find the names (first and last) of all the actors and customers whose first name is the same as the first name of the actor with ID 101 (exclude the actor with ID 101).