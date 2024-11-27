
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



select * from plantacao;


create table sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modelo VARCHAR(45) NOT NULL,
setor VARCHAR(45),
dtInstalacao DATE NOT NULL,
fkPlantacao INT NOT NULL,
constraint fkPlantacaoSensor foreign key (fkPlantacao) references plantacao(idPlantacao)
);

INSERT INTO Sensor (modelo, setor, dtInstalacao, fkPlantacao) 
VALUES 
('LM35', 'Setor Norte', '2024-01-01', 1),
('Sensor de Umidade', 'Setor Norte', '2024-02-01', 1),
('LM35', 'Setor Sul', '2024-01-01', 1),
('Sensor de Umidade', 'Setor Sul', '2024-02-01', 1),
('LM35', 'Setor Norte', '2024-01-01', 2),
('Sensor de Umidade', 'Setor Norte', '2024-02-01', 2),
('LM35', 'Setor Sul', '2024-01-01', 2),
('Sensor de Umidade', 'Setor Sul', '2024-02-01', 2);


SELECT 
        sensor.modelo, 
        registro,
        dtRegistro
        FROM Registro join sensor
        on registro.fkSensor = sensor.idSensor
        where sensor.modelo = 'Sensor de Umidade' and DATE(dtRegistro) = CURDATE() 
        ORDER BY  dtRegistro desc;


create table registro(
idRegistro INT ,
fkSensor int,
constraint pkRegistro primary key (idRegistro, fkSensor),
registro decimal (4,2),
dtRegistro datetime,
constraint fkSensorRegistro foreign key (fkSensor) references sensor(idSensor)
);

ALTER TABLE REGISTRO modify column idRegistro int auto_increment;
select * from registro;
INSERT INTO Registro (fkSensor, registro, dtRegistro) 
VALUES 
( 1, 25, '2024-11-27 01:10:00');  -- Registro de temperatura

select * from registro;

(3, 1, 24.8, '2024-06-02 16:00:00'),  -- Registro de temperatura
(4, 2, 62.0, '2024-06-02 16:00:00'),  -- Registro de umidade
(5, 3, 26.5, '2024-06-02 17:00:00'),  -- Registro de temperatura
(6, 4, 59.3, '2024-06-02 17:00:00'),  -- Registro de umidade
(7, 3, 27.1, '2024-06-02 18:00:00'),  -- Registro de temperatura
(8, 4, 61.8, '2024-06-02 18:00:00');  -- Registro de umidade


SELECT 
    e.razao_social AS Empresa,
    p.hectares,
    p.qtdPes
FROM 
    Empresa e
JOIN 
    Plantacao p ON e.idEmpresa = p.fkEmpresa;
    
    
SELECT 
    e.razao_social AS Empresa,
    p.hectares AS Hectares,
    s.modelo AS ModeloSensor,
    s.setor AS Setor,
    s.dtInstalacao AS DataInstalacao
FROM 
    Empresa e
JOIN 
    Plantacao p ON e.idEmpresa = p.fkEmpresa
JOIN 
    Sensor s ON p.idPlantacao = s.fkPlantacao;
    
    
    
SELECT 
    e.razao_social AS Empresa,
    p.hectares AS Hectares,
    s.modelo AS ModeloSensor,
    r.registro AS ValorMedido,
    r.dtRegistro AS DataRegistro
FROM 
    Empresa e
JOIN 
    Plantacao p ON e.idEmpresa = p.fkEmpresa
JOIN 
    Sensor s ON p.idPlantacao = s.fkPlantacao
JOIN 
    Registro r ON s.idSensor = r.fkSensor;
    
    
SELECT 
    e.razao_social AS Empresa,
    p.hectares AS Hectares,
    COUNT(s.idSensor) AS QuantidadeSensores
FROM 
    Empresa e
JOIN 
    Plantacao p ON e.idEmpresa = p.fkEmpresa
LEFT JOIN 
    Sensor s ON p.idPlantacao = s.fkPlantacao
GROUP BY 
    e.razao_social, p.hectares;


