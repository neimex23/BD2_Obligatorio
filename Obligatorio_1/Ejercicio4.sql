/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

4-Devolver identificador nombre y fecha de estreno de las películas que forman parte de
cada saga, en conjunto con el nombre de cada saga. Los datos devueltos deben estar
ordenados por nombre de saga y fecha de estreno de las películas. 


------------------------------------------------------------------------------------------------------------------
*/

SELECT m.id as PeliID, m.name as NombrePeli, m.date as Estreno, s.name as NombreSaga
FROM movie_in_saga MS join sagas S on MS.saga_id = S.id join movies M on M.id = MS.movie_id
ORDER by NombreSaga, Estreno; 



