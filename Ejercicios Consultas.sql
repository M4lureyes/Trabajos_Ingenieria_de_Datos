CREATE DATABASE TechCorp;

USE TechCorp;

CREATE TABLE Empleado(
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nombreEmpleado VARCHAR(50) NOT NULL,
    fechaNacimiento DATE,
    salarioEmpleado FLOAT(10, 2) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    fechaContratacion DATE,
    idDepartamentoFK INT NOT NULL
);

INSERT INTO Empleado (nombreEmpleado, fechaNacimiento, salarioEmpleado, fechaContratacion, idDepartamentoFK)
VALUES ('Ana Torres', '1995-04-20', 3500.00, '2019-05-14', 1),
	('Carlos Pérez', '1989-07-11', 4200.50, '2021-03-22', 2), 
	('María Gómez', '1982-03-03', 5000.75, '2018-07-10', 3), 
	('Andrés Rodríguez', '1994-08-15', 2800.00, '2022-01-05', 1), 
	('Carmen Díaz', '1986-12-22', 4500.20, '2020-09-17', 2), 
	('Luis Martínez', '1991-06-09', 3900.00, '2021-11-30', 4), 
	('Natalia Suárez', '1997-09-25', 3100.40, '2023-06-25', 5),
	('Eduardo Ramírez', '1978-01-30', 6000.99, '2017-04-03', 6),
	('Camilo Herrera', '1993-11-18', 4000.00, '2022-08-12', 2),
	('Andrea López', '1984-05-27', 4700.60, '2019-10-21', 1);

#Punto 1: Lista de empleados
SELECT nombreEmpleado, edadEmpleado, salarioEmpleado FROM Empleado;

#Punto 2: Altos ingresos
SELECT * FROM Empleado WHERE salarioEmpleado > 4000;

#Punto 3: Fuerza de ventas
SELECT * FROM Empleado WHERE departamento = 'Ventas';

#Punto 4: Rango de edad
SELECT * FROM Empleado WHERE edadEmpleado BETWEEN 30 AND 40;

#Punto 5: Nuevas contrataciones
SELECT * FROM Empleado WHERE YEAR(fechaContratacion) > 2020;

#Punto 6: Distribución empleados
SELECT departamento, COUNT(*) AS 'Total Empleados' FROM Empleado GROUP BY departamento;

#Punto 7: Análsis salarial
SELECT AVG(salarioEmpleado) AS 'Promedio Salarial' FROM Empleado;

#Punto 8: Nombres selectivos
SELECT * FROM Empleado WHERE nombreEmpleado LIKE 'A%';
SELECT * FROM Empleado WHERE nombreEmpleado LIKE 'C%';

#Punto 9: Departamentos específicos
SELECT * FROM Empleado WHERE NOT departamento = 'IT';

#Punto 10: El mejor pagado
SELECT MAX(salarioEmpleado) AS 'Salario más alto' FROM Empleado;
#Punto 10: Corregido
SELECT nombreEmpleado, salarioEmpleado
FROM Empleado
WHERE salarioEmpleado IN (SELECT MAX(salarioEmpleado) FROM Empleado);

CREATE TABLE Departamento(
	idDepartamento INT PRIMARY KEY AUTO_INCREMENT,
    nombreDepartamento VARCHAR(50) NOT NULL
);

ALTER TABLE Empleado
ADD CONSTRAINT fk_departamento
FOREIGN KEY (idDepartamentoFK)
REFERENCES Departamento(idDepartamento);

INSERT INTO Departamento (nombreDepartamento)
VALUES ('IT'),
       ('Ventas'),
       ('Recursos Humanos'),
       ('Marketing'),
       ('Soporte'),
       ('Dirección');

SELECT nombreEmpleado, nombreDepartamento
FROM Empleado
WHERE idDepartamentoFK IN (SELECT nombreDepartamento FROM Departamento WHERE nombreDepartamento = 'Ventas');

SELECT E.nombreEmpleado AS 'Empleado', D.nombreDepartamento AS 'Departamento'
FROM Empleado E
INNER JOIN Departamento D ON E.idDepartamentoFK = D.idDepartamento;

#Todos los empleados así no tengan un departamento asignado
SELECT E.nombreEmpleado AS 'Empleado', D.nombreDepartamento AS 'Departamento'
FROM Empleado E
LEFT JOIN Departamento D ON E.idDepartamentoFK = D.idDepartamento;

#Todos los departamentos que no tienen empleados asignados
SELECT E.nombreEmpleado AS 'Empleado', D.nombreDepartamento AS 'Departamento'
FROM Empleado E
RIGHT JOIN Departamento D ON E.idDepartamentoFK = D.idDepartamento;

#Punto 1: Consultar empleados cuyo salario sea mayor al salario promedio de la empresa
SELECT salarioEmpleado
FROM Empleado
WHERE salarioEmpleado > AVG(salarioEmpleado);

#Punto 2: Encuentre el nombre del empleado con el segundo salario más alto
SELECT nombreEmpleado, salarioEmpleado
FROM Empleado E
WHERE salarioEmpleado < MAX(salarioEMpleado);

#Punto 3: Utilizando LEFT JOIN muestre los departamentos que no tienen emepleados asignados
SELECT E.nombreEmpleado AS 'Empleado', D.nombreDepartamento AS 'Departamento'
FROM Empleado E
LEFT JOIN Departamento D ON D.idDepartamento = E.idDepartamentoFK;

#Punto 4: Muestre el total de empleados por cada departamento
SELECT COUNT(idDepartamento) AS 'Total Empleados' FROM Departamento GROUP BY nombreDepartamento;