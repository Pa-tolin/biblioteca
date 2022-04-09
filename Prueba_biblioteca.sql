--PARTE 1

--1 Modelo Conceptual en foto

--2 Modelo Logico en foto

--3 Modelo Físco (Tablas, columnas, claves)

-- Crear Base de datos
--(Parte 2.1)
CREATE DATABASE biblioteca;

CREATE TABLE socio(
	rut VARCHAR(13) PRIMARY KEY,
	nombre VARCHAR(15),
	apellido VARCHAR(15),
	direccion VARCHAR(50),
	telefono VARCHAR(9)
);

CREATE TABLE libro(
	isbn BIGINT PRIMARY KEY,
	titulo VARCHAR(50),
	num_pag INT
);

CREATE TABLE prestamo(
	id_prestamo INT PRIMARY KEY,
	fecha_prestamo DATE,
	fecha_devolucion DATE,
	isbn_libro BIGINT,
	rut_socio VARCHAR(13),
	FOREIGN KEY (isbn_libro) REFERENCES libro (isbn),
	FOREIGN KEY (rut_socio) REFERENCES socio (rut)
);

CREATE TABLE autor(
	cod_autor INT PRIMARY KEY,
	nombre VARCHAR(15),
	apellido VARCHAR(15),
	fecha_nac VARCHAR(5),
	fecha_mue VARCHAR(5),
	tipo_autor VARCHAR(15)
);

CREATE TABLE relacion_libro_autor(
	id INT,
	isbn_libro BIGINT,
	cod_autor INT, 
	tipo_autor VARCHAR(10),
	FOREIGN KEY (isbn_libro) REFERENCES libro (isbn)
);

--PARTE 2


--2 Insertar datos

INSERT INTO socio (rut,nombre,apellido,direccion,telefono)
VALUES
('1111111-1','JUAN','SOTO','AVENIDA 1,SANTIAGO',911111111),
('2222222-2', 'ANA', 'PEREZ', 'PASAJE 2,SANTIAGO',922222222),
('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2,SANTIAGO',933333333),
('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3,SANTIAGO',944444444),
('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3,SANTIAGO',955555555);

INSERT INTO libro (isbn,titulo,num_pag)
VALUES
(1111111111111,'CUENTOS DE TERROR',344),
(2222222222222,'POESIAS CONTEMPORANEAS',167),
(3333333333333,'HISTORIA DE ASIA',511),
(4444444444444,'MANUAL DE MECANICA',298);

INSERT INTO prestamo (id_prestamo,fecha_prestamo,fecha_devolucion,isbn_libro,rut_socio)
VALUES
(1,'2020-01-20','2020-01-27',1111111111111,'1111111-1'),
(2,'2020-01-20','2020-01-27',3333333333333,'5555555-5'),
(3,'2020-01-22','2020-01-30',4444444444444,'3333333-3'),
(4,'2020-01-23','2020-01-30',4444444444444,'4444444-4'),
(5,'2020-01-27','2020-02-04',1111111111111,'2222222-2'),
(6,'2020-01-31','2020-02-12',4444444444444,'1111111-1'),
(7,'2020-01-31','2020-02-12',2222222222222,'3333333-3');

INSERT INTO autor (cod_autor,nombre,apellido,fecha_nac,fecha_mue)
VALUES
(3,'JOSE','SALGADO',1968, 2020),
(4,'ANA','SALGADO',1972, 0),
(1,'ANDRES','ULLOA',1982, 0),
(2,'SERGIO','MARDONES',1950, 2012),
(5,'MARTIN','PORTA',1976, 0);

INSERT INTO relacion_libro_autor (id,isbn_libro,cod_autor,tipo_autor)
VALUES
(1,1111111111111,3,'PRINCIPAL'),
(2,1111111111111,4,'COAUTOR'),
(3,2222222222222,1,'PRINCIPAL'),
(4,3333333333333,2,'PRINCIPAL'),
(5,4444444444444,5,'PRINCIPAL');



-- PARTE 3 

-- a. Mostrar todos los libros que posean menos de 300 páginas.
SELECT * FROM libro WHERE num_pag < 300;

-- b. Mostrar todos los autores que hayan nacido después del 01-01-1970.
SELECT nombre, apellido FROM autor WHERE fecha_nac > '1970-01-01';

-- c. el libro más solicitado
SELECT COUNT (prestamo.isbn_libro), prestamo.isbn_libro, libro.titulo
FROM prestamo
INNER JOIN libro ON prestamo.isbn_libro = libro.isbn
GROUP BY prestamo.isbn_libro, libro.titulo
ORDER BY count (*)
DESC LIMIT 1;

-- d. Multa de $100 por cada día de atraso.
SELECT rut_socio,(((fecha_devolucion::DATE - fecha_prestamo::DATE)-7)*100) AS Multa
FROM prestamo;
