-- tabela 1 cadastro
create database datacoffe;

use datacoffe;

create table cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
Produtor varchar(100)NOT NULL,
Propriedade  varchar(100)NOT NULL,
CNPJ char(14) NOT NULL,
UF char(2) NOT NULL,
Email varchar(100) NOT NULL,
Senha varchar(100) NOT NULL
);
insert into cliente (id, Produtor, Propriedade, CNPJ, UF, Email, Senha) values
	(default, 'Marcio luiz', 'sitio alvorada','48274682000101', 'SP', 'sitioalvorada@gmail.com', 'SitioAlvorada@101'),
    (default, 'Maria josé', 'são francisco','92381566000102', 'MG', 'mariajose@gmail.com', 'Saofrancisco@102'),
    (default, 'Agrifarma', 'Campo aberto','15794329000103', 'SP', 'campoaberto@gmail.com', 'CampoAberto@103'),
    (default, 'João Antonio', 'Estancia são francisco','76539812000104', 'MG', 'estancia1990@gmail.com', 'Estancia@104'),
    (default, 'Lessivan Marcos', 'Lagoa do morro','38627941000105', 'SP', 'lagoamorro@gmail.com', 'LagoadoMorro@105'),
    (default, 'Hilda Stein', 'sitio krohiling','61983457000106', 'MG', 'sitiokrohiling@gmail.com', 'SitioKrohiling@106');
    
    select * from cliente;
    select Produtor, Propriedade from cliente;
	select Produtor, Senha from cliente;
    select Email FROM cliente;
	select* from cliente where UF = 'SP';
	select* from cliente order by CNPJ;
	select* from cliente order by UF;
	select* from cliente where Produtor like '%a%';
	select* from cliente where Produtor like '%o';
	select* from cliente where Produtor like '%s';
	select* from cliente where Produtor like '%i_';
	select* from cliente where Produtor like 'M%';

    

-- TABELA 2 SENSORES


create table plantacao(
	idPlantacao int primary key	auto_increment,
    hectares varchar(45),
    qtdPes int,
    fkCliente int,  constraint fkPlantacaoCliente foreign key (fkCliente) references cliente(idCliente)
    );

create table sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modelo varchar(45),
localizacao varchar(45),
dtInstalacao date,
fkPlantacao int,
constraint fkSensorPlantacao foreign key (fkPlantacao) references plantacao(idPlantacao)
);


create table registro(
idRegistro int primary key auto_increment,
umidade float,
temperatura float,
dtRegistro datetime,
fkSensor int,
constraint fkRegistroSensor foreign key (fkSensor) references sensor(idSensor)
);





select * from sensores;
select id, sensor from sensores;
select Temperatura FROM sensores;
select* from sensores where sensor = '%Temperatura%';
select* from sensores order by Temperatura;
select* from sensores order by Umidade_do_solo desc;
select* from sensores where Temperatura = 30;
select* from sensores where Umidade_do_solo = 20;
select* from sensores where Temperatura in(33,20);
select* from sensores where Umidade_do_solo in(25,20);
select* from sensores order by  Data_ desc;


-- tabela 3 regra de negocio

create database datacoffe;

use datacoffe;

create table regra(
id INT PRIMARY KEY AUTO_INCREMENT,
Pontos_do_café int NOT NULL,
temp int NOT NULL,
Umidade int NOT NULL,
valor_do_café int NOT NULL,
constraint Pontuacao check(Pontos_do_café>=0 and Pontos_do_café <=100)
);

insert into regra (id, Pontos_do_café, Temp, Umidade, valor_do_café) values
	(default, 75, 26, 13, 650),
    (default, 80, 21, 9, 650),
    (default, 85, 25, 10, 860),
    (default, 89, 24, 12, 3200),
    (default, 84, 23, 13,860),
    (default, 88, 26, 11, 1500);
    
	select * from regra;
    select id, valor_do_café from regra;
	select Temp, Pontos_do_café from regra;
    select Umidade FROM regra;
	select* from regra where valor_do_café = 650;
	select* from regra order by Pontos_do_café asc;
	select* from regra order by valor_do_café desc;
	select* from regra where Temp = 25;
	select* from regra where Umidade = 13;
	select* from regra where Temp in(26,25);
	select* from regra where Umidade in(13,11);
	select* from regra where valor_do_café in(650,860);
    select* from regra where valor_do_café >= 1500;