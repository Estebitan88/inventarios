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

select * from categorias