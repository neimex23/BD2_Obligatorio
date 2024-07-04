/*

------------------------------------------------------------------------------------------------------------------
Obligatorio Base de Datos 2
Nocturno - Grupo 26

2- Devolver el nombre de las películas que fueron a pérdida y la cantidad que perdieron.
Solo se deben considerar películas ya estrenadas. 

------------------------------------------------------------------------------------------------------------------
*/

SELECT m.name as NameOfMovie, m.date as DatoOfPremiere, (m.budget - m.revenue) as AmountLost
FROM movies m 
WHERE m.budget > m.revenue AND date < now(); 

