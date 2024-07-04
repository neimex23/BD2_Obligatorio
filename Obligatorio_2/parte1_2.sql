create table inconsist_r3 (idIncon serial primary key, id_sucursal int, id_personal int);

-- Para el trigger de update es exactamente igual solo que cambiaria el encabezado "before insert" por "before update"
delimiter //
CREATE TRIGGER r3_encargados BEFORE INSERT ON sucursales
FOR EACH ROW
BEGIN
    DECLARE retorn CHAR(255);

    -- id encargado no nulo
    IF NEW.idEncargado IS NOT NULL THEN
        -- Chequea si el encargado existe,esta en su sucursal y es activo
        IF NOT EXISTS (
            SELECT * 
            FROM personal p 
            WHERE p.idPersonal = NEW.idEncargado 
              AND p.idSucursal = NEW.idSucursal 
              AND p.activo = TRUE
        ) THEN
            -- Agrega a tabla inconsistencia audit
            INSERT INTO inconsist_r3 (id_sucursal, id_personal) 
            VALUES (NEW.idSucursal, NEW.idEncargado);

            -- Preparar Mensaje Retorno
            SET retorn = CONCAT(
                'No se permite la inserción/actualización: ', 
                'Encargado ', CAST(NEW.idEncargado AS CHAR), 
                ' no existe, no está activo, o no pertenece a la sucursal ', 
                CAST(NEW.idSucursal AS CHAR)
            );

            -- Raise an error
            SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = retorn;
        END IF;
     END IF;
END;
    //
  
  /*
 -- Testeo para el ejercio   
INSERT INTO sucursales (idSucursal, idEncargado, direccion, idCiudad, codigoPostal, telefono) VALUES (450, 1, '47 MySakila Drive', 300, '', '');

select *
from personal*/

