USE tienda_chompa;

/* Dar el dni de un cliente y obtener las compras que realizo el usuario*/
/*DROP PROCEDURE obtenerCompra;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE obtenerCompra(
IN n_dni_cliente integer)
begin
	SELECT * FROM compra where dni_cliente = n_dni_cliente;
end$$
DELIMITER ;

USE tienda_chompa;
CALL obtenerCompra(123);*/


/*Dar el dni de un cliente y obtener los lentes que compro el cliente*/
/*USE tienda_chompa;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE obtenerProducto(
IN n_dni_cliente integer)
begin
	SELECT pe.nombres, pe.dni, pe.usuario,co.id_compra,co.cantidad,pr.id_producto,pr.descripcion
    FROM cliente c INNER JOIN
    persona pe ON pe.dni = c.dni AND n_dni_cliente = c.dni
    INNER JOIN compra co 
    INNER JOIN producto pr
    WHERE co.dni_cliente = n_dni_cliente AND co.id_producto = pr.id_producto;
end$$
DELIMITER ;
    
USE tienda_chompa;
CALL obtenerProducto(123);*/

/* Damos un dni y verifica si es cliente*/

USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` function esCliente(
DNI INT)RETURNS INT DETERMINISTIC
begin
    DECLARE bandera BOOL;
    DECLARE aux INT;
    
    SET bandera = (SELECT COUNT(c.dni) FROM cliente c 
        INNER JOIN  persona p WHERE c.dni = DNI AND p.dni = c.dni
        GROUP BY c.dni);
    IF bandera THEN
       SET aux = 1;
	ELSE
       SET aux = 0;
     END IF;
    
    RETURN aux;
end$$
DELIMITER ;

#DROP FUNCTION esCliente;
USE tienda_chompa;
SELECT* FROM cliente;
SELECT* FROM vendedor;
SELECT escliente(124);

/* Le doy correo y me devuelve  dni*/

/* Damos un correo y validamos */

USE tienda_chompa;
#DROP PROCEDURE validarLogin;
DELIMITER $$
create definer=`root`@`localhost` procedure validarLogin(
IN n_usuario varchar(30))
begin
    SELECT p.dni dni, p.nombres nombres, p.p_apellido, p.s_apellido, 
           p.direccion direccion,p.telefono telefono, p.usuario usuario,
           p.contra contra, esCliente(p.dni) sies
	FROM persona p INNER JOIN cliente c
    ON p.usuario = n_usuario;
    
end$$
DELIMITER ;
#DROP PROCEDURE validarLogin;
USE tienda_chompa;
SELECT* FROM persona;
SELECT* FROM cliente;
SELECT* FROM vendedor;
CALL validarLogin('asde@gmail.com');


/*Crea un persona*/
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` procedure crearPersona(
IN n_dni integer,
IN n_nombre varchar(30),
IN n_p_apellido varchar(30),
IN n_s_apellido varchar(30),
IN n_direccion varchar(30),
IN n_telefono varchar(30),
IN n_usuario varchar(30),
IN n_contra varchar(30))
begin
	if (select exists (select 1 from persona where dni = n_dni)) then
		select 'Usuario ya existe!!';
	else
        insert into persona 
		values (n_dni, n_nombre, n_p_apellido, n_s_apellido, n_direccion, n_telefono, n_usuario, n_contra);
		insert into cliente values(n_dni,600.00);
    end if;
end$$
DELIMITER ;

USE tienda_chompa;
SELECT* FROM persona;
SELECT* FROM cliente;
SELECT* FROM vendedor;
USE tienda_chompa;
CALL crearPersona(222,'Juan','Perez','Rios','Av.malavida','456732','pepe@gmail.com','982');

