CREATE DATABASE tienda_chompa;
#DROP DATABASE tienda_chompa;
USE tienda_chompa;
CREATE TABLE persona(
	dni INT NOT NULL,
    nombres VARCHAR(30) NULL,
    p_apellido VARCHAR(30)NULL,
    s_apellido VARCHAR(30) NULL,
    direccion VARCHAR(30)NULL,
    telefono VARCHAR(30)NULL,
    usuario varchar(30) NULL, 
    contra VARCHAR(30) NOT NULL,
    PRIMARY KEY(dni)
);
CREATE TABLE cliente(
	dni INT,
	saldo DECIMAL(5,2) NOT NULL,
	foreign key(dni) references persona(dni),
    primary key(dni)
);
CREATE TABLE vendedor(
	dni INT,
	sueldo DECIMAL(5,2) NOT NULL,
	foreign key(dni) references persona(dni),
	primary key(dni)
);
CREATE TABLE tienda(
    RUC INT,
    dni_vendedor INT,
    direccion VARCHAR(50)  NOT NULL,
    telef INT NOT NULL,
    divisa VARCHAR(30) NOT NULL,
    FOREIGN KEY(dni_vendedor) REFERENCES vendedor(dni),
    PRIMARY KEY (RUC)
);
CREATE TABLE reclamo(
    id_reclamo INT auto_increment,
    dni_cliente INT,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (dni_cliente) REFERENCES cliente(dni),
    PRIMARY KEY(id_reclamo)
);
CREATE TABLE producto(
	id_producto INT,
	descripcion VARCHAR(100) NOT NULL,
    precio DECIMAL(5,2) NOT NULL,
    marca VARCHAR(30) NOT NULL,
	talla VARCHAR(3) NOT NULL,
	primary key(id_producto)
);
CREATE TABLE p_masculino(
    id_producto INT,
    stock INT,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    PRIMARY KEY (id_producto)
);
CREATE TABLE p_femenino(
    id_producto INT,
    stock INT,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    PRIMARY KEY (id_producto)
);
CREATE TABLE p_unisex(
    id_producto INT,
    stock INT,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    PRIMARY KEY (id_producto)
);
CREATE TABLE compra(
	id_compra INT AUTO_INCREMENT,
    id_producto INT,
    dni_cliente INT,
    dni_vendedor INT,
	cantidad INT NOT NULL,
	foreign key(id_producto) references producto(id_producto),
    foreign key(dni_cliente) references persona(dni),
    foreign key(dni_vendedor) references persona(dni),
	primary key(id_compra)
);
/*Insertando persona dni, nombres, p_apellido, s_apellido, direccion, telefono,
				   usuario, contra */
DESCRIBE persona;

/*Insertando persona dni, nombres, p_apellido, s_apellido, direccion, telefono, usuario, contra */
INSERT INTO persona 
VALUES(123,'Diego','Rios','Valdivia','Av. Venezuela','765432190','asd@gmail.com','123');
INSERT INTO persona 
VALUES(124,'Diego','Risa','Balde','Av. Peru','76543219','asde@gmail.com','121');
INSERT INTO persona 
VALUES(72249616,'Ronald','Gutierrez','Arratia','Cerro Colorado','925238121','ronaldgutierrez2905@gmail.com','a213d');
INSERT INTO persona 
VALUES(73349616,'Jose','Alvarez','Jeims','Cerro Colorado','925238121','jalvarez5@gmail.com','as1cd');
INSERT INTO persona 
VALUES(71239616,'Luis','Rosas','Apaza','Cerro Colorado','925338121','lrosas@gmail.com','a123sd');
INSERT INTO persona 
VALUES(72123416,'Alberto','Jame','Gomez','Av. Ramos','925238121','ajame@gmail.com','123csd');
INSERT INTO persona 
VALUES(26349616,'Fabricio','Algaraza','Inca','Cerro Colorado','925238121','falargaza@gmail.com','a425sd');
INSERT INTO persona 
VALUES(44449616,'Manuel','Bergara','Shady','Yanahuara','915238121','mvergara@gmail.com','3465casd');
INSERT INTO persona 
VALUES(73339616,'Marco','Valdez','Salas','Cerro Colorado','924538121','mvaldez@gmail.com','67sd');
INSERT INTO persona 
VALUES(77777716,'Carlos','Ramos','Carrera','Av. Avelino','925234121','cramos@gmail.com','345vasd');
INSERT INTO persona 
VALUES(29999616,'Gael','Aguilar','Paredes','Miraflores','9252382341','gaguilar@gmail.com','6y7hasd');
INSERT INTO persona 
VALUES(79999616,'Edison','Tito','Salazar','Cerro Colorado','9256745121','etito@gmail.com','567fsd');
INSERT INTO persona 
VALUES(71119616,'Samuel','Ponce','Jas','Cerro Colorado','925256721','mponce@gmail.com','a567basd');
INSERT INTO persona 
VALUES(28949616,'Ronald','Salsa','Saldaña','Miguel grau','925567121','rslsa@gmail.com','345vasd');
INSERT INTO persona 
VALUES(34519616,'Gabriel','Serrano','Samiz','Yura','925237890','gserrano@gmail.com','4v56asd');

