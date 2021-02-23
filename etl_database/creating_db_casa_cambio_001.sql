---CASA DE CAMBIO



-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
--




-------------------- DIMENSION TIEMPO ---------------
-- Tabla años
-- DROP TABLE IF EXISTS public."años" CASCADE;
CREATE TABLE public."años" (
	"año" integer NOT NULL,
	CONSTRAINT "Años_pk" PRIMARY KEY ("año")

);



-- Tabla meses
-- DROP TABLE IF EXISTS public.meses CASCADE;
CREATE TABLE public.meses (
	mes_id integer NOT NULL,
	mes_desc text,
	"año" integer,
	CONSTRAINT meses_pk PRIMARY KEY (mes_id)

);
-- ddl-end --
-- ALTER TABLE public.meses OWNER TO postgres;
-- ddl-end --

-- Lllave foránea
-- ALTER TABLE public.meses DROP CONSTRAINT IF EXISTS "años_fk" CASCADE;
ALTER TABLE public.meses ADD CONSTRAINT "años_fk" FOREIGN KEY ("año")
REFERENCES public."años" ("año") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- Tabla Semanas
-- DROP TABLE IF EXISTS public.semanas CASCADE;
CREATE TABLE public.semanas (
	semana_id integer NOT NULL,
	semana_desc text,
	mes_id integer,
	CONSTRAINT semanas_pk PRIMARY KEY (semana_id)

);
-- ddl-end --
-- ALTER TABLE public.semanas OWNER TO postgres;
-- ddl-end --

-- object: meses_fk | type: CONSTRAINT --
-- ALTER TABLE public.semanas DROP CONSTRAINT IF EXISTS meses_fk CASCADE;
ALTER TABLE public.semanas ADD CONSTRAINT meses_fk FOREIGN KEY (mes_id)
REFERENCES public.meses (mes_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --



-- Tabla día
-- DROP TABLE IF EXISTS public.dia CASCADE;
CREATE TABLE public.dia (
	dia_id integer NOT NULL,
	fecha date,
	semana_id integer,
	CONSTRAINT dia_pk PRIMARY KEY (dia_id)

);
-- ddl-end --
-- ALTER TABLE public.dia OWNER TO postgres;
-- ddl-end --

-- object: semanas_fk | type: CONSTRAINT --
-- ALTER TABLE public.dia DROP CONSTRAINT IF EXISTS semanas_fk CASCADE;
ALTER TABLE public.dia ADD CONSTRAINT semanas_fk FOREIGN KEY (semana_id)
REFERENCES public.semanas (semana_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- Tabla horas
-- DROP TABLE IF EXISTS public.horas CASCADE;
CREATE TABLE public.horas (
	hora_id integer NOT NULL,
	hora_desc text,
	dia_id integer,
	CONSTRAINT horas_pk PRIMARY KEY (hora_id)

);
-- ddl-end --
-- ALTER TABLE public.horas OWNER TO postgres;
-- ddl-end --

-- object: dia_fk | type: CONSTRAINT --
-- ALTER TABLE public.horas DROP CONSTRAINT IF EXISTS dia_fk CASCADE;
ALTER TABLE public.horas ADD CONSTRAINT dia_fk FOREIGN KEY (dia_id)
REFERENCES public.dia (dia_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --



--------------DIMENSION CLIENTE ---------------

-- Tabla clientes
-- DROP TABLE IF EXISTS public.clientes CASCADE;
CREATE TABLE public.clientes (
	cliente_id integer NOT NULL,
	nombre text,
	apellido_pat text,
	apellido_mat text,
	CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)

);
-- ddl-end --
-- ALTER TABLE public.clientes OWNER TO postgres;
-- ddl-end --

-------------DIMENSION EMPLEADO ---------------------

-- Tabla empleados
-- DROP TABLE IF EXISTS public.empleados CASCADE;
CREATE TABLE public.empleados (
	empleado_id integer NOT NULL,
	nombre text,
	apellido_pat text,
	apellido_mat text,
	CONSTRAINT empleados_pk PRIMARY KEY (empleado_id)

);
-- ddl-end --
-- ALTER TABLE public.empleados OWNER TO postgres;
-- ddl-end --


-----------------DIMENSIÓN PROMOCIÓN ---------------------


-- Tabla promoción
-- DROP TABLE IF EXISTS public.promocion CASCADE;
CREATE TABLE public.promocion (
	"promoción_id" integer NOT NULL,
	promocion_desc text,
	CONSTRAINT precios_pk PRIMARY KEY ("promoción_id")

);
-- ddl-end --
-- ALTER TABLE public.promocion OWNER TO postgres;
-- ddl-end --


-----------DIMENSION Geografía--------------------

-- Tabla estados
-- DROP TABLE IF EXISTS public.estados CASCADE;
CREATE TABLE public.estados (
	estado_id integer NOT NULL,
	estado_desc text,
	CONSTRAINT estados_pk PRIMARY KEY (estado_id)

);
-- ddl-end --
-- ALTER TABLE public.estados OWNER TO postgres;
-- ddl-end --

-- Tabla Tiendas
-- DROP TABLE IF EXISTS public.tienda CASCADE;
CREATE TABLE public.tienda (
	tienda_id integer NOT NULL,
	tienda_desc text,
	estado_id integer,
	CONSTRAINT tienda_pk PRIMARY KEY (tienda_id)

);
-- ddl-end --
-- ALTER TABLE public.tienda OWNER TO postgres;
-- ddl-end --

-- object: estados_fk | type: CONSTRAINT --
-- ALTER TABLE public.tienda DROP CONSTRAINT IF EXISTS estados_fk CASCADE;
ALTER TABLE public.tienda ADD CONSTRAINT estados_fk FOREIGN KEY (estado_id)
REFERENCES public.estados (estado_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


-------------HECHOS-------------

-- object: public.hechos | type: TABLE --
-- DROP TABLE IF EXISTS public.hechos CASCADE;
CREATE TABLE public.hechos (
	venta integer NOT NULL,
	precio_de_venta_por_unidad float,
	unidades_vendidas integer,
	ganancia_por_unidad float,
	hora_id integer,
	cliente_id integer,
	empleado_id integer,
	tienda_id integer,
	"promoción_id" integer,
	CONSTRAINT hechos_pk PRIMARY KEY (venta)

);
-- ddl-end --
-- ALTER TABLE public.hechos OWNER TO postgres;
-- ddl-end --

-- object: horas_fk | type: CONSTRAINT --
-- ALTER TABLE public.hechos DROP CONSTRAINT IF EXISTS horas_fk CASCADE;
ALTER TABLE public.hechos ADD CONSTRAINT horas_fk FOREIGN KEY (hora_id)
REFERENCES public.horas (hora_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: clientes_fk | type: CONSTRAINT --
-- ALTER TABLE public.hechos DROP CONSTRAINT IF EXISTS clientes_fk CASCADE;
ALTER TABLE public.hechos ADD CONSTRAINT clientes_fk FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: empleados_fk | type: CONSTRAINT --
-- ALTER TABLE public.hechos DROP CONSTRAINT IF EXISTS empleados_fk CASCADE;
ALTER TABLE public.hechos ADD CONSTRAINT empleados_fk FOREIGN KEY (empleado_id)
REFERENCES public.empleados (empleado_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.hechos DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.hechos ADD CONSTRAINT tienda_fk FOREIGN KEY (tienda_id)
REFERENCES public.tienda (tienda_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: promocion_fk | type: CONSTRAINT --
-- ALTER TABLE public.hechos DROP CONSTRAINT IF EXISTS promocion_fk CASCADE;
ALTER TABLE public.hechos ADD CONSTRAINT promocion_fk FOREIGN KEY ("promoción_id")
REFERENCES public.promocion ("promoción_id") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --
