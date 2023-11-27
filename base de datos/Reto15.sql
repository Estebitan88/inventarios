drop table if exists detalle_de_ventas;
drop table if exists historial_stock;
drop table if exists detalle_de_pedido;
drop table if exists cabecera_de_pedido;
drop table if exists estado_pedidos;
drop table if exists proveedores;
drop table if exists tipo_de_documento;
drop table if exists producto;
drop table if exists unidades_medida;
drop table if exists categorias_unidad_medida;
drop table if exists categorias;

--***CREAR TABLA CATEGORIAS***--
drop table if exists categorias;
create table categorias(
	codigo_cat serial not null,
	nombre varchar(100) not null,
	categoria_padre int, 
	constraint categorias_pk primary key (codigo_cat),
	constraint categorias_fk foreign key (categoria_padre)
	references categorias(codigo_cat)
);

insert into categorias(nombre,categoria_padre)
values('Materia prima',null);
insert into categorias(nombre,categoria_padre)
values('Proteina',1);
insert into categorias(nombre,categoria_padre)
values('Salsas',1);
insert into categorias(nombre,categoria_padre)
values('Punto de venta',null);
insert into categorias(nombre,categoria_padre)
values('Bedidas',4);
insert into categorias(nombre,categoria_padre)
values('con Alcohol',5);
insert into categorias(nombre,categoria_padre)
values('sin Alcohol',5);

select * from categorias;

--***CREAR TABLA CATEGORIAS UNIDAD DE MEDIDA***--
drop table if exists categorias_unidad_medida;
create table categorias_unidad_medida(
	codigo_cat_unidad_medida varchar(5) not null,
	nombre varchar(100) not null,
	constraint categorias_unidad_medida_pk primary key (codigo_cat_unidad_medida)
);

insert into categorias_unidad_medida(codigo_cat_unidad_medida,nombre)
values('U','Unidades');
insert into categorias_unidad_medida(codigo_cat_unidad_medida,nombre)
values('V','Volumen');
insert into categorias_unidad_medida(codigo_cat_unidad_medida,nombre)
values('P','Peso');

select * from categorias_unidad_medida;

--***CREAR TABLA UNIDADES DE MEDIDA***--
drop table if exists unidades_medida;
create table unidades_medida(
	codigo_unidades_medida varchar(5) not null,
	descripcion varchar(100) not null,
	codigo_cat_unidad_medida varchar(5) not null,
	constraint unidades_medida_pk primary key (codigo_unidades_medida),
	constraint categorias_unidad_medida_fk foreign key (codigo_cat_unidad_medida)
	references categorias_unidad_medida(codigo_cat_unidad_medida)
);

insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('ml','mililitros','V');
insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('l','litros','V');
insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('u','unidad','U');
insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('d','docena','U');
insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('g','gramos','P');
insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('kg','kilogramos','P');
insert into unidades_medida(codigo_unidades_medida,descripcion,codigo_cat_unidad_medida)
values('lb','libras','P');

select * from unidades_medida;

--***CREAR TABLA PRODUCTO***--
drop table if exists producto;
create table producto(
	codigo serial not null,
	nombre varchar(100) not null,
	unidad_medida varchar(5) not null,
	precio_de_venta money not null,
	tiene_iva boolean not null,
	coste money not null,
	categoria int not null,
	stock int not null,
	constraint producto_pk primary key (codigo),
	constraint unidades_medida_fk foreign key (unidad_medida)
	references unidades_medida(codigo_unidades_medida),
	constraint categorias_fk foreign key (categoria)
	references categorias(codigo_cat)
);

insert into producto(nombre,unidad_medida,precio_de_venta,tiene_iva,coste,categoria,stock)
values('cocacola pequeña','u',0.58,true,0.37,7,105);
insert into producto(nombre,unidad_medida,precio_de_venta,tiene_iva,coste,categoria,stock)
values('Salsa de tomate','kg',0.95,true,0.87,3,0);
insert into producto(nombre,unidad_medida,precio_de_venta,tiene_iva,coste,categoria,stock)
values('Mostaza','kg',0.95,true,0.89,3,0);
insert into producto(nombre,unidad_medida,precio_de_venta,tiene_iva,coste,categoria,stock)
values('Fuze tea','u',0.8,true,0.7,7,49);

select * from producto;

--***CREAR TABLA TIPO DE DOCUMENTO***--
drop table if exists tipo_de_documento;
create table tipo_de_documento(
	codigo_tipo_documento varchar(5) not null,
	descripcion varchar(100) not null,
	constraint tipo_de_documento_pk primary key (codigo_tipo_documento)
);

insert into tipo_de_documento(codigo_tipo_documento,descripcion)
values('C','Cedula');
insert into tipo_de_documento(codigo_tipo_documento,descripcion)
values('R','Ruc');

select * from tipo_de_documento;

--***CREAR TABLA PROVEEDORES***--
drop table if exists proveedores;
create table proveedores(
	identificador varchar(10) not null,
	tipo_de_documento varchar(5) not null,
	nombre varchar(100) not null,
	telefono varchar(15) not null,
	correo varchar(100) not null,
	direccion varchar(100) not null,
	constraint proveedores_pk primary key (identificador),
	constraint tipo_de_documento_fk foreign key (tipo_de_documento)
	references tipo_de_documento(codigo_tipo_documento)
	
);