/*Para saber a que tipo pertenece el producto masculino*/
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` function tipoProdMascu(
id_producto INT)RETURNS INT DETERMINISTIC
begin
    DECLARE bandera BOOL;
    DECLARE aux INT;
    
    SET bandera = (SELECT COUNT(c.id_producto) FROM producto c 
        INNER JOIN  p_masculino p WHERE c.id_producto = id_producto AND p.id_producto = c.id_producto
        GROUP BY c.id_producto);
    IF bandera THEN
       SET aux = 1;
	ELSE
       SET aux = 0;
     END IF;
    
    RETURN aux;
end$$
DELIMITER ;
select tipoProdMascu(3);

/*Para saber a que tipo pertenece el producto femenino*/
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` function tipoProdFem(
id_producto INT)RETURNS INT DETERMINISTIC
begin
    DECLARE bandera BOOL;
    DECLARE aux INT;
    
    SET bandera = (SELECT COUNT(c.id_producto) FROM producto c 
        INNER JOIN  p_femenino p WHERE c.id_producto = id_producto AND p.id_producto = c.id_producto
        GROUP BY c.id_producto);
    IF bandera THEN
       SET aux = 1;
	ELSE
       SET aux = 0;
     END IF;
    
    RETURN aux;
end$$
DELIMITER ;
select tipoProdFem(1);

/*Para saber a que tipo pertenece el producto unisex*/
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` function tipoProdUnix(
id_producto INT)RETURNS INT DETERMINISTIC
begin
    DECLARE bandera BOOL;
    DECLARE aux INT;
    
    SET bandera = (SELECT COUNT(c.id_producto) FROM producto c 
        INNER JOIN  p_unisex p WHERE c.id_producto = id_producto AND p.id_producto = c.id_producto
        GROUP BY c.id_producto);
    IF bandera THEN
       SET aux = 1;
	ELSE
       SET aux = 0;
     END IF;
    
    RETURN aux;
end$$
DELIMITER ;
select tipoProdUnix(1);

/*Damos un id de producto y obtenemos su stock*/
#DROP FUNCTION obtenerStock;
USE tienda_chompa;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION obtenerStock(
n_id_producto INT)RETURNS INT DETERMINISTIC
begin
	DECLARE valor INT;
    if tipoProdMascu(n_id_producto) then
       SET valor = (select l.stock from p_masculino l where  n_id_producto = l.id_producto);
	elseif tipoProdFem(n_id_producto) then
       SET valor = (select l.stock from p_femenino l where  n_id_producto = l.id_producto);
	else
       SET valor = (select l.stock from p_unisex l where  n_id_producto = l.id_producto);
    end if;
    RETURN valor;
end$$
DELIMITER ;

SELECT obtenerstock(3);


/*Agregamos una compra para un usuario(cliente)*/
#drop procedure agregarCompra;
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` procedure agregarCompra(
IN n_id_producto INT,
IN n_cant INT,
IN n_dni_cliente INT)
begin
    insert into compra(id_compra,id_producto ,dni_cliente ,dni_vendedor, cantidad)
    values(NULL,n_id_producto,n_dni_cliente,124,n_cant);
    if tipoProdMascu(n_id_producto) then
       update p_masculino pm SET pm.stock = pm.stock - n_cant where pm.id_producto = n_id_producto;
	elseif tipoProdFem(n_id_producto) then
       update p_femenino pm SET pm.stock = pm.stock - n_cant where pm.id_producto = n_id_producto;
	else
       update p_unisex pm SET pm.stock = pm.stock - n_cant where pm.id_producto = n_id_producto;
	end if;
end$$
DELIMITER ;

select* from p_masculino;
call  agregarCompra(1,15,123);
select* from p_unisex;
select* from compra;

/*Obtener compra*/
#DROP PROCEDURE obtenerCompra;
USE tienda_chompa;#
DELIMITER $$
create definer=`root`@`localhost` procedure obtenerCompra(
IN n_dni_cliente integer)
begin
	select l.id_producto id,l.marca marca,l.descripcion descripcion,l.precio precio,c.cantidad cantidad
    from compra c inner join producto l 
    on c.id_producto = l.id_producto AND c.dni_cliente=n_dni_cliente;
end$$
DELIMITER ;

CALL obtenerCompra(123);