select* from persona;

/*Insertando cliente dni ,saldo, */
INSERT INTO cliente VALUES(123,350.00);
INSERT INTO cliente VALUES(72249616,600.00);
INSERT INTO cliente VALUES(73349616,700.00);
INSERT INTO cliente VALUES(71239616,650.00);
INSERT INTO cliente VALUES(72123416,750.00);
INSERT INTO cliente VALUES(26349616,850.00);
INSERT INTO cliente VALUES(44449616,950.00);
INSERT INTO cliente VALUES(73339616,500.00);
INSERT INTO cliente VALUES(77777716,100.00);
INSERT INTO cliente VALUES(29999616,100.00);
INSERT INTO cliente VALUES(79999616,140.00);
INSERT INTO cliente VALUES(71119616,320.00);
INSERT INTO cliente VALUES(28949616,250.00);
INSERT INTO cliente VALUES(34519616,150.00);


/*Insertando vendedor dni, sueldo */
DESCRIBE vendedor;
INSERT INTO vendedor
VALUES(124,500.00);
SELECT* FROM  vendedor;

/*Insertando lente id_producto, descripcion, precio, marca, stock */
DESCRIBE producto;
INSERT INTO producto
VALUES(1,'rojo oscuro',40.00,'NIKE','S');
INSERT INTO producto
VALUES(2,'verde claro',30.00,'ADIDAS','XL');
INSERT INTO producto
VALUES(3,'cafe claro',35.00,'PUMBA','M');
INSERT INTO producto
VALUES(4,'blanco',25.00,'fruta','S');
INSERT INTO producto
VALUES(5,'amarillo claro',35.00,'PUMBITA','M');
INSERT INTO producto
VALUES(6,'amarillo oscuro',35.00,'CARRITO','M');
INSERT INTO producto
VALUES(7,'rosa',25.00,'PINK','S');
INSERT INTO producto
VALUES(8,'rosa oscuro',45.00,'PINKN','M');
INSERT INTO producto VALUES(9,'Color negro',230.00,'Nike','S');
INSERT INTO producto VALUES(10,'Color rojo',240.00,'Lacoste','X');
INSERT INTO producto VALUES(11,'Color negro',210.00,'Nike','M');
INSERT INTO producto VALUES(12,'Color celeste',220.00,'Adidas','S');
INSERT INTO producto VALUES(13,'Color negro',44.00,'Lacoste','XL');
INSERT INTO producto VALUES(14,'Color amarillo',460.00,'Adidas','S');
INSERT INTO producto VALUES(33,'Color negro',240.00,'Nike','S');
SELECT* FROM producto;


/**/
Describe p_masculino;
INSERT INTO p_masculino VALUES(2,100);
INSERT INTO p_masculino VALUES(33,44);
INSERT INTO p_masculino VALUES(5,20);
INSERT INTO p_masculino VALUES(6,50);
SELECT* FROM p_masculino;
#drop database tienda_chompa;

INSERT INTO p_femenino VALUES(1,90);
INSERT INTO p_femenino VALUES(7,10);
INSERT INTO p_femenino VALUES(9,100);
INSERT INTO p_femenino VALUES(10,50);
INSERT INTO p_femenino VALUES(12,70);
INSERT INTO p_femenino VALUES(14,90);
SELECT* FROM p_femenino;



INSERT INTO p_unisex VALUES(3,55);
INSERT INTO p_unisex VALUES(8,15);
INSERT INTO p_unisex VALUES(11,25);
INSERT INTO p_unisex VALUES(13,35);
INSERT INTO p_unisex VALUES(4,45);

SELECT* FROM p_unisex;

/*Insertando compra id_compra ,id_lente ,dni_cliente ,dni_vendedor ,cantidad */
DESCRIBE compra;
INSERT INTO compra VALUES(NULL,2,123,124,3);
INSERT INTO compra VALUES(NULL,3,123,124,5);
INSERT INTO compra VALUES(NULL,1,72249616,124,2);
INSERT INTO compra VALUES(NULL,2,72249616,124,5);
INSERT INTO compra VALUES(NULL,5,29999616,124,5);
INSERT INTO compra VALUES(NULL,7,44449616,124,10);
INSERT INTO compra VALUES(NULL,11,26349616,124,23);
INSERT INTO compra VALUES(NULL,12,77777716,124,12);
INSERT INTO compra VALUES(NULL,6,77777716,124,2);
INSERT INTO compra VALUES(NULL,8,34519616,124,4);
INSERT INTO compra VALUES(NULL,9,44449616,124,2);
INSERT INTO compra VALUES(NULL,13,71239616,124,5);
INSERT INTO compra VALUES(NULL,14,34519616,124,12);
INSERT INTO compra VALUES(NULL,33,71239616,124,10);
INSERT INTO compra VALUES(NULL,4,34519616,124,5);

SELECT* FROM compra;

/*Insertando un reclamo*/
DESCRIBE reclamo;
INSERT INTO reclamo VALUES(NULL,123,'Pesimas chompas');
/**/
DESCRIBE tienda;
INSERT INTO tienda VALUES(1234567,124,'Av.santa claus',98754321,'Inti');
SELECT* FROM tienda;

