CREATE DATABASE BD_TechNova;
USE BD_TechNova;

CREATE TABLE Departamento(
	idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12, 2) CHECK (presupuesto > 0)
);

CREATE TABLE Empleado(
	idEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10, 2) CHECK (salario > 0),
    fecha_ingreso DATE,
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES Departamento(idDepartamento)
);

CREATE TABLE Proyecto(
	idProyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    fechaInicio DATE,
    presupuesto DECIMAL(12, 2),
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES Departamento(idDepartamento)
);

CREATE TABLE Asignacion(
	idAsignacion INT AUTO_INCREMENT PRIMARY KEY,
    horasTrabajadas INT CHECK (horasTrabajadas > 0),
    idEmpleado INT,
    idProyecto INT,
    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
    FOREIGN KEY (idProyecto) REFERENCES Proyecto(idProyecto)
);

INSERT INTO Departamento (nombre, presupuesto) VALUES
('Recursos Humanos', 15000000.00),
('Ventas', 8000000.00),
('Marketing', 12000000.00);

INSERT INTO Empleado (nombre, cargo, salario, idDepartamento, fecha_ingreso) VALUES
('Ana Perez','Ingeniera',3000000.00,1,'2022-03-01'),
('Carlos Díaz','Analista',1800000.00,2,'2021-07-15'),
('Luisa Gómez','Programadora',2500000.00,1,'2023-01-10'),
('Jorge Ramírez','Técnico',1400000.00,3,'2020-11-05'),
('María Soto','Gerente',4200000.00,2,'2019-09-01');

INSERT INTO Proyecto (nombre, fechaInicio, presupuesto, idDepartamento) VALUES
('Proyecto 1','2023-02-01',5000000.00,1),
('Proyecto 2','2021-09-15',2000000.00,2),
('Proyecto 3','2024-01-10',7000000.00,3);

INSERT INTO Asignacion (idEmpleado, idProyecto, horasTrabajadas) VALUES
(1,1,200),
(3,1,100),
(2,2,60),
(4,3,40),
(5,2,150);

#Mostrar los empleados cuyo total de horas sea superior al promedio general
	#Promedio General
	SELECT AVG(horasTrabajadas) AS 'PromedioGeneral'
	FROM Asignacion;

	#Empleados cuyo total de horas es mayor al promedio
    SELECT idEmpleado, horasTrabajadas
    FROM Asignacion
    WHERE horasTrabajadas > (SELECT AVG(horasTrabajadas) FROM Asignacion);
    
	#Total horas trabajadas por cada empleado
	SELECT 
		e.idEmpleado,
		e.nombre,
		SUM(a.horasTrabajadas) AS TotalHoras
	FROM Empleado e
	INNER JOIN Asignacion a ON e.idEmpleado = a.idEmpleado
	GROUP BY e.idEmpleado, e.nombre;

#Subconsulta: Comparar horas por empleado Vs promedio general
SELECT 
    e.idEmpleado,
    e.nombre,
    SUM(a.horasTrabajadas) AS TotalHoras
FROM Empleado e
JOIN Asignacion a ON e.idEmpleado = a.idEmpleado
GROUP BY e.idEmpleado, e.nombre
HAVING SUM(a.horasTrabajadas) > (
    SELECT 
        AVG(total_horas)
    FROM (
        SELECT 
            e2.idEmpleado,
            SUM(a2.horasTrabajadas) AS total_horas
        FROM Empleado e2
        JOIN Asignacion a2 ON e2.idEmpleado = a2.idEmpleado
        GROUP BY e2.idEmpleado
    ) AS promedio
);

#Función: PromedioHorasGlobal()
DELIMITER $$
CREATE FUNCTION PromedioHorasGlobal() 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE prom DECIMAL(10,2);
  SELECT AVG(horas_totales) INTO prom
  FROM (
    SELECT idEmpleado, SUM(horasTrabajadas) AS horas_totales
    FROM Asignacion
    GROUP BY idEmpleado
  ) AS t;
  RETURN IFNULL(prom, 0);
END$$
DELIMITER ;

	#Verificación del correcto funcionamiento
	SELECT PromedioHorasGlobal() AS PromedioGeneral;

#Procedimiento: ListarEmpleadosDestacados()
DELIMITER $$
CREATE PROCEDURE ListarEmpleadosDestacados()
BEGIN
  SELECT e.idEmpleado, e.nombre, SUM(a.horasTrabajadas) AS TotalHoras
  FROM Empleado e
  LEFT JOIN Asignacion a ON e.idEmpleado = a.idEmpleado
  GROUP BY e.idEmpleado
  HAVING TotalHoras > PromedioHorasGlobal();
END$$
DELIMITER ;

	#Verificación del correcto funcionamiento
    CALL ListarEmpleadosDestacados();

#Trigger: Registrar cambios de productividad
DELIMITER $$
CREATE TRIGGER CambiosProductividad
AFTER INSERT ON Asignacion
FOR EACH ROW
BEGIN
  DECLARE total INT;
  DECLARE prom DECIMAL(10,2);
  #Total de horas por empleado
  SELECT SUM(horasTrabajadas)
  INTO total
  FROM Asignacion
  WHERE idEmpleado = NEW.idEmpleado;
  #Promedio global
  SET prom = PromedioHorasGlobal();
  #Registrar en historial
  INSERT INTO HistorialProductividad (idEmpleado, total_horas, promedio_global)
  VALUES (NEW.idEmpleado, total, prom);
END$$
DELIMITER ;

#Transacción: Revertir si horas < 0
DELIMITER $$
CREATE PROCEDURE InsertarAsignacionConValidacion(
    IN p_id_empleado INT,
    IN p_id_proyecto INT,
    IN p_horas INT
)
BEGIN
  START TRANSACTION;
  IF p_horas < 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Rollback: no se pueden registrar horas negativas';
  ELSE
    INSERT INTO Asignacion (idEmpleado, idProyecto, horasTrabajadas)
    VALUES (p_id_empleado, p_id_proyecto, p_horas);
    COMMIT;
  END IF;
END$$
DELIMITER ;