#Habilitar la BD
USE bdmascotas;
ALTER TABLE Vacunas ADD COLUMN Vigencia DATE AFTER enfermedad;

#Punto 1: Incluir en la tabla vacuna el campo de vigencia de la vacuna, crear una función para saber si la vacuna está vigente o está vencida
DELIMITER $$
CREATE FUNCTION EstadoVacuna(fechaVigencia DATE)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(20);
    IF fechaVigencia >= CURDATE() THEN
        SET estado = 'Vigente';
    ELSE
        SET estado = 'Vencida';
    END IF;
    RETURN estado;
END $$
DELIMITER ;

#Punto 2: Crear una función para mostrar el nombre de la mascota, raza y nombre del dueño
DELIMITER $$
CREATE FUNCTION DatosMascotaDueño(p_idMascota INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE v_nombreMascota VARCHAR(50);
    DECLARE v_raza VARCHAR(50);
    DECLARE v_nombreCliente VARCHAR(100);
    DECLARE resultado VARCHAR(255);

    SELECT M.nombreMascota, M.raza, CONCAT(C.nombreCliente1, ' ', C.apellidoCliente1)
    INTO v_nombreMascota, v_raza, v_nombreCliente
    FROM Mascota M
    INNER JOIN Cliente C ON M.documentoClienteFK = C.documentoCliente
    WHERE M.idMascota = p_idMascota;

    SET resultado = CONCAT('Mascota: ', v_nombreMascota, ', Raza: ', v_raza, ', Dueño: ', v_nombreCliente);
    RETURN resultado;
END $$
DELIMITER ;

#Punto 3: Crear un trigger que impida que se elimine un cliente si tiene una mascota registrada
DELIMITER $$
CREATE TRIGGER trg_delete_cliente
BEFORE DELETE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Mascota WHERE documentoClienteFK = OLD.documentoCliente;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el cliente: tiene mascotas registradas';
    END IF;
END $$
DELIMITER ;

#Punto 4: Crear un trigger que cuando se elimine un cliente lo guarde en una tabla que se llame clientesEliminados
CREATE TABLE ClienteEliminados (
    documentoCliente VARCHAR(50),
    nombreCliente VARCHAR(50),
    direccionCliente VARCHAR(100),
    telefonoFK VARCHAR(50),
    fechaEliminacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_backup_cliente
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO ClienteEliminados(documentoCliente, nombreCliente, direccionCliente, telefonoFK)
    VALUES(OLD.documentoCliente, OLD.nombreCliente, OLD.direccionCliente, OLD.telefonoFK);
END $$
DELIMITER ;

#Punto 5: En la tabla cliente agregar un campo que se llame fecha de actualizacion y crear un trigger cada vez que se actualice ese campo de fecha
ALTER TABLE Cliente ADD COLUMN fechaActualizacion TIMESTAMP NULL AFTER telefonoFK;

DELIMITER $$
CREATE TRIGGER trg_update_cliente_fecha
BEFORE UPDATE ON Cliente
FOR EACH ROW
BEGIN
    SET NEW.fechaActualizacion = NOW();
END $$
DELIMITER ;