/*Agregar producto lente*/
#DROP PROCEDURE agregarProducto;
use tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` procedure agregarProducto(
IN n_id_producto INT,
IN n_marca varchar(30),
IN n_descripcion varchar(30),
IN n_dni_cliente integer,
IN tipo VARCHAR(3),
IN cantidad INT,
IN _talla TEXT,
IN _precio DECIMAL(5,2))
begin
	insert into producto (id_producto, descripcion,precio, marca, talla)
	values (n_id_producto, n_descripcion,_precio, n_marca,_talla);
    if UPPER(tipo)='M' then
       insert into p_masculino(id_producto,stock) values(n_id_producto,cantidad);
	elseif UPPER(tipo)='F' then 
       insert into p_femenino(id_producto,stock) values(n_id_producto,cantidad);
	elseif UPPER(tipo)='U' then
       insert into p_unisex(id_producto,stock) values(n_id_producto,cantidad);
    end if;
end$$
DELIMITER ;

#drop procedure obtenerProducto;
USE tienda_chompa;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE obtenerProducto(
)
begin
	SELECT * FROM producto;
end$$
DELIMITER ;
SELECT* FROM producto;
USE tienda_chompa;
CALL obtenerProducto();


/*Agregar reclamo*/
use tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` procedure agregarReclamo(
IN n_descripcion TEXT,
IN n_dni_cliente integer)
begin
	insert into reclamo (id_reclamo,dni_cliente,descripcion)
	values (NULL,n_dni_cliente, n_descripcion);
end$$
DELIMITER ;

CALL agregarReclamo('Muy pocas chompas y el vendedor es malo',222);


/*Obtner reclamos*/
USE tienda_chompa;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE obtenerReclamo(
)
begin
	SELECT * FROM reclamo;
end$$
DELIMITER ;

CALL obtenerReclamo();

/*Actualizamso datos de una persona*/
#drop procedure actualizarPersona;
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` procedure actualizarPersona(
IN n_dni integer,
IN n_nombre varchar(30),
IN n_p_apellido varchar(30),
IN n_s_apellido varchar(30),
IN n_direccion varchar(30),
IN n_telefono varchar(30),
IN n_usuario varchar(30),
IN n_contra varchar(30))
begin
        update persona pe SET pe.nombres=n_nombre,pe.p_apellido=n_p_apellido,
               pe.s_apellido=n_s_apellido,pe.direccion =n_direccion,pe.telefono =n_telefono,
               pe.usuario = n_usuario,pe.contra=n_contra where pe.dni = n_dni;
end$$
DELIMITER ;

CALL actualizarPersona(123,'RONALD1','gutierrez','arratia','Av.venezuela','334561290','rona@gmail.com','666');

/*Actualizar producto*/
#drop procedure actualizarProducto;
USE tienda_chompa;
DELIMITER $$
create definer=`root`@`localhost` procedure actualizarProducto(
IN n_id_producto INT,
IN n_marca varchar(30),
IN n_descripcion varchar(30),
IN n_dni_cliente integer,
IN tipo VARCHAR(3),
IN cantidad INT,
IN _talla TEXT,
IN _precio DECIMAL(5,2))
begin
	update producto pe SET pe.descripcion=n_descripcion,pe.precio=_precio,pe.marca=n_marca,pe.talla=_talla
           where pe.id_producto = n_id_producto ;
    if tipoProdMascu(n_id_producto) then
       update p_masculino pm SET pm.stock=cantidad where pm.id_producto=n_id_producto;
	elseif tipoProdFem(n_id_producto) then 
       update p_femenino pm SET pm.stock=cantidad where pm.id_producto=n_id_producto;
	elseif tipoProdUnix(n_id_producto) then
       update p_unisex pm SET pm.stock=cantidad where pm.id_producto=n_id_producto;
    end if;
end$$
DELIMITER ;

call actualizarProducto(8,'princesa','chompa amarilla',124,'M',300,'L',60.00);

use tienda_chompa;
SELECT* FROM persona;
SELECT* FROM cliente;
SELECT* FROM vendedor;
SELECT* FROM tienda;
SELECT* FROM reclamo;
SELECT* FROM producto;
SELECT* FROM p_masculino;
SELECT* FROM p_femenino;
SELECT* FROM p_unisex;
SELECT* FROM compra;