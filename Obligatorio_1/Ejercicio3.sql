/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

3- Devolver para cada saga su nombre y todos los géneros (nombre e identificador) que le
corresponden.

------------------------------------------------------------------------------------------------------------------
*/

SELECT s.name AS saga_name, g.id AS genre_id, g.name AS genre_name
FROM sagas s
JOIN movie_in_saga mis ON s.id = mis.saga_id
JOIN movies m ON mis.movie_id = m.id
JOIN movie_genres mg ON m.id = mg.movie_id
JOIN genres g ON mg.genre_id = g.id;


