CREATE DATABASE TechCorp;

USE TechCorp;

CREATE TABLE Empleado(
	idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nombreEmpleado VARCHAR(50) NOT NULL,
    edadEmpleado INT NOT NULL,
    salarioEmpleado FLOAT(10, 2) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    fechaContratacion DATE
);

INSERT INTO Empleado (nombreEmpleado, edadEmpleado, salarioEmpleado, departamento, fechaContratacion)
VALUES ('Ana Torres', 28, 3500.00, 'IT', '2019-05-14'),
	('Carlos Pérez', 34, 4200.50, 'Ventas', '2021-03-22'),
	('María Gómez', 41, 5000.75, 'Recursos Humanos', '2018-07-10'),
	('Andrés Rodríguez', 29, 2800.00, 'IT', '2022-01-05'),
	('Carmen Díaz', 37, 4500.20, 'Ventas', '2020-09-17'),
	('Luis Martínez', 32, 3900.00, 'Marketing', '2021-11-30'),
	('Natalia Suárez', 26, 3100.40, 'Soporte', '2023-06-25'),
	('Eduardo Ramírez', 45, 6000.99, 'Dirección', '2017-04-03'),
	('Camilo Herrera', 30, 4000.00, 'Ventas', '2022-08-12'),
	('Andrea López', 39, 4700.60, 'IT', '2019-10-21');

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
