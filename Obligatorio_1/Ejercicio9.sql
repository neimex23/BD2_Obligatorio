/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

9-Devolver la edad de todas las personas que participaron en alguna película, en
conjunto con el nombre de la película de la que participaron, para las películas con más
de 8 personas en su elenco. 


------------------------------------------------------------------------------------------------------------------
*/

SELECT 
    p.name AS person_name, 
    m.name AS movie_name, 
    YEAR(NOW()) - YEAR(p.birthdate) - 
    IF(MONTH(NOW()) < MONTH(p.birthdate) OR 
       (MONTH(NOW()) = MONTH(p.birthdate) AND DAY(NOW()) < DAY(p.birthdate)), 1, 0) AS age
FROM 
    casts AS c JOIN people AS p ON c.person_id = p.id
	JOIN movies AS m ON c.movie_id = m.id
GROUP BY 
    p.id, m.id
HAVING 
    COUNT(*) > 8;











