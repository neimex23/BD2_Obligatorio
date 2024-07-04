/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

8-Devolver para cada saga, los actores que participaron de todas sus películas. 

------------------------------------------------------------------------------------------------------------------
*/

SELECT 
		s.id AS SagaId,
		s.name AS SagaName,
		c.person_id AS PersonId,
		p.name as ActorName,
		count(*) as TotalOfMovies
FROM sagas s 
JOIN movie_in_saga mis ON s.id = mis.saga_id  
JOIN casts c ON mis.movie_id = c.movie_id 
JOIN people p ON c.person_id = p.id  AND c.job_id = 15 
GROUP BY s.id, c.person_id  
HAVING count(*) = (
				SELECT count(*) as CantidadDePeliculas  
				FROM movie_in_saga mis2
				WHERE mis2.saga_id = s.id  
				GROUP BY saga_id); 









