/* DDL create-alter-drop-truncate-rename */
/* Crear BD */
Create database BDMascotas;
/* Drop BD */
drop database BDMascotas;
/* Habilitar la BD */
USE bdmascotas;
/* Creación de tablas: nombre tabla, atributos, restricciones, relación */
CREATE TABLE Mascota(
	idMascota INT PRIMARY KEY AUTO_INCREMENT,
    nombreMascota VARCHAR(50) NOT NULL,
    raza VARCHAR(25) NOT NULL,
    generoMascota VARCHAR(25) NOT NULL,
    tipoMascota VARCHAR(25) NOT NULL,
    fechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
/* describe */
DESCRIBE mascota;

CREATE TABLE Cliente(
	documentoCliente VARCHAR(50) PRIMARY KEY,
    nombreCliente1 VARCHAR(50) NOT NULL,
    nombreCliente2 VARCHAR(50) NULL,
	apellidoCliente1 VARCHAR(50) NOT NULL,
    apellidoCliente2 VARCHAR(50) NULL,
	direccionCliente VARCHAR(25) NOT NULL,
    telefonoFK VARCHAR(50) NOT NULL
);

DESCRIBE Cliente;

/* Alteraciones */
ALTER TABLE Mascota ADD COLUMN documentoClienteFK VARCHAR(50) NOT NULL;
ALTER TABLE Mascota MODIFY COLUMN documentoClienteFK INT;

/* Relaciones */
ALTER TABLE Mascota
ADD CONSTRAINT FKClienteMascota
FOREIGN KEY (documentoClienteFK)
REFERENCES Cliente(documentoCliente);

CREATE TABLE Vacunas(
	codVacuna INT PRIMARY KEY,
    dosis VARCHAR(50) NOT NULL,
    nombreVac VARCHAR(50) NOT NULL,
    enfermedad VARCHAR(50) NOT NULL
);

CREATE TABLE Producto(
	codigoBarrras VARCHAR(25) PRIMARY KEY,
    nombreProd VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    precio VARCHAR(50) NOT NULL
);

CREATE TABLE Venta(
	idVenta INT PRIMARY KEY NOT NULL,
    idDetalleVentaFK VARCHAR(25),
    documentoClienteFK VARCHAR(25)
);

DESCRIBE Venta;

ALTER TABLE Venta
ADD CONSTRAINT fkVenta_cliente_Cliente
FOREIGN KEY (documentoClienteFK)
REFERENCES Cliente(documentoCliente);

ALTER TABLE Venta
ADD CONSTRAINT fkVenta_cliente_D
FOREIGN KEY (idDetalleVentaFK)
REFERENCES DetalleVenta(idDetalleVenta);

CREATE TABLE DetalleVenta(
	idDetalleVenta INT PRIMARY KEY NOT NULL,
    idVentafk INT,
    CodBarrasfk VARCHAR (25)
);

DESCRIBE DetalleVenta;

ALTER TABLE DetalleVenta
ADD CONSTRAINT fk_detalleVenta_venta
FOREIGN KEY (idVentafk)
REFERENCES Venta(idVenta);

ALTER TABLE DetalleVenta
ADD CONSTRAINT fk_detalleVenta_producto
FOREIGN KEY (CodBarrasfk)
REFERENCES Producto(codigoBarras);

CREATE TABLE Telefono(
	idTelefono INT PRIMARY KEY NOT NULL,
    telefono VARCHAR(25),
    documentoClientefk VARCHAR(25)
    );
    
ALTER TABLE Telefono
ADD CONSTRAINT fk_telefono_cliente
FOREIGN KEY (documentoClientefk)
REFERENCES Cliente(documentoCliente);

CREATE TABLE VacunaMascota(
	idVacunaMascota INT PRIMARY KEY NOT NULL,
	idMascotaFK VARCHAR(25),
    codVacunaFK VARCHAR (25)
);

ALTER TABLE VacunaMascota
ADD CONSTRAINT fk_vacunaMascota_mascota
FOREIGN KEY (idMascotaFK)
REFERENCES Mascota(idMascota);

ALTER TABLE VacunaMascota
ADD CONSTRAINT fk_vacunaMascota_vacuna
FOREIGN KEY (idVacunaFK)
REFERENCES Vacunas(codVacuna);

/*insert into (nombreTable) (campos) values(valor1, valor2)*/
/*inser into (nombreTabla) values values (valor1, valor2*/

INSERT INTO Cliente VALUES ('C001', 'Ana', NULL, 'Ramírez', 'Gómez', 'Calle 10 #5-23', '3001112233');
INSERT INTO Cliente VALUES ('C002', 'Luis', 'Fernando', 'Pérez', NULL, 'Carrera 45 #12-09', '3102223344');
INSERT INTO Cliente VALUES ('C003', 'María', 'Isabel', 'Rodríguez', 'Díaz', 'Av. Siempre Viva 123', '3203334455');
INSERT INTO Cliente VALUES ('C004', 'Andrés', NULL, 'López', 'Martínez', 'Calle 8 #20-15', '3014445566');
INSERT INTO Cliente VALUES ('C005', 'Carolina', 'Sofía', 'García', 'Suárez', 'Carrera 7 #33-45', '3155556677');

INSERT INTO Mascota(nombreMascota, raza, generoMascota, tipoMascota, documentoClienteFK) 
VALUES ('Firulais', 'Labrador', 'Macho', 'Perro', 'C001');
INSERT INTO Mascota(nombreMascota, raza, generoMascota, tipoMascota, documentoClienteFK) 
VALUES ('Misu', 'Siames', 'Hembra', 'Gato', 'C002');
INSERT INTO Mascota(nombreMascota, raza, generoMascota, tipoMascota, documentoClienteFK) 
VALUES ('Rocky', 'Bulldog', 'Macho', 'Perro', 'C003');
INSERT INTO Mascota(nombreMascota, raza, generoMascota, tipoMascota, documentoClienteFK) 
VALUES ('Luna', 'Persa', 'Hembra', 'Gato', 'C004');
INSERT INTO Mascota(nombreMascota, raza, generoMascota, tipoMascota, documentoClienteFK) 
VALUES ('Max', 'Golden Retriever', 'Macho', 'Perro', 'C005');

INSERT INTO Vacunas VALUES (1, '1ml', 'Antirrábica', 'Rabia');
INSERT INTO Vacunas VALUES (2, '0.5ml', 'Triple Felina', 'Leucemia Felina');
INSERT INTO Vacunas VALUES (3, '1ml', 'Moquillo', 'Distemper');
INSERT INTO Vacunas VALUES (4, '0.8ml', 'Parvovirus', 'Parvovirosis');
INSERT INTO Vacunas VALUES (5, '1ml', 'Hepatitis', 'Adenovirus Canino');

INSERT INTO Producto VALUES ('P001', 'Collar', 'PetLovers', '25000');
INSERT INTO Producto VALUES ('P002', 'Juguete de Goma', 'HappyPets', '15000');
INSERT INTO Producto VALUES ('P003', 'Comida Perro 5kg', 'DogChow', '80000');
INSERT INTO Producto VALUES ('P004', 'Comida Gato 3kg', 'CatPro', '60000');
INSERT INTO Producto VALUES ('P005', 'Shampoo Antipulgas', 'PetClean', '30000');

INSERT INTO Venta VALUES (1, NULL, 'C001');
INSERT INTO Venta VALUES (2, NULL, 'C002');
INSERT INTO Venta VALUES (3, NULL, 'C003');
INSERT INTO Venta VALUES (4, NULL, 'C004');
INSERT INTO Venta VALUES (5, NULL, 'C005');

INSERT INTO DetalleVenta VALUES (1, 1, 'P001');
INSERT INTO DetalleVenta VALUES (2, 1, 'P003');
INSERT INTO DetalleVenta VALUES (3, 2, 'P002');
INSERT INTO DetalleVenta VALUES (4, 3, 'P004');
INSERT INTO DetalleVenta VALUES (5, 4, 'P005');

INSERT INTO Telefono VALUES (1, '3009991111', 'C001');
INSERT INTO Telefono VALUES (2, '3018882222', 'C002');
INSERT INTO Telefono VALUES (3, '3027773333', 'C003');
INSERT INTO Telefono VALUES (4, '3036664444', 'C004');
INSERT INTO Telefono VALUES (5, '3045555555', 'C005');

INSERT INTO VacunaMascota VALUES (1, 1, 1);
INSERT INTO VacunaMascota VALUES (2, 1, 3);
INSERT INTO VacunaMascota VALUES (3, 2, 2);
INSERT INTO VacunaMascota VALUES (4, 3, 4);
INSERT INTO VacunaMascota VALUES (5, 5, 5);

/* Consultas específicas */
/* Alias */
SELECT idMascota AS 'Código Mascota', nombreMascota AS 'Nombre Mascota' FROM Mascota;

#Condiciones operadores lógicos and, or, not operadores de copmaración <, >, <=, =>, =, !=, between, like, in
#Clausula de Bd Where
SELECT * FROM Cliente WHERE nombreCliente1 = 'Paula Vargas';

#Diferente != <>
SELECT * FROM Cliente WHERE nombreCliente1 != 'Paula Vargas';
SELECT * FROM Cliente WHERE nombreCliente1 <> 'Paula Vargas';

#Mayor que
SELECT * FROM Vacunas WHERE codVacuna < 2;

#Mayor o menor igual
SELECT * FROM Vacunas WHERE codVacuna >= 2;

#Between and
SELECT * FROM Vacunas WHERE codVacuna BETWEEN 2 AND 5;

/* Patron LIKE partrones de texto campos varchar, char, texto
	% -> Representa 0, 1 o muchos caracteres
    _ -> Representa un solo caracter
    Empiece por cierto caracter like xxxxx%
    Termine por cierto caracter like %xxxxx
    Contenga ciertos caracteres like %xxxxx%
    Un caracter like x-X
*/

SELECT * FROM Mascota WHERE nombreMascota LIKE 'In%';
SELECT * FROM Mascota WHERE nombreMascota LIKE '%ica';
SELECT * FROM Mascota WHERE nombreMascota LIKE '%a%';
SELECT * FROM Mascota WHERE nombreMascota LIKE '%ica';
SELECT * FROM Mascota WHERE nombreMascota LIKE 'i_I';

#IN valor IN(valor1, valor2, valor3,...)
SELECT * FROM Vacunas WHERE codVacuna IN (2, 3, 4);
SELECT * FROM Mascota WHERE nombreMascota IN ('Luna');

#AND, OR, NOT SELECT * FROM nombreTabla WHERE valor = valorComparacion AND valor = valorComparacion
SELECT * FROM Mascota WHERE nombreMascota = 'Luna' AND idMascota = 4;
SELECT * FROM Mascota WHERE nombreMascota = 'Luna' OR idMascota = 4;
SELECT * FROM Mascota WHERE NOT nombreMascota = 'Luna';

#Ordenar asc desc SELECT campo1, campo2 FROM nombreTabla ORDER BY campoOrdenar ASC/DESC
SELECT * FROM Cliente ORDER BY nombreCliente1, nombreCliente2 ASC;

/* Agrupar normalmente se acompaña de funciones calculadas o de agregacion
	count() contar registros
    sum() sumar
    avg() promedio
    max() maximo
    min() minimo
    select *  from columna, funcionAgregacion() FROM tabla GROUP BY campo
*/ 
SELECT * FROM Mascota GROUP BY raza;

/* FUNCIONES AGREGADAS
Nos sirve para analisis estadistico
Super importante
COUNT() -> contar registros (filas)
AVG() -> calcula promedio
MIN() -> obtiene el valor minimo
MAX() -> obtiene el valor maximo
siempre van a devolver un unico valor agrupado
procurar siempre usar alias
SELECT COUNT(*) AS 'aliasName' FROM table;
SELECT [MAX/MIN](field) AS 'aliasName' FROM table;
*/

SELECT COUNT(*) AS 'Número mascotas' FROM Mascota;
SELECT MAX(precio) AS 'Máximo precio' FROM Producto;
SELECT MIN(precio) AS 'Mínimo precio' FROM Producto;

#sum() SELECT SUM(campo) AS nombreAlias FROM tabla
SELECT SUM(precio) AS 'Precio Total' FROM Producto;

SELECT * FROM Producto;

#avg SELECT AVG(campo) AS nombreAlias FROM tabla
SELECT AVG(precio) AS 'Promedio Precio' FROM Producto;

/* SELECT AVG(campo) AS nombreAlias 
FROM tabla 
GROUP BY campoAgrupar 
HAVING AVG(campo) > xx: */
SELECT marca, AVG(precio) AS 'Promedio Precio'
FROM Producto
GROUP BY marca
HAVING AVG(precio) > 30000;

/* SELECT carrera, AVG(semestre) AS 'Promedio Semestre'
FROM estudiantes
GROUP BY carrera
HAVING AVG(semestre) > 3; */

SELECT marca, COUNT(precio) AS 'Promedio Precio'
FROM Producto
GROUP BY marca
HAVING AVG(precio) > 30000;

/* Subconsulta y consultas multitabla 
	Se ejecuta la subconsulta y luego la consulta principal
    Escalates: Devuelven un solo valor
    De Fila: Devuelven un registro (fila) completo
    De Tabla: Devuelven varios registros (varias filas)
*/

/* Consultas multitabla 
	Inner Join
    Left Join
    Right Join
    Full Join - JOIN UNION, JOIN
*/

/* Modificaciones update sintaxis:
UPDATE nombreTabla SET campovalor, campo1 = valor1 WHERE condicion */
SELECT * FROM Mascota;
UPDATE Mascota SET nombreMascota = "Milu" WHERE idMascota = 7;
UPDATE Mascota SET nombreMascota = "Maximo" WHERE idMascota = 9;
UPDATE Mascota SET nombreMascota = "Melody" WHERE idMascota = 3;

/* DELETE eliminar
sintaxis: DELETE FROM nombreTabla WHERE condicion BEGIN ROLLBACK COMMIT*/
DELETE FROM Mascota WHERE idMascota = 6;
SELECT * FROM Mascota;

START TRANSACTION;
DELETE FROM Mascota WHERE idMascota = 7;
COMMIT;
SELECT * FROM Mascota;

START TRANSACTION;
DELETE FROM Mascota WHERE idMascota = 7;
ROLLBACK;
SELECT * FROM Mascota;

SHOW PROCESSLIST;
SELECT * FROM information_schema.innodb_trx;
SHOW BINARY LOGS;

/* Views - triggers - procedimientos almacenados 
CREATE VIEW nombreVista AS campos FROM tabla WHERE condicion;
SELECT * FROM nombreVista;
*/
CREATE VIEW VistaMascota AS SELECT M.generoMascota AS 'Raza Mascota', M.tipoMascota AS 'Tipo Mascota' FROM Mascota M;
SELECT * FROM VistaMascota;
CREATE VIEW VistaDatosCliente AS SELECT * FROM Cliente C INNER JOIN Mascota M ON C.documentoCliente = M.documentoClienteFK;
SELECT * FROM VistaDatosCliente;
