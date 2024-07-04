/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

6-Devolver nombre del género del que existen más cantidad de películas.

------------------------------------------------------------------------------------------------------------------
*/

SELECT g.name as genero, count(*) as cantidad
FROM genres g join movie_genres mg on g.id = mg.genre_id
GROUP BY g.name
HAVING count(*) >= all (
   					SELECT count(*) as cantidad
   			   		FROM genres g join movie_genres mg on g.id = mg.genre_id
   			   		GROUP by g.name); 






