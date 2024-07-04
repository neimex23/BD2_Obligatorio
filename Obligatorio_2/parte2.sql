drop procedure balance_cliente
delimiter //
CREATE procedure balance_cliente(
		IN id_cliente INT,
		IN fecha TIMESTAMP,
		OUT saldo INT
	)
BEGIN
   DECLARE total_costo_alquiler DECIMAL(10,2) DEFAULT 0;
   DECLARE total_atraso INT;
   DECLARE duracion_alquiler INT;
   DECLARE costo_reemplazo_pelicula INT;
   DECLARE done INT DEFAULT 0;
   DECLARE atraso INT;
   DECLARE pagosRealizados INT DEFAULT 0;
   DECLARE fecha_devolucion TIMESTAMP;
   DECLARE fecha_alquiler  TIMESTAMP;
 
 
  	DECLARE cur_atrasos CURSOR FOR
	select (DATEDIFF(a.fechaDevolucion, a.fecha) -  p.duracionAlquiler) as diasDeAtraso, p.duracionAlquiler, p.costoReemplazo, a.fechaDevolucion, a.fecha
	from alquileres a
	join peliculas p
	on a.idPelicula = p.idPelicula  
	where (DATEDIFF(a.fechaDevolucion, a.fecha) > p.duracionAlquiler OR a.fechaDevolucion IS NULL)
	and a.fecha < fecha
	and a.idCliente = id_cliente;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
   -- 1. Suma de los costos de alquiler de todos los alquileres realizados ANTES de la fecha de cálculo. 
	select SUM(p.costoAlquiler) INTO total_costo_alquiler
	from alquileres a
	join peliculas p
	on a.idPelicula = p.idPelicula
	where a.idCliente = idCliente
	and a.fecha < fecha;
 
  -- 2. Recargo de $5 por cada día de atraso de los alquileres considerados en el punto 1.
		-- ToDo: No olvidar chequear los casos que no tienen fecha de devolucion
		OPEN cur_atrasos;
		WHILE (done = 0) DO 		
			FETCH cur_atrasos INTO atraso, duracion_alquiler, costo_reemplazo_pelicula, fecha_devolucion, fecha_alquiler;
				IF NOT done THEN
					
					IF fecha_devolucion IS NULL THEN -- si no devolvio aun calcular dias de atraso que lleva hasta hoy.	
						set total_costo_alquiler = total_costo_alquiler + (DATEDIFF(fecha, fecha_alquiler) * 5);	
					ELSE
						IF atraso > (duracion_alquiler * 3) THEN
							-- 3. cobrar el costo de reemplazo de la película.
							set total_costo_alquiler = total_costo_alquiler + costo_reemplazo_pelicula;
						END IF;		
						set total_costo_alquiler = total_costo_alquiler + (atraso * 5);	
					END IF;
				END IF;
		END WHILE;
	
		CLOSE cur_atrasos;  
	
		-- 4. Descontar todos los pagos que el cliente haya realizado ANTES de la fecha de cálculo.
		select sum(p.monto) INTO pagosRealizados
		from pagos p
		where p.idClienteAlquilo = id_cliente
		and p.fecha < fecha;
		
		IF pagosRealizados IS NOT NULL THEN
			set saldo = total_costo_alquiler - pagosRealizados;
		ELSE
			set saldo = total_costo_alquiler;
		END IF;
	
END;
//

CREATE TABLE balace (id_cliente int primary key, fecha_calculo date not null, saldo int not null);
DROP PROCEDURE balance_clientes
DELIMITER //
CREATE PROCEDURE balance_clientes(
		IN fecha TIMESTAMP
	)
BEGIN
	DECLARE ft_cliente INT;
	DECLARE done INT DEFAULT 0;
	DECLARE cur_clientes CURSOR FOR
		SELECT idCliente from clientes;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Done = 1;
 	
	OPEN cur_clientes;
		WHILE (Done = 0) DO
			FETCH cur_clientes INTO ft_cliente;
			IF NOT Done THEN
				CALL balance_cliente(ft_cliente, fecha, @saldo_balance_total);
                
                IF (NOT EXISTS (select * FROM balance b WHERE b.id_cliente = ft_cliente)) THEN
					INSERT INTO balance (id_cliente, fecha_calculo, saldo) VALUES (idCliente, fecha, saldo);
				ELSE
					UPDATE balance 
                    SET fecha_calculo = @saldo_balance_total, saldo = @saldo_balance_total 
                    WHERE id_cliente = ft_cliente;
				END IF;
                
			END IF;
		END WHILE;
	CLOSE cur_clientes;
END;
//

-- COMANDOS PARA LLAMAR
/*
CALL balance_cliente(554, "2005-08-22 00:30:32", @saldo_balance_total);
SELECT @saldo_balance_total;
