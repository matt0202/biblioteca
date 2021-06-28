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

--cargar archivo

copy socios FROM './socios.csv' csv header;

copy peliculas FROM './historial.csv' csv header;

\copy reparto FROM './libros.csv' csv header;

--Mostrar todos los libros que posean menos de 300 páginas

SELECT COUNT (libros) FROM libros
WHERE  PAG. = '-300';

--Mostrartodoslosautoresquehayannacidodespuésdel01-01-1970.

SELECT NOMBRE_AUTOR,anio FROM NOMBRE_AUTOR WHERE anio BETWEEN 1970 AND  2020 ORDER BY NOMBRE_AUTOR ASC;

--¿Cuál es el libro más solicitado?

SELECT historial, LENGTH(LIBRO) AS LIBRO FROM historial;

--Sisecobraraunamultade$100porcadadíadeatraso,mostrarcuántodeberíapagarcadausuarioqueentregueelpréstamodespuésde7días

