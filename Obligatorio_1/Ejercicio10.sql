/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

10-Para cada película (devolver su nombre), devolver la edad de la persona más joven
que participó en la misma y el nombre del trabajo que realizó. 


------------------------------------------------------------------------------------------------------------------
*/

SELECT peli.name AS Nombre_Pelicula,
       MIN(YEAR(peli.date) - YEAR(perso.birthdate)) AS Edad_MasJoven,
       (SELECT job.name
        FROM casts AS cas
        JOIN people AS perso ON cas.person_id = perso.id
        JOIN jobs AS job ON cas.job_id = job.id
        WHERE cas.movie_id = peli.id
        ORDER BY YEAR(peli.date) - YEAR(perso.birthdate) ASC
        LIMIT 1) AS Trabajo_MasJoven
FROM movies AS peli
JOIN casts AS cas ON peli.id = cas.movie_id
JOIN people AS perso ON cas.person_id = perso.id
GROUP BY peli.id
ORDER BY peli.name;












