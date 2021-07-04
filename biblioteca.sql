\c postgres
DROP DATABASE biblioteca

CREATE DATABASE biblioteca
\c biblioteca
CREATE TABLE biblioteca(
    id SERIAL,
    socios VARCHAR8,
    libros INT,
    historial VARCHAR,
    PRIMARY KEY(id) 
);

CREATE TABLE libros(
    isbn VARCHAR(15),
    titulo VARCHAR(50),
    pagina INT,
    codigoautor INT,
    nombreautor VARCHAR(15),
    apellidoautor VARCHAR(15),
    nacimiento INT,
    muerte INT,
    tipodeautor VARCHAR(15),
    diasprestamo INT,
    PRIMARY KEY(titulo)
);

CREATE TABLE socios(
    rut VARCHAR(15),
    socio VARCHAR(30),
    apellido VARCHAR(30),
    direccion VARCHAR(50),
    telefono INT,
    PRIMARY KEY(rut)
);

CREATE TABLE historial(
    rut VARCHAR(15),
    socio VARCHAR(50),
    libro VARCHAR(50),
    fechaprestamo DATE,
    fechadevolucion DATE,
    FOREIGN KEY (rut) REFERENCES socios(rut),
    FOREIGN KEY (libro) REFERENCES libros(titulo)
);

--cargar archivo

\copy socios FROM './socios.csv' csv header;

\copy peliculas FROM './historial.csv' csv header;

\copy reparto FROM './libros.csv' csv header;

--Mostrar todos los libros que posean menos de 300 páginas

SELECT COUNT (libros) FROM libros
WHERE  PAG. < 300;

--Mostrartodoslosautoresquehayannacidodespuésdel01-01-1970.

SELECT nombreautor, apellidoautor FROM libros WHERE nacimiento > 1970;

--¿Cuál es el libro más solicitado?

SELECT libro, COUNT(libro) AS total FROM historial GROUP BY libro ORDER BY total DESC LIMIT 1;

--Sisecobraraunamultade$100porcadadíadeatraso,mostrarcuántodeberíapagarcadausuarioqueentregueelpréstamodespuésde7días

SELECT A.rut, B.título, A.fecha_préstamo, A.fecha_devolución, B.días_préstamo, (A.fecha_devolución - A.fecha_préstamo) AS "Días prestado", ((A.fecha_devolución - A.fecha_préstamo) - B.días_préstamo) AS "Días de atraso", ((A.fecha_devolución - A.fecha_préstamo) - B.días_préstamo) * 100 AS "Multa en $"
FROM historial AS A
JOIN libros AS B
ON A.isbn=B.isbn
WHERE ((A.fecha_devolución - A.fecha_préstamo) - B.días_préstamo) * 100 > 7;
