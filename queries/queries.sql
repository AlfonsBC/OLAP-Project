----- COPIADO DE DATOS DESDE ARCHIVO:


\copy {TABLA}({COLUMNAS}) FROM {Ruta de acceso}  WITH (FORMAT CSV, HEADER)



--Consultas
-- ¿Cuál es el empleado que mas ha vendido en el presente año?


WITH hechos_sum AS(
SELECT empleado_id, SUM(unidades_vendidas) AS venta_total
FROM hechos
WHERE hora_id in (SELECT hora_id FROM horas
                        WHERE dia_id IN (SELECT dia_id FROM dia
                                        WHERE semana_id in (SELECT semana_id FROM semanas
                                                        WHERE mes_id in (SELECT mes_id FROM meses
                                                                            WHERE año=2020 ))))
GROUP BY empleado_id
), max_ventas AS (SELECT MAX(venta_total)
                 FROM hechos_sum )

SELECT nombre, apellido_pat, apellido_mat, venta_total
FROM hechos_sum hs INNER JOIN empleados e ON hs.empleado_id=e.empleado_id
WHERE venta_total in (SELECT * FROM max_ventas);


--¿Cuál es el empleado que mas ha vendido en el presente año? Lo mismo pero desglosado por mes.

WITH hechos_sum AS(
SELECT empleado_id, mes_desc, SUM(unidades_vendidas) AS venta_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
WHERE m.año=2019

GROUP BY empleado_id, mes_desc
), max_ventas AS (SELECT mes_desc, MAX(venta_total) AS max_venta
                 FROM hechos_sum GROUP BY mes_desc)

SELECT nombre, apellido_pat, apellido_mat, mes_desc, venta_total
FROM hechos_sum hs INNER JOIN empleados e ON hs.empleado_id=e.empleado_id
WHERE venta_total in (SELECT max_venta FROM max_ventas);


-- ¿En qué época del año se venden menos unidades de dólar?


WITH hechos_sum AS(
SELECT mes_desc, SUM(unidades_vendidas) AS venta_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
GROUP BY  mes_desc
)

SELECT  mes_desc, venta_total
FROM hechos_sum
ORDER BY venta_total ASC
LIMIT 10;


-- Ganancia de la venta de dólar a lo largo del año pasado


SELECT año, SUM(ganancia_por_unidad*unidades_vendidas) AS ganancia_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
WHERE m.año=2019
GROUP BY  año;




-- ¿Quien fue el cliente que mas ganancia ha dejado a la compañıa?

WITH hechos_sum AS (
    SELECT cliente_id, SUM(ganancia_por_unidad*unidades_vendidas) AS ganancia_total
    FROM hechos
    GROUP BY cliente_id
), max_ganancias AS (SELECT MAX(ganancia_total)
                 FROM hechos_sum )

SELECT nombre, apellido_pat, apellido_mat, ganancia_total
FROM clientes c INNER JOIN hechos_sum hs ON c.cliente_id=hs.cliente_id
WHERE ganancia_total in (SELECT * FROM max_ganancias);



-- ¿Quien es el cliente que mas compra dolares?

WITH hechos_sum AS (
    SELECT cliente_id, SUM(unidades_vendidas) AS venta_total
    FROM hechos
    GROUP BY cliente_id
), max_venta AS (SELECT MAX(venta_total)
                 FROM hechos_sum )

SELECT nombre, apellido_pat, apellido_mat, venta_total
FROM clientes c INNER JOIN hechos_sum hs ON c.cliente_id=hs.cliente_id
WHERE venta_total in (SELECT * FROM max_venta);



-- ¿Cuál es el mes que mas redituable del año pasado?


WITH hechos_sum AS(
SELECT  mes_desc, SUM(unidades_vendidas) AS venta_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
WHERE m.año=2019

GROUP BY  mes_desc
), max_ventas AS (SELECT  MAX(venta_total)
                 FROM hechos_sum)

SELECT mes_desc, venta_total
FROM hechos_sum hs
WHERE venta_total in (SELECT * FROM max_ventas);




-- ¿Cuál es el mes que mas redituable del año?


WITH hechos_sum AS(
SELECT  mes_desc, SUM(unidades_vendidas) AS venta_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
WHERE m.año=2020

GROUP BY  mes_desc
), max_ventas AS (SELECT  MAX(venta_total)
                 FROM hechos_sum)

SELECT mes_desc, venta_total
FROM hechos_sum hs
WHERE venta_total in (SELECT * FROM max_ventas);



-- ¿Cuál es la promoción que permitió vender mas dolares?
WITH hechos_sum AS(
SELECT  promoción_id, SUM(unidades_vendidas) AS venta_total
FROM hechos
GROUP BY promoción_id), max_ventas AS (SELECT  MAX(venta_total)
                 FROM hechos_sum)
SELECT promocion_desc, venta_total
FROM hechos_sum hs INNER JOIN promocion p ON p.promoción_id=hs.promoción_id
WHERE venta_total in (SELECT * FROM max_ventas);


--Ventas de la sucursal Saltillo a lo largo de los meses


WITH hechos_sum AS(
SELECT  tienda_id, mes_desc, m.mes_id, SUM(unidades_vendidas) AS venta_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
GROUP BY  tienda_id, mes_desc, m.mes_id
)
SELECT tienda_desc, mes_desc, venta_total
FROM hechos_sum hs INNER JOIN tienda t ON hs.tienda_id=t.tienda_id
WHERE tienda_desc='sucursal_saltillo'
ORDER BY mes_id ASC;


--Ganancia de estados a lo largo de los meses

WITH hechos_sum AS(
SELECT  estado_desc, mes_desc, m.mes_id, SUM(ganancia_por_unidad*unidades_vendidas) AS ganancia_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
INNER JOIN tienda t ON h.tienda_id=t.tienda_id
INNER JOIN estados e ON t.estado_id=e.estado_id
GROUP BY  estado_desc, mes_desc, m.mes_id
)
SELECT estado_desc, mes_desc, ganancia_total
FROM hechos_sum
ORDER BY mes_id ASC;




----------------CONSULTA PREDICTIVA EXPORTACIÓN DE DATOS----------------

CREATE TEMP VIEW v1 AS
WITH hechos_sum AS(
SELECT  tienda_id, mes_desc, m.mes_id, SUM(unidades_vendidas) AS venta_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
GROUP BY  tienda_id, mes_desc, m.mes_id
)
SELECT tienda_desc, mes_desc, venta_total
FROM hechos_sum hs INNER JOIN tienda t ON hs.tienda_id=t.tienda_id
WHERE tienda_desc='sucursal_saltillo'
ORDER BY mes_id ASC;

\copy (SELECT * FROM v1) TO '/almac/alumno08_db/to_oswald/consulta1.csv'  CSV HEADER ;


DROP VIEW v1;


-------------CONSULTA 2
CREATE TEMP VIEW v2 AS
WITH hechos_sum AS(
SELECT  estado_desc, mes_desc, m.mes_id, SUM(ganancia_por_unidad*unidades_vendidas) AS ganancia_total
FROM hechos h INNER JOIN horas ho ON h.hora_id=ho.hora_id
INNER JOIN dia d ON ho.dia_id=d.dia_id
INNER JOIN semanas s ON d.semana_id=s.semana_id
INNER JOIN meses m ON s.mes_id=m.mes_id
INNER JOIN tienda t ON h.tienda_id=t.tienda_id
INNER JOIN estados e ON t.estado_id=e.estado_id
GROUP BY  estado_desc, mes_desc, m.mes_id
)
SELECT estado_desc, mes_desc, ganancia_total
FROM hechos_sum
ORDER BY mes_id ASC;

\copy (SELECT * FROM v2) TO '/almac/alumno08_db/to_oswald/consulta2.csv'  CSV HEADER ;


DROP VIEW v2;
