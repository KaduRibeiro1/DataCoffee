
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

select * from usuario;

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
    
 INSERT INTO Usuario (nome, dtNascimento, cpf, genero, email, senha, fkEmpresa, fkSupervisor) 
VALUES 
('João Silva', '1990-01-01', '12345678901', 'Masculino', 'joao.silva@gmail.com', 'cafeDoBom', 1, NULL),
('Maria Souza', '1992-05-15', '23456789012', 'Feminino', 'maria.souza@outlook.com', 'cafeDosDeuses', 1, 1),
('Ana Pereira', '1988-08-22', '34567890123', 'Não Binario', 'ana.pereira@yahoo.com', 'cafeSaboroso', 1, 1);


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


INSERT INTO Registro (fkSensor, registro, dtRegistro) 
VALUES 
( 1, 25, '2024-11-27 01:10:00'),
(2,70,'2024-11-27 01:10:00'),
(1,40,'2024-11-27 03:10:00'),
(2,50,'2024-11-27 03:10:00');


    
