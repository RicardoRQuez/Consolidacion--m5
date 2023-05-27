SELECT * FROM staff;
SELECT * FROM address;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;
SELECT * FROM payment ORDER BY customer_id;
-- listar tablas --
SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';

--listar detalles de la tabla
select * from information_schema.columns where table_name = 'actor';

-- 4.• Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.
 -- 3.1 Insertar Customer
 SELECT * FROM customer;
 SELECT * FROM store;

INSERT INTO customer VALUES
(default, 1,'Ricardo', 'Rodriguez', 'ricardo.rodriguez@sakilacustomer.org', 123, true, '2023-05-18', localtimestamp, 1);

INSERT INTO customer VALUES
(default, 2, 'Andres', 'Urriola', 'andres.Urriola@sakilacustomer.org', 321, true, default, localtimestamp,1),
(default, 2, 'Javier', 'Rojas', 'javier.rojas@sakilacustomer.org', 231, true, default, localtimestamp,1);
aqui
	--Modificar customer id 600 Ricardo Rodriguez. cambio de email
UPDATE customer SET email = 'ricardo.r@sakilacustomer.org' WHERE customer_id = 600;

 	--Eliminar Customer id 1 Mary Smith
DELETE FROM payment WHERE customer_id = 1;
DELETE FROM rental WHERE customer_id = 1;
DELETE FROM customer WHERE customer_id = 1;
SELECT * FROM customer;

	--3.2 Insertar Staff
SELECT * FROM staff;
INSERT INTO staff VALUES 
(default, 'Carlos', 'Gonzalez', 3, 'carlos.gonzalez@sakilacustomer.org', 1, true, 'Carlitos', 1234, localtimestamp, '' );

	--Modificar Staff cambio de estado active a false
UPDATE staff SET active = false WHERE staff_id = 3;

	--Eliminar Staff
DELETE FROM staff WHERE  staff_id = 3;

	--3.3 Insertar Actor
SELECT * FROM actor;
INSERT INTO actor VALUES
(default, 'Mario', 'Bros', default);

	--Modificar actor  ad 1
UPDATE actor SET last_name = 'Rodriguez' WHERE actor_id = 1;

	--Eliminar el actor id 2
DELETE FROM film_actor WHERE actor_id = 2;
DELETE FROM actor WHERE actor_id = 2;


-- Listar todas las “rental” con los datos del “customer” dado un año y mes. Mayo 2005

SELECT 
	r.rental_id,
	r.rental_date,
	c.first_name,
	c.last_name,
	c.email
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
WHERE
	extract(year FROM rental_date) = 2005 AND
	extract(month FROM rental_date) = 5
	
-- Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
select * from payment;

SELECT payment_id,
	payment_date,
	amount
FROM payment
ORDER BY payment_date desc;

	-- payments agrupadas por fecha --

SELECT  count(*) as quantity, 
	payment_date, 
	sum(amount)
FROM payment 
group by payment_date 
ORDER BY count(*) DESC;

-- Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.

SELECT * from film
where rental_rate > 4.0
order by rental_rate desc;

-- Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, y su tipo de dato correspondiente

SELECT
    t1.TABLE_NAME AS tabla_nombre,
    t1.COLUMN_NAME AS columna_nombre,
    t1.COLUMN_DEFAULT AS columna_defecto,
    t1.IS_NULLABLE AS columna_nulo,
    t1.DATA_TYPE AS columna_tipo_dato
FROM 
    INFORMATION_SCHEMA.COLUMNS t1
    INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE 
    t1.TABLE_SCHEMA = 'public'
ORDER BY
    t1.TABLE_NAME;


 