SELECT 
    e.razao_social AS Empresa,
    p.hectares AS Hectares,
    s.modelo AS ModeloSensor,
    r.registro AS ValorMedido,
    r.dtRegistro AS DataRegistro
FROM 
    Empresa e
JOIN 
    Plantacao p ON e.idEmpresa = p.fkEmpresa
JOIN 
    Sensor s ON p.idPlantacao = s.fkPlantacao
JOIN 
    Registro r ON s.idSensor = r.fkSensor
WHERE 
    r.dtRegistro = (
        SELECT MAX(r2.dtRegistro) 
        FROM Registro r2 
        WHERE r2.fkSensor = s.idSensor
    );


SELECT 
    s.idSensor,
    s.modelo AS ModeloSensor,
    MAX(r.registro) AS TemperaturaMaxima,
    MIN(r.registro) AS TemperaturaMinima
FROM 
    Sensor s
JOIN 
    Registro r ON s.idSensor = r.fkSensor
WHERE 
    s.modelo = 'LM35'
GROUP BY 
    s.idSensor;
    

SELECT 
    s.idSensor,
    s.modelo AS ModeloSensor,
    MAX(r.registro) AS TemperaturaMaxima,
    MIN(r.registro) AS TemperaturaMinima
FROM 
    Sensor s
JOIN 
    Registro r ON s.idSensor = r.fkSensor
WHERE 
    s.modelo = 'Sensor de Umidade'
GROUP BY 
    s.idSensor;
    
-- Registros de Temperatura para sensores LM35
INSERT INTO Registro (idRegistro, fkSensor, registro, dtRegistro) VALUES 
(9, 1, 24.5, '2024-06-02 19:00:00'),
(10, 1, 25.2, '2024-06-02 20:00:00'),
(11, 3, 26.1, '2024-06-02 15:00:00'),
(12, 3, 24.8, '2024-06-02 16:00:00'),
(13, 5, 23.9, '2024-06-02 17:00:00'),
(14, 5, 25.5, '2024-06-02 18:00:00');

-- Registros de Umidade para sensores de umidade
INSERT INTO Registro (idRegistro, fkSensor, registro, dtRegistro) VALUES 
(15, 2, 60.2, '2024-08-02 19:00:00'),
(16, 2, 58.5, '2024-06-02 20:00:00'),
(17, 4, 59.1, '2024-06-02 15:00:00'),
(18, 4, 61.3, '2024-06-02 16:00:00'),
(19, 6, 60.7, '2024-06-02 17:00:00'),
(20, 6, 59.9, '2024-06-02 18:00:00');



SELECT 
    r.idRegistro,
    r.fkSensor,
    MAX(r.registro) AS TemperaturaMaxima,
    MIN(r.registro) AS TemperaturaMinima,
    dtRegistro
FROM 
    Registro r
JOIN 
    Sensor s ON r.fkSensor = s.idSensor
WHERE 
    s.modelo = 'LM35'
GROUP BY 
    r.idRegistro, r.fkSensor
ORDER BY dtRegistro;

SELECT 
    r.idRegistro,
    r.fkSensor,
    MAX(r.registro) AS TemperaturaMaxima,
    MIN(r.registro) AS TemperaturaMinima,
    dtRegistro
FROM 
    Registro r
JOIN 
    Sensor s ON r.fkSensor = s.idSensor
WHERE 
    s.modelo = 'Sensor de umidade'
GROUP BY 
    r.idRegistro, r.fkSensor
ORDER BY dtRegistro;


SELECT * FROM plantacao whERE fkempresa = idEmpresa;

select * from usuario;

SELECT idUsuario, nome, dtNascimento, cpf, genero, email, senha, fkEmpresa as empresaID, fkSupervisor FROM usuario;

        SELECT idUsuario, nome, email, senha, fkEmpresa as Empresa FROM usuario WHERE email = 'joao.silva@gmail.com' AND senha = 'cafeDoBom';
        
        
SELECT 
	sensor.modelo, 
	registro,
    dtRegistro
	FROM Registro join sensor
	on registro.fkSensor = sensor.idSensor
	where sensor.modelo = 'LM35'
	ORDER BY  dtRegistro desc
    limit 7;
	

select * from usuario;