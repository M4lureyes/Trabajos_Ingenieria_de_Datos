CREATE DATABASE ventasTienda;

USE ventasTienda;

CREATE TABLE cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    documentoCliente VARCHAR(50) NOT NULL,
    nombreCliente VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    telefono VARCHAR(50),
    fechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DESCRIBE cliente;
ALTER TABLE cliente ADD direccionCliente VARCHAR(20);
ALTER TABLE cliente MODIFY telefono VARCHAR(15) NOT NULL;
ALTER TABLE cliente DROP COLUMN direccionCliente;
ALTER TABLE cliente CHANGE email emailCliente VARCHAR(50) UNIQUE;

CREATE TABLE pedido(
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idClienteFK INT,
    fechaPedido DATE,
    totalPedido DECIMAL(10, 2),
    FOREIGN KEY (idClienteFK) REFERENCES cliente(idCliente)
);

ALTER TABLE pedido
ADD CONSTRAINT FKclientepedido
FOREIGN KEY (idClienteFK)
REFERENCES cliente(idCliente);

CREATE TABLE usuario(
	idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(50) NOT NULL,
    tipoUsuario VARCHAR(25) NOT NULL
);

CREATE TABLE detallePedido(
	idDetallePedido INT AUTO_INCREMENT PRIMARY KEY,
    monto VARCHAR(50) NOT NULL,
    idPedidoFK INT,
    FOREIGN KEY (idPedidoFK) REFERENCES pedido(idPedido)
);
DESCRIBE detallePedido;
CREATE TABLE producto(
	idProducto INT AUTO_INCREMENT PRIMARY KEY,
    tipoProducto VARCHAR(50) NOT NULL,
    marca VARCHAR(25) NOT NULL,
    idDetallePedidoFK INT,
    FOREIGN KEY (idDetallePedidoFK) REFERENCES detallePedido(idDetallePedido)
);
ALTER TABLE cliente ADD idUsuarioFK VARCHAR(50) NOT NULL;

DROP TABLE cliente;
