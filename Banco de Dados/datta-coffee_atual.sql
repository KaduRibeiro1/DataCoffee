create database datacoffe;


use datacoffe;


create table Empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(100)NOT NULL,
cnpj char(14) NOT NULL,
cep char(8) NOT NULL,
uf char(2),
cidade varchar(45),
logradouro varchar(60),
bairro varchar(45),
numero int NOT NULL,
complemento varchar(100),
Email varchar(100) NOT NULL,
codigo_de_ativacao varchar(50) NOT NULL
);

INSERT INTO Empresa (razao_social, cnpj, cep, uf, cidade, logradouro, bairro, numero, complemento, Email, codigo_de_ativacao) 
VALUES 
('FriezzaLTDA', '12345678000100', '12345678', 'SP', 'São Paulo', 'Rua das Flores', 'Centro', 100, 'Próximo ao metro', 'friezza@gmail.com', 'COD12345');

create table usuario(
	idUsuario int primary key auto_increment,
    nome varchar(45),
    dtNascimento date,
    cpf char(11),
    genero varchar(45),
    email varchar(100),
    senha varchar(100),
    tipo varchar(100),
    constraint chkTipo check (tipo in ('cliente', 'master')),
    fkEmpresa int,
    fkSupervisor int ,
    constraint fkSupervisorusuario foreign key (fkSupervisor) references usuario(idUsuario), 
    constraint fkEmpresaUsuario foreign key (fkEmpresa) references empresa(idEmpresa),
    constraint chkGenero check (genero in ('Masculino', 'Feminino', 'Não Binario'))
    );
    
 INSERT INTO Usuario (nome, dtNascimento, cpf, genero, email, senha, fkEmpresa, fkSupervisor,tipo) 
VALUES 
('João Silva', '1990-01-01', '12345678901', 'Masculino', 'joao.silva@gmail.com', 'cafeDoBom', 1, NULL,'cliente'),
('Maria Souza', '1992-05-15', '23456789012', 'Feminino', 'maria.souza@outlook.com', 'cafeDosDeuses', 1, 1,'cliente'),
('Ana Pereira', '1988-08-22', '34567890123', 'Não Binario', 'ana.pereira@yahoo.com', 'cafeSaboroso', 1, 1,'master');



create table plantacao(
	idPlantacao int primary key auto_increment,
    hectares decimal(10,2) not null,
    qtdPes int,
    fkEmpresa int not null,
    constraint fkEmpresaPlantacao foreign key (fkEmpresa)
    references empresa(idEmpresa)
    );

INSERT INTO Plantacao (hectares, qtdPes, fkEmpresa) 
VALUES 
(50.5, 1000, 1),
(30.0, 800, 1);

INSERT INTO Plantacao (hectares, qtdPes, fkEmpresa) 
VALUES 
(20, 2000,1);


create table sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modelo VARCHAR(45) NOT NULL,
dtInstalacao DATE NOT NULL,
fkPlantacao INT NOT NULL,
constraint fkPlantacaoSensor foreign key (fkPlantacao) references plantacao(idPlantacao)
);

INSERT INTO Sensor (modelo,  dtInstalacao, fkPlantacao) 
VALUES 
('LM35','2024-01-01', 1),
('Sensor de Umidade', '2024-02-01', 1);


create table registro(
idRegistro INT  auto_increment,
fkSensor int,
constraint pkRegistro primary key (idRegistro, fkSensor),
registro decimal (4,2),
dtRegistro datetime,
constraint fkSensorRegistro foreign key (fkSensor) references sensor(idSensor)
);
select * from registro;
INSERT INTO Registro (fkSensor, registro, dtRegistro) VALUES
-- Dia 2024-11-27
(1, 22, '2024-11-27 08:00:00'), (2, 70, '2024-11-27 08:00:00'),
(1, 25, '2024-11-27 12:00:00'), (2, 75, '2024-11-27 12:00:00'),
(1, 18, '2024-11-27 16:00:00'), (2, 68, '2024-11-27 16:00:00'),
(1, 20, '2024-11-27 20:00:00'), (2, 72, '2024-11-27 20:00:00'),

-- Dia 2024-11-28
(1, 21, '2024-11-28 08:00:00'), (2, 74, '2024-11-28 08:00:00'),
(1, 24, '2024-11-28 12:00:00'), (2, 80, '2024-11-28 12:00:00'),
(1, 19, '2024-11-28 16:00:00'), (2, 69, '2024-11-28 16:00:00'),
(1, 23, '2024-11-28 20:00:00'), (2, 73, '2024-11-28 20:00:00'),

-- Dia 2024-11-29
(1, 20, '2024-11-29 08:00:00'), (2, 68, '2024-11-29 08:00:00'),
(1, 26, '2024-11-29 12:00:00'), (2, 78, '2024-11-29 12:00:00'),
(1, 17, '2024-11-29 16:00:00'), (2, 65, '2024-11-29 16:00:00'),
(1, 22, '2024-11-29 20:00:00'), (2, 71, '2024-11-29 20:00:00'),

-- Dia 2024-11-30
(1, 18, '2024-11-30 08:00:00'), (2, 72, '2024-11-30 08:00:00'),
(1, 27, '2024-11-30 12:00:00'), (2, 85, '2024-11-30 12:00:00'),
(1, 21, '2024-11-30 16:00:00'), (2, 74, '2024-11-30 16:00:00'),
(1, 19, '2024-11-30 20:00:00'), (2, 77, '2024-11-30 20:00:00'),

-- Dia 2024-12-01
(1, 23, '2024-12-01 08:00:00'), (2, 70, '2024-12-01 08:00:00'),
(1, 28, '2024-12-01 12:00:00'), (2, 79, '2024-12-01 12:00:00'),
(1, 24, '2024-12-01 16:00:00'), (2, 75, '2024-12-01 16:00:00'),
(1, 20, '2024-12-01 20:00:00'), (2, 69, '2024-12-01 20:00:00'),

-- Dia 2024-12-02
(1, 19, '2024-12-02 08:00:00'), (2, 65, '2024-12-02 08:00:00'),
(1, 25, '2024-12-02 12:00:00'), (2, 82, '2024-12-02 12:00:00'),
(1, 22, '2024-12-02 16:00:00'), (2, 78, '2024-12-02 16:00:00'),
(1, 21, '2024-12-02 20:00:00'), (2, 70, '2024-12-02 20:00:00'),

-- Dia 2024-12-03 (Hoje)
(1, 20, '2024-12-03 08:00:00'), (2, 68, '2024-12-03 08:00:00'),
(1, 22, '2024-12-03 12:00:00'), (2, 76, '2024-12-03 12:00:00'),
(1, 18, '2024-12-03 16:00:00'), (2, 65, '2024-12-03 16:00:00'),
(1, 21, '2024-12-03 20:00:00'), (2, 71, '2024-12-03 20:00:00');



