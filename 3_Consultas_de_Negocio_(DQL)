USE blockbusterReborn;

-- Reporte 1: El ticket de compra completo (INNER JOIN)
-- Solo rentas con cliente registrado y película válida en el detalle
SELECT renta.fechaRenta, cliente.nombreCompleto, pelicula.titulo, genero.nombreGenero
FROM renta
INNER JOIN cliente ON renta.idCliente = cliente.idCliente
INNER JOIN detalleRenta ON renta.idRenta = detalleRenta.idRenta
INNER JOIN pelicula ON detalleRenta.idPelicula = pelicula.idPelicula
INNER JOIN genero ON pelicula.idGenero = genero.idGenero;

-- Reporte 2: Seguimiento de clientes (LEFT JOIN)
-- Todos los clientes aparecen; si no han rentado, idRenta es NULL
SELECT cliente.nombreCompleto, renta.idRenta
FROM cliente
LEFT JOIN renta ON cliente.idCliente = renta.idCliente;

-- Reporte 3: Auditoría del catálogo (RIGHT JOIN)
-- Todas las películas aparecen; si no se han rentado, idDetalle es NULL
SELECT pelicula.titulo, detalleRenta.idDetalle
FROM detalleRenta
RIGHT JOIN pelicula ON detalleRenta.idPelicula = pelicula.idPelicula;

-- Reporte 4: Rendimiento total (FULL OUTER JOIN)
-- MySQL no soporta FULL OUTER JOIN de forma nativa, por lo que se emula con UNION de un LEFT JOIN (empleados sin ventas)
-- y un RIGHT JOIN (rentas sin empleado, como las de kiosko)
SELECT empleado.nombreEmpleado, renta.idRenta
FROM empleado
LEFT JOIN renta ON empleado.idEmpleado = renta.idEmpleado
UNION
SELECT empleado.nombreEmpleado, renta.idRenta
FROM empleado
RIGHT JOIN renta ON empleado.idEmpleado = renta.idEmpleado;
