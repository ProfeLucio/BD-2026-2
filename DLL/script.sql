SHOW DATABASES;
CREATE DATABASE operacion;
USE operacion;
CREATE TABLE hogar (
    id INTEGER PRIMARY_KEY, 
    persona_contacto VARCHAR(100) NOT NULL,
    cantidad_personas INTEGER NOT NULL,
    condicion_prioridad VARCHAR(255),
    tipo_zona VARCHAR(20) NOT NULL,
    division_territorial VARCHAR(100) NOT NULL, referencia_ubicacion VARCHAR(255),
    idbarrio  INTEGER 

);