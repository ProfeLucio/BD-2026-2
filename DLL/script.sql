SHOW DATABASES; /*Muestro las bases datos*/
CREATE DATABASE operacion; /*Para crear una base de datos*/
USE operacion; /*Seleccionar la base de datos para trabajar*/
SHOW TABLES; /*Me muestra las tablas de la base de datos seleccionada*/
CREATE TABLE hogar (
    id INTEGER PRIMARY KEY, 
    persona_contacto VARCHAR(100) NOT NULL,
    cantidad_personas INTEGER NOT NULL,
    condicion_prioridad VARCHAR(255),
    tipo_zona VARCHAR(20) NOT NULL,
    division_territorial VARCHAR(100) NOT NULL, 
    referencia_ubicacion VARCHAR(255),
    idbarrio  INTEGER 

);
INSERT INTO hogar (id, persona_contacto, cantidad_personas, condicion_prioridad, tipo_zona, 
division_territorial, idbarrio) 
VALUES 
(1, "Gonzalo Lucio", 4, "Urgente", "Fuera de la Ciudad", "No Se", 5);


DESC hogar; /**DEscribir la estructura de la tabla hogar*/

ALTER TABLE hogar DROP COLUMN idbarrio;
ALTER TABLE hogar ADD idbarrio INTEGER;



CREATE TABLE barrio (
    id INTEGER PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(255)
);

INSERT INTO barrio (id, nombre, estado) 
VALUES (1, "Bella Vista", "activo"), (2, "Independencia", "activo"), (3, "Cascajal", "activo");


SELECT persona_contacto, nombre
FROM hogar
INNER JOIN barrio ON hogar.idbarrio = barrio.id;

ERROR DE INTEGRIDAD
Integridad Referencial (Llaves Foraneas)

ALTER TABLE hogar ADD FOREIGN KEY (idbarrio) REFERENCES barrio(id);
DELETE FROM hogar;

INSERT INTO hogar (id, persona_contacto, cantidad_personas, condicion_prioridad, tipo_zona, 
division_territorial, idbarrio) 
VALUES 
(1, "Gonzalo Lucio", 4, "Urgente", "Fuera de la Ciudad", "No Se", 3);

DELETE FROM barrio WHERE id = 1;