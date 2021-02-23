--Creating UNIQUE INDEX
---DIMENSION TIEMPO---
--tabla: años
CREATE UNIQUE INDEX años_idx ON años("años");
--tabla: meses
CREATE UNIQUE INDEX meses_idx ON meses(mes_id);
--table: semanaas
CREATE UNIQUE INDEX semanas_idx ON semanas(semana_id);
--table: dia
CREATE UNIQUE INDEX dias_idx ON dia(dia_id);
--table: horas
CREATE UNIQUE INDEX horas_idx ON horas(hora_id);

---DIMENSION CLIENTE---
--table: clientes
CREATE UNIQUE INDEX clientes_idx ON clientes(cliente_id);


---DIMENSION EMPLEADO---
--table: empleados
CREATE UNIQUE INDEX empleados_idx ON empleados(empleado_id);


---DIMENSION PROMOCION---
--table: promocion
CREATE UNIQUE INDEX promociones_idx ON promocion("promoción_id");


---DIMENSION GEOGRAFIA---
--tabla: estados
CREATE UNIQUE INDEX estados_idx ON estados(estado_id);

--talba:tienda
CREATE UNIQUE INDEX tiendas_idx ON tienda(tienda_id);

---HECHOS---
CREATE UNIQUE INDEX hechos_idx ON hechos(venta);