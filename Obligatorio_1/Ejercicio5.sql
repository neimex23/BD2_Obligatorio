/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

5-Devolver identificador, nombre y duración de cada saga. Se entiende que la duración
de cada saga es la suma de las duraciones de las películas que la conforman. 


------------------------------------------------------------------------------------------------------------------
*/

SELECT saga.id as IDsaga, saga.name as NombreSaga, SUM(peli.runtime) as Duracion
FROM sagas as saga JOIN movie_in_saga as pelis_saga on saga.id = pelis_saga.saga_id
JOIN movies as peli on pelis_saga.movie_id = peli.id
GROUP BY saga.id;




