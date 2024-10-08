-- tabela 1 cadastro
create database datacoffe;


use dbdatacoffee;

create table cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
Produtor varchar(100)NOT NULL,
Propriedade  varchar(100)NOT NULL,
CNPJ char(14) NOT NULL,
UF char(2) NOT NULL,
Email varchar(100) NOT NULL,
Senha varchar(100) NOT NULL
);

create table usuario(
	idUsuario int primary key auto_increment,
    nomeUsuario varchar(45),
    senha varchar(45),
    fkCliente int,
    constraint fkClienteUsuario foreign key (fkCliente) references cliente(idCliente)
    );
 



create table plantacao(
	idPlantacao int auto_increment not null,
    fkCliente int not null,
    constraint primary key (idPlantacao, fkCliente),
    hectares float,
    qtdPes int,
    constraint fkClientePlantacao foreign key (fkCliente)
    references cliente(idCliente)
    );


create table sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modelo varchar(45),
localizacao varchar(45),
dtInstalacao date,
fkPlantacao int,
constraint fkPlantacaoSensor foreign key (fkPlantacao) references plantacao(idPlantacao)
);


create table registro(
idRegistro int primary key auto_increment,
umidade float,
temperatura float,
dtRegistro datetime,
fkSensor int,
constraint fkSensorRegistro foreign key (fkSensor) references sensor(idSensor)
);

select * from registro;

show tables;