insert into proveedores(identificador,tipo_de_documento,nombre,telefono,correo,direccion)
values('201813574','C','Esteban Guaña','984741869','andygch@hotmail.com','Patate');
insert into proveedores(identificador,tipo_de_documento,nombre,telefono,correo,direccion)
values('201813573','R','Snack SA','984741868','snack@hotmail.com','La Tola');

select * from proveedores;

--***CREAR TABLA ESTADO PEDIDOS***--
drop table if exists estado_pedidos;
create table estado_pedidos(
	codigo_estado varchar(5) not null,
	descripcion varchar(100) not null,
	constraint estado_pedidos_pk primary key (codigo_estado)
);

insert into estado_pedidos(codigo_estado,descripcion)
values('S','Solicitado');
insert into estado_pedidos(codigo_estado,descripcion)
values('R','Recibido');

select * from estado_pedidos;

--***CREAR TABLA CABECERA  DE PEDIDO***--
drop table if exists cabecera_de_pedido;
create table cabecera_de_pedido(
	numero serial not null,
	proveedor varchar(10) not null,
	fecha TIMESTAMP not null,
	estado varchar(5) not null,
	
	constraint cabecera_de_pedido_pk primary key (numero),
	constraint proveedores_fk foreign key (proveedor)
	references proveedores(identificador),
	constraint estado_pedidos_fk foreign key (estado)
	references estado_pedidos(codigo_estado)
);

insert into cabecera_de_pedido(proveedor,fecha,estado)
values('201813573','20/11/2023','R');
insert into cabecera_de_pedido(proveedor,fecha,estado)
values('201813573','20/11/2023','R');

select * from cabecera_de_pedido;


--***CREAR TABLA DETALLE  DE PEDIDO***--
drop table if exists detalle_de_pedido;
create table detalle_de_pedido(
	codigo serial not null,
	cabecera_pedido int not null,
	producto int not null,
	cantidad_solicitada int not null,
	subtotal money not null,
	cantidad_recibida int not null,
	constraint detalle_de_pedido_pk primary key (codigo),
	constraint producto_fk foreign key (producto)
	references producto(codigo)
	
);

insert into detalle_de_pedido(cabecera_pedido,producto,cantidad_solicitada,subtotal,cantidad_recibida)
values(1,1,100,100,100);
insert into detalle_de_pedido(cabecera_pedido,producto,cantidad_solicitada,subtotal,cantidad_recibida)
values(1,4,50,11.80,50);
insert into detalle_de_pedido(cabecera_pedido,producto,cantidad_solicitada,subtotal,cantidad_recibida)
values(2,1,10,3.73,10);

select * from detalle_de_pedido;


--***CREAR TABLA HISTORIAL STOCK***--
drop table if exists historial_stock;
create table historial_stock(
	codigo serial not null,
	fecha TIMESTAMP not null,
	referencia varchar(100) not null,
	producto int not null,
	cantidad int not null,
	constraint historial_stock_pk primary key (codigo),
	constraint producto_fk foreign key (producto)
	references producto(codigo)
	
);

insert into  historial_stock(fecha,referencia,producto,cantidad)
values('20/11/20123 19:59','Pedido 1',1,100);
insert into  historial_stock(fecha,referencia,producto,cantidad)
values('20/11/20123 19:59','Pedido 1',4,50);
insert into  historial_stock(fecha,referencia,producto,cantidad)
values('20/11/20123 20:00','Pedido 2',1,10);
insert into  historial_stock(fecha,referencia,producto,cantidad)
values('20/11/20123 20:00','Venta 1',1,-5);
insert into  historial_stock(fecha,referencia,producto,cantidad)
values('20/11/20123 20:00','Venta 1',4,1);

select * from historial_stock;

--***CREAR TABLA CABECERA VENTAS***--
drop table if exists cabecera_ventas;
create table cabecera_ventas(
	codigo serial not null,
	fecha TIMESTAMP not null,
	total_sin_iva money not null,
	iva money not null,
	total money not null,
	constraint cabecera_ventas_pk primary key (codigo)
	
);

insert into cabecera_ventas(fecha,total_sin_iva,iva,total)
values('20/11/20123 20:00',3.26,0.39,3.65);

select * from cabecera_ventas;


--***CREAR TABLA DETALLE  VENTAS***--
drop table if exists detalle_de_ventas;
create table detalle_de_ventas(
	codigo serial not null,
	cabecera_ventas int not null,
	producto int not null,
	cantidad int not null,
	precio_venta money not null,
	subtotal money not null,
	subtotal_con_iva money not null,
	constraint detalle_de_ventas_pk primary key (codigo),
	constraint cabecera_ventas_fk foreign key (cabecera_ventas)
	references cabecera_ventas(codigo),
	constraint producto_fk foreign key (producto)
	references producto(codigo)
	
);

insert into detalle_de_ventas(cabecera_ventas,producto,cantidad,precio_venta,subtotal,subtotal_con_iva)
values(1,1,5,0.58,2.9,3.25);
insert into detalle_de_ventas(cabecera_ventas,producto,cantidad,precio_venta,subtotal,subtotal_con_iva)
values(1,4,1,0.36,0.36,0.04);

select * from detalle_de_ventas;

