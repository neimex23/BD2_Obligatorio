/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

11-Devolver el nombre de todas las mujeres que participaron en una única película en el
año 2015. Se debe retornar además el nombre de la película en la que participaron y el
trabajo que hicieron en la misma

------------------------------------------------------------------------------------------------------------------
*/

SELECT p.name as woman_name, m.name as movie_name, j.name as job_name
FROM people p join casts c on p.id = c.person_id join jobs j on c.job_id = j.id join movies m on c.movie_id = m.id
WHERE  p.gender = 1 and year(m.date) = 2015 and p.id in (
    	SELECT c2.person_id
    	FROM casts c2
    	GROUP BY c2.person_id
    	HAVING count(*) = 1);













