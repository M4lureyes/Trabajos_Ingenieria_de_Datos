create database BDPruebas;
USE BDPruebas;

CREATE TABLE Cliente(
	documentoCliente VARCHAR(50) PRIMARY KEY,
    nombreCliente1 VARCHAR(50) NOT NULL,
    nombreCliente2 VARCHAR(50) NULL,
	apellidoCliente1 VARCHAR(50) NOT NULL,
    apellidoCliente2 VARCHAR(50) NULL,
	direccionCliente VARCHAR(50) NOT NULL
);

CREATE TABLE Telefono(
	idTelefono INT PRIMARY KEY AUTO_INCREMENT,
    telefono VARCHAR(25) NOT NULL,
    documentoClienteFK VARCHAR(50) NOT NULL
);

CREATE TABLE Mascota(
	idMascota INT PRIMARY KEY AUTO_INCREMENT,
    nombreMascota VARCHAR(50) NOT NULL,
    raza VARCHAR(25) NOT NULL,
    generoMascota VARCHAR(25) NOT NULL,
    tipoMascota VARCHAR(25) NOT NULL,
    fechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    documentoClienteFK VARCHAR(50) NOT NULL
);

CREATE TABLE Vacunas(
	codVacuna INT PRIMARY KEY,
    dosis VARCHAR(50) NOT NULL,
    nombreVac VARCHAR(50) NOT NULL,
    enfermedad VARCHAR(50) NOT NULL
);

CREATE TABLE Producto(
	codigoBarras VARCHAR(25) PRIMARY KEY,
    nombreProd VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE Venta(
	idVenta INT PRIMARY KEY AUTO_INCREMENT,
    documentoClienteFK VARCHAR(50) NOT NULL
);

CREATE TABLE DetalleVenta(
	idDetalleVenta INT PRIMARY KEY AUTO_INCREMENT,
    idVentaFK INT NOT NULL,
    codBarrasFK VARCHAR(25) NOT NULL
);

CREATE TABLE VacunaMascota(
	idVacunaMascota INT PRIMARY KEY AUTO_INCREMENT,
	idMascotaFK INT NOT NULL,
    codVacunaFK INT NOT NULL
);

ALTER TABLE Telefono
ADD CONSTRAINT fk_telefono_cliente
FOREIGN KEY (documentoClienteFK)
REFERENCES Cliente(documentoCliente);

ALTER TABLE Mascota
ADD CONSTRAINT fk_cliente_mascota
FOREIGN KEY (documentoClienteFK)
REFERENCES Cliente(documentoCliente);

ALTER TABLE Venta
ADD CONSTRAINT fk_venta_cliente
FOREIGN KEY (documentoClienteFK)
REFERENCES Cliente(documentoCliente);

ALTER TABLE DetalleVenta
ADD CONSTRAINT fk_detalleventa_venta
FOREIGN KEY (idVentaFK)
REFERENCES Venta(idVenta);

ALTER TABLE DetalleVenta
ADD CONSTRAINT fk_detalleventa_producto
FOREIGN KEY (codBarrasFK)
REFERENCES Producto(codigoBarras);

ALTER TABLE VacunaMascota
ADD CONSTRAINT fk_vacunaMascota_mascota
FOREIGN KEY (idMascotaFK)
REFERENCES Mascota(idMascota);

ALTER TABLE VacunaMascota
ADD CONSTRAINT fk_vacunaMascota_vacuna
FOREIGN KEY (codVacunaFK)
REFERENCES Vacunas(codVacuna);

/*INSERTS - CLIENTE*/
INSERT INTO Cliente VALUES ('C001', 'Ana', NULL, 'Ramírez', 'Gómez', 'Calle 10 #5-23');
INSERT INTO Cliente VALUES ('C002', 'Luis', 'Fernando', 'Pérez', NULL, 'Carrera 45 #12-09');
INSERT INTO Cliente VALUES ('C003', 'María', 'Isabel', 'Rodríguez', 'Díaz', 'Av. Siempre Viva 123');
INSERT INTO Cliente VALUES ('C004', 'Andrés', NULL, 'López', 'Martínez', 'Calle 8 #20-15');
INSERT INTO Cliente VALUES ('C005', 'Carolina', 'Sofía', 'García', 'Suárez', 'Carrera 7 #33-45');

/*INSERTS - TELEFONO*/
INSERT INTO Telefono (telefono, documentoClienteFK) VALUES ('3009991111', 'C001');
INSERT INTO Telefono (telefono, documentoClienteFK) VALUES ('3018882222', 'C002');
INSERT INTO Telefono (telefono, documentoClienteFK) VALUES ('3027773333', 'C003');
INSERT INTO Telefono (telefono, documentoClienteFK) VALUES ('3036664444', 'C004');
INSERT INTO Telefono (telefono, documentoClienteFK) VALUES ('3045555555', 'C005');

/*INSERTS - MASCOTA*/
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

/*INSERTS - VACUNAS*/
INSERT INTO Vacunas VALUES (1, '1ml', 'Antirrábica', 'Rabia');
INSERT INTO Vacunas VALUES (2, '0.5ml', 'Triple Felina', 'Leucemia Felina');
INSERT INTO Vacunas VALUES (3, '1ml', 'Moquillo', 'Distemper');
INSERT INTO Vacunas VALUES (4, '0.8ml', 'Parvovirus', 'Parvovirosis');
INSERT INTO Vacunas VALUES (5, '1ml', 'Hepatitis', 'Adenovirus Canino');

/*INSERTS - PRODUCTO*/
INSERT INTO Producto VALUES ('P001', 'Collar', 'PetLovers', 25000);
INSERT INTO Producto VALUES ('P002', 'Juguete de Goma', 'HappyPets', 15000);
INSERT INTO Producto VALUES ('P003', 'Comida Perro 5kg', 'DogChow', 80000);
INSERT INTO Producto VALUES ('P004', 'Comida Gato 3kg', 'CatPro', 60000);
INSERT INTO Producto VALUES ('P005', 'Shampoo Antipulgas', 'PetClean', 30000);

/*INSERTS - VENTA*/
INSERT INTO Venta (documentoClienteFK) VALUES ('C001');
INSERT INTO Venta (documentoClienteFK) VALUES ('C002');
INSERT INTO Venta (documentoClienteFK) VALUES ('C003');
INSERT INTO Venta (documentoClienteFK) VALUES ('C004');
INSERT INTO Venta (documentoClienteFK) VALUES ('C005');

/*INSERTS - DETALLEVENTA*/
INSERT INTO DetalleVenta (idVentaFK, codBarrasFK) VALUES (1, 'P001');
INSERT INTO DetalleVenta (idVentaFK, codBarrasFK) VALUES (1, 'P003');
INSERT INTO DetalleVenta (idVentaFK, codBarrasFK) VALUES (2, 'P002');
INSERT INTO DetalleVenta (idVentaFK, codBarrasFK) VALUES (3, 'P004');
INSERT INTO DetalleVenta (idVentaFK, codBarrasFK) VALUES (4, 'P005');

/*INSERTS - VACUNAMASCOTA*/
INSERT INTO VacunaMascota (idMascotaFK, codVacunaFK) VALUES (1, 1);
INSERT INTO VacunaMascota (idMascotaFK, codVacunaFK) VALUES (1, 3);
INSERT INTO VacunaMascota (idMascotaFK, codVacunaFK) VALUES (2, 2);
INSERT INTO VacunaMascota (idMascotaFK, codVacunaFK) VALUES (3, 4);
INSERT INTO VacunaMascota (idMascotaFK, codVacunaFK) VALUES (5, 5);
