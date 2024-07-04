use bd2gr26;
CREATE table inconsist_tot_pel(id_alerta SERIAL primary key, id_pelicula int);

DELIMITER //
CREATE TRIGGER tot_peliculas AFTER INSERT ON peliculas
FOR EACH ROW
BEGIN
    INSERT INTO  inconsist_tot_pel(id_pelicula) VALUES (NEW.idPelicula);
END//;

DELIMITER //
CREATE TRIGGER tot_peliculas_borrar AFTER INSERT ON idiomasDePeliculas
FOR EACH ROW
BEGIN
    DELETE FROM inconsist_tot_pel WHERE id_pelicula = NEW.idPelicula;
END//;

-- Comandos de Testeos Ingreso de pelicula nueva e idioma para probar los triggers
/*
SET SQL_SAFE_UPDATES = 0;
INSERT INTO peliculas (idPelicula, titulo, descripcion, anio, idIdiomaOriginal, duracionAlquiler, costoAlquiler, duracion, costoReemplazo, clasificacion, contenidosExtra) VALUES (2030, 'CLONES PINOCCHIO', 'A Amazing Drama of a Car And a Robot who must Pursue a Dentist in New Orleans', 2006, 1, 6, 59.80, 124, 339.80, 'R', '{"Behind the Scenes"}');

INSERT INTO idiomasDePeliculas (idIdioma, idPelicula) VALUES (1, 2030);

select *
from inconsist_tot_pel
/*