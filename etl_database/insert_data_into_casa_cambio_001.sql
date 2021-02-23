insert into años (año) values (2018);
insert into años (año) values (2019);
insert into años (año) values (2020);


\copy meses(mes_id,mes_desc,"año") FROM '/almac/alumno03_db/from_Alfonso/meses.csv' WITH (FORMAT CSV, HEADER);

\copy semanas(semana_id,semana_desc,mes_id) FROM '/almac/alumno03_db/from_Alfonso/semanas.csv' WITH (FORMAT CSV, HEADER);

\copy dia(dia_id,fecha,semana_id) FROM '/almac/alumno03_db/from_Alfonso/dias.csv' WITH (FORMAT CSV, HEADER);

\copy horas(hora_id,hora_desc,dia_id) FROM '/almac/alumno03_db/from_Alfonso/horas.csv' WITH (FORMAT CSV, HEADER);

\copy clientes(cliente_id,nombre,apellido_pat,apellido_mat) FROM '/almac/alumno03_db/from_Alfonso/clientes.csv' WITH (FORMAT CSV, HEADER);

\copy empleados(empleado_id,nombre,apellido_pat,apellido_mat) FROM '/almac/alumno03_db/from_Alfonso/empleados.csv' WITH (FORMAT CSV, HEADER);

\copy promocion("promoción_id", promocion_desc) FROM '/almac/alumno03_db/from_Alfonso/promocion.csv' WITH (FORMAT CSV, HEADER);

\copy estados(estado_id,estado_desc) FROM '/almac/alumno03_db/from_Alfonso/estados.csv' WITH (FORMAT CSV, HEADER);

\copy tienda(tienda_id,tienda_desc,estado_id) FROM '/almac/alumno03_db/from_Alfonso/tiendas.csv' WITH (FORMAT CSV, HEADER);

\copy public.hechos(venta,hora_id,cliente_id,empleado_id,tienda_id, promoción_id,precio_de_venta_por_unidad,unidades_vendidas,ganancia_por_unidad) FROM '/almac/alumno08_db/from_oswald/hechos_short.csv' WITH (FORMAT CSV, HEADER);