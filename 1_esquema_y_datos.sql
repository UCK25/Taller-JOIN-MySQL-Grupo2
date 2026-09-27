-- Tienda Blockbuster Reborn

DROP DATABASE IF EXISTS blockbusterReborn;

-- Base de dato Blockbuster Reborn

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

-- Insertar datos

INSERT INTO sucursal (nombreSucursal)
VALUES 
('Sucursal norte'),
('Sucursal centro'),
('Sucursal sur');

INSERT INTO cliente (nombreCompleto, correoElectronico)
VALUES
('María Camila Gómez', 'mcamilag@email.com'),
('Andrés Felipe Martínez', 'afelipem@email.com'),
('Laura Valentina Palacio', 'lvalentinap@email.com'),
('Tanaka Masahiro', 'tanakam@email.com'),
('Santiago Díaz Jaramillo', 'sdiazj@email.com');

INSERT INTO genero (nombreGenero)
VALUES
('Ciencia Ficción'),
('Aventura'),
('Fantasía'),
('Acción'),
('Drama');

INSERT INTO pelicula (titulo, anioEstreno, idGenero)
VALUES
('Star Wars I', 1999, 1),
('Godzilla 2000', 2000, 2),
('Harry Potter 3', 2004, 3),
('Top Gun Maverick', 2022, 4),
('Ford vs Ferrari', 2019, 5);

INSERT INTO empleado (nombreEmpleado, idSucursal)
VALUES
('Ciro Alfonso Guerra', 1),
('Cristina Gallego', 2),
('Natalia Reyes Gaitán', 3),
('Juan Pablo Raba Vidal', 1),
('Víctor Gaviria', 2);

INSERT INTO renta (fechaRenta, idCliente, idEmpleado)
VALUES
('2026-01-10', 1, 1),
('2026-02-12', 2, 2),
('2026-04-15', NULL, 3), -- renta express
('2026-08-18', 4, NULL); -- renta kiosko

INSERT INTO detalleRenta (idRenta, idPelicula)
VALUES
(1, 1),   -- renta 1, Star Wars I
(1, 2),   -- renta 1, Godzilla 2000
(2, 3),   -- renta 2, Harry Potter 3
(3, 4);   -- renta 3(express), Top Gun Maverick