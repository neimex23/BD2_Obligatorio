/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

7-Devolver todos los tipos de referencias entre películas de una saga. 

------------------------------------------------------------------------------------------------------------------
*/

SELECT distinct mr.type as tipo, m1.name as nombre_pelicula_saga, m2.name as nombre_de_pelicula_referenciada
FROM movie_references mr join movies m1 on mr.reference_to = m1.id join movies m2 on mr.referenced_by = m2.id
-- movies referenciadas  si están en la misma saga que la película de la referencia
WHERE mr.reference_to in (
    	SELECT ms.movie_id
    	FROM movie_in_saga ms
    	-- obtiene la saga de la pelicula
    	WHERE ms.saga_id = 
            	(SELECT ms2.saga_id
            	FROM movie_in_saga ms2
            	WHERE ms2.movie_id = mr.reference_to)
	) or mr.referenced_by in (
    			SELECT ms3.movie_id
    			FROM movie_in_saga ms3
    			WHERE ms3.saga_id = 
            			(SELECT ms4.saga_id
            			FROM movie_in_saga ms4
            			WHERE ms4.movie_id = mr.referenced_by)
	);









