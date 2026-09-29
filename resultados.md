# Resultados de las consultas – Blockbuster Reborn

Salidas obtenidas al ejecutar `2_consultas.sql` en MySQL Workbench sobre los datos de prueba de `1_esquema_y_datos.sql`.

## Reporte 1: Ticket de compra completo (INNER JOIN)

```sql
SELECT renta.fechaRenta, cliente.nombreCompleto, pelicula.titulo, genero.nombreGenero
FROM renta
INNER JOIN cliente ON renta.idCliente = cliente.idCliente
INNER JOIN detalleRenta ON renta.idRenta = detalleRenta.idRenta
INNER JOIN pelicula ON detalleRenta.idPelicula = pelicula.idPelicula
INNER JOIN genero ON pelicula.idGenero = genero.idGenero;
```

| fechaRenta | nombreCompleto | titulo | nombreGenero |
|---|---|---|---|
| 2026-01-10 | María Camila Gómez | Star Wars I | Ciencia Ficción |
| 2026-01-10 | María Camila Gómez | Godzilla 2000 | Aventura |
| 2026-02-12 | Andrés Felipe Martínez | Harry Potter 3 | Fantasía |

Solo aparecen las rentas "perfectas". La renta 3 (express) queda fuera porque no tiene cliente registrado, y la renta 4 (kiosko) queda fuera porque no tiene películas en `detalleRenta`. La renta 1 aparece dos veces porque incluye dos películas.

## Reporte 2: Seguimiento de clientes (LEFT JOIN)

```sql
SELECT cliente.nombreCompleto, renta.idRenta
FROM cliente
LEFT JOIN renta ON cliente.idCliente = renta.idCliente;
```

| nombreCompleto | idRenta |
|---|---|
| María Camila Gómez | 1 |
| Andrés Felipe Martínez | 2 |
| Laura Valentina Palacio | NULL |
| Tanaka Masahiro | 4 |
| Santiago Díaz Jaramillo | NULL |

Aparecen los 5 clientes registrados. Laura Valentina Palacio y Santiago Díaz Jaramillo no han rentado, por eso su `idRenta` es NULL. La renta 3 (express) no aparece porque no pertenece a ningún cliente.

## Reporte 3: Auditoría del catálogo (RIGHT JOIN)

```sql
SELECT pelicula.titulo, detalleRenta.idDetalle
FROM detalleRenta
RIGHT JOIN pelicula ON detalleRenta.idPelicula = pelicula.idPelicula;
```

| titulo | idDetalle |
|---|---|
| Star Wars I | 1 |
| Godzilla 2000 | 2 |
| Harry Potter 3 | 3 |
| Top Gun Maverick | 4 |
| Ford vs Ferrari | NULL |

Aparecen las 5 películas del catálogo. *Ford vs Ferrari* nunca ha sido rentada, por eso su `idDetalle` es NULL: es la película estancada en los estantes.

## Reporte 4: Rendimiento total (FULL OUTER JOIN emulado con UNION)

```sql
SELECT empleado.nombreEmpleado, renta.idRenta
FROM empleado
LEFT JOIN renta ON empleado.idEmpleado = renta.idEmpleado
UNION
SELECT empleado.nombreEmpleado, renta.idRenta
FROM empleado
RIGHT JOIN renta ON empleado.idEmpleado = renta.idEmpleado;
```

| nombreEmpleado | idRenta |
|---|---|
| Ciro Alfonso Guerra | 1 |
| Cristina Gallego | 2 |
| Natalia Reyes Gaitán | 3 |
| Juan Pablo Raba Vidal | NULL |
| Víctor Gaviria | NULL |
| NULL | 4 |

El resultado concilia ambos lados. El `LEFT JOIN` aporta a Juan Pablo Raba Vidal y Víctor Gaviria, empleados sin ventas (`idRenta` NULL), y el `RIGHT JOIN` aporta la renta 4, hecha en kiosko sin empleado (`nombreEmpleado` NULL). `UNION` elimina las filas repetidas que ambas consultas tienen en común.
