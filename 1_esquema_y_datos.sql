-- Tienda Blockbuster Reborn

CREATE DATABASE blockbusterReborn;
USE blockbusterReborn;

CREATE TABLE sucursal (
idSucursal INT AUTO_INCREMENT PRIMARY KEY,
nombreSucursal VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
idCliente INT AUTO_INCREMENT PRIMARY KEY,
nombreCompleto VARCHAR(100) NOT NULL,
correoElectronico VARCHAR(100) NOT NULL
);

CREATE TABLE genero (
idGenero INT AUTO_INCREMENT PRIMARY KEY,
nombreGenero VARCHAR(100) NOT NULL
);

CREATE TABLE empleado (
idEmpleado INT AUTO_INCREMENT PRIMARY KEY,
nombreEmpleado VARCHAR(100) NOT NULL,
idSucursal INT NOT NULL,
FOREIGN KEY (idSucursal) REFERENCES sucursal(idSucursal)
);

CREATE TABLE renta (
idRenta INT AUTO_INCREMENT PRIMARY KEY,
fechaRenta DATE NOT NULL,
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
idEmpleado INT,
FOREIGN KEY (idEmpleado) REFERENCES empleado(idEmpleado)
);

CREATE TABLE pelicula (
idPelicula INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
anioEstreno INT NOT NULL,
idGenero INT NOT NULL,
FOREIGN KEY (idGenero) REFERENCES genero(idGenero)
);

CREATE TABLE detalleRenta (
idDetalle INT AUTO_INCREMENT PRIMARY KEY,
idRenta INT NOT NULL,
FOREIGN KEY (idRenta) REFERENCES renta(idRenta),
idPelicula INT,
FOREIGN KEY (idPelicula) REFERENCES pelicula(idPelicula)
);