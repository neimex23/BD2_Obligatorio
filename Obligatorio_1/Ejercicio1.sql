/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

1- Devolver nombre, duración, promedio de votos y año de estreno de todas las películas
estrenadas a partir del primero de enero de 2011
------------------------------------------------------------------------------------------------------------------
*/

SELECT name as nombre, runtime, vote_average, year(date) as año_estreno FROM movies 
WHERE date >= '2011-01-01'; 
