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

    
insert into cliente values
(default,'José da Silva', 'Fazenda Boa Vista', '12345678000123', 'SP', 'jose.silva@example.com', 'senha123'),
(default,'Maria de Souza', 'Sítio das Flores', '98765432000189', 'MG', 'maria.souza@example.com', 'senha456'),
(default,'João Oliveira', 'Chácara Oliveira', '10293847560123', 'RS', 'joao.oliveira@example.com', 'senha789'),
(default,'Ana Pereira', 'Fazenda Esperança', '56473829100145', 'PR', 'ana.pereira@example.com', 'senha101'),
(default,'Carlos Lima', 'Fazenda Horizonte', '87654321000156', 'GO', 'carlos.lima@example.com', 'senha202');

SELECT * FROM cliente;

create table usuario(
	idUsuario int primary key auto_increment,
    nomeUsuario varchar(45),
    senha varchar(45),
    fkCliente int,
    fksupervisor int ,
    constraint fksupervisorusuario foreign key (fksupervisor) references usuario(idUsuario), 
    constraint fkClienteUsuario foreign key (fkCliente) references cliente(idCliente)
    );
    
select * from usuario;
    
insert into usuario values
(default,'Supervisor José', 'senhaJose', 1, NULL),
(default,'Supervisor Maria', 'senhaMaria', 2, NULL);

insert into usuario values 
(default,'Usuario João', 'senhaJoao', 3, 1), 
(default,'Usuario Ana', 'senhaAna', 4, 2),   
(default,'Usuario Carlos', 'senhaCarlos', 5, 1);



create table plantacao(
	idPlantacao int primary key auto_increment not null,
    hectares float,
    qtdPes int,
    fkCliente int not null,
    constraint fkClientePlantacao foreign key (fkCliente)
    references cliente(idCliente)
    );
    
insert into plantacao values
(default,1, 150.5, 12000),  
(default,2, 200.0, 18000),  
(default,3, 75.8, 9000),    
(default,4, 300.3, 25000),  
(default,5, 125.6, 15000);

select * from plantacao;

create table sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modelo varchar(45),
localizacao varchar(45),
dtInstalacao date,
fkPlantacao int,
constraint fkPlantacaoSensor foreign key (fkPlantacao) references plantacao(idPlantacao)
);


insert into sensor (modelo, localizacao, dtInstalacao, fkPlantacao)
values 
('LM 35', 'Norte', '2023-03-15', 1),
('Sensor de Umidade de Solo', 'Sul', '2023-04-10', 2),
('LM 35', 'Leste', '2023-05-20', 3),
('Sensor de Umidade de Solo', 'Oeste', '2023-06-05', 4),
('LM 35', 'Centro', '2023-07-12', 5);


create table registro(
idRegistro int auto_increment,
fkSensor int,
constraint pkRegistro primary key (idRegistro, fkSensor),
umidade float,
temperatura float,
dtRegistro datetime,
fkKPI int,
constraint fkKPIRegistro foreign key (fkKPI) references KPI(idKPI),
constraint fkSensorRegistro foreign key (fkSensor) references sensor(idSensor)
);

select * from registro;
	
insert into registro values 
(default,65.2, 28.5, '2023-09-01 08:30:00', 1),
(default,70.1, 30.2, '2023-09-01 09:00:00', 2),
(default,68.3, 29.8, '2023-09-01 09:30:00', 3),
(default,72.0, 31.1, '2023-09-01 10:00:00', 4),
(default,66.5, 27.9, '2023-09-01 10:30:00', 5);


create table KPI(
	idKPI int primary key auto_increment not null,
	tipo varchar(45),
    minimo decimal,
    maximo decimal,
	media decimal
    );

insert into KPI (tipo, minimo, maximo, media) values
('Umidade Ideal', 60.0, 80.0, 70.0),
('Temperatura Ideal', 25.0, 30.0, 27.5),
('Umidade Crítica', 40.0, 59.9, 50.0),
('Temperatura Crítica', 30.1, 35.0, 32.5),
('Umidade Alta', 80.1, 100.0, 90.0);

select * from KPI;

-- Mostrar dados das plantações e seus respectivos clientes:
select 
    c.Produtor, 
    c.Propriedade, 
    p.hectares, 
    p.qtdPes
from 
    cliente c
join 
    plantacao p on c.idCliente = p.fkCliente;
    
    
 -- Mostrar sensores instalados em cada plantação com detalhes do cliente e localização do sensor:

select 
    c.Produtor, 
    c.Propriedade, 
    s.modelo, 
    s.localizacao, 
    s.dtInstalacao
from 
    cliente c
join 
    plantacao p on c.idCliente = p.fkCliente
join 
    sensor s on p.idPlantacao = s.fkPlantacao;

-- Mostrar registros de umidade e temperatura de cada sensor com informações da plantação e do cliente:

select 
    c.Produtor, 
    c.Propriedade, 
    s.modelo as ModeloSensor, 
    r.umidade, 
    r.temperatura, 
    r.dtRegistro
from 
    cliente c
join 
    plantacao p on c.idCliente = p.fkCliente
join 
    sensor s on p.idPlantacao = s.fkPlantacao
join 
    registro r on s.idSensor = r.fkSensor;

-- Mostrar as plantações de cada cliente com detalhes do número de sensores instalados em cada plantação:
select 
    c.Produtor, 
    c.Propriedade, 
    p.hectares, 
    count(s.idSensor) as qtdSensores
from 
    cliente c
join 
    plantacao p on c.idCliente = p.fkCliente
left join 
    sensor s on p.idPlantacao = s.fkPlantacao
group by 
    c.Produtor, c.Propriedade, p.hectares;
    
    -- Mostrar os últimos registros de cada sensor para cada cliente:
    
    select 
    c.Produtor, 
    c.Propriedade, 
    s.modelo, 
    r.umidade, 
    r.temperatura, 
    r.dtRegistro
from 
    cliente c
join 
    plantacao p on c.idCliente = p.fkCliente
join 
    sensor s on p.idPlantacao = s.fkPlantacao
join 
    registro r on s.idSensor = r.fkSensor
where 
    r.dtRegistro = (
        select max(r2.dtRegistro) 
        from registro r2 
        where r2.fkSensor = s.idSensor
    );
    
     -- Mostrar as plantações e sensores instalados para cada cliente com suas respectivas datas de instalação:
select 
    c.Produtor, 
    c.Propriedade, 
    p.hectares, 
    s.modelo, 
    s.localizacao, 
    s.dtInstalacao
from 
    cliente c
join 
    plantacao p on c.idCliente = p.fkCliente
join 
    sensor s on p.idPlantacao = s.fkPlantacao
order by 
    s.dtInstalacao desc;
select * from registro;

show tables;



