-- Criação de Banco de Dados do software

CREATE DATABASE IF NOT EXISTS PI_JardinagemPaisagismo;

USE PI_JardinagemPaisagismo;

-- Criar tabela Usuário
CREATE TABLE IF NOT EXISTS Usuario (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Senha VARCHAR(255),
    Tipo VARCHAR(50),
    UNIQUE (ID)
);

-- Criar tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Sobrenome VARCHAR(255),
    CPFCNPJ VARCHAR(20),
    DataNascimento DATE
);

-- Criar tabela EnderecoCliente
CREATE TABLE Endereco (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Rua_Avenida VARCHAR(100),
    numero INT,
    bairro VARCHAR(50),
    cep VARCHAR(10),
    id_cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela EmailCliente
CREATE TABLE Email (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255),
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela TelefoneCliente
CREATE TABLE Telefone (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Telefone_Fixo VARCHAR(20),
    Telefone_Cel VARCHAR(20),
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela Serviço
CREATE TABLE Servico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10,2),
    Disponibilidade TINYINT(1),
    UNIQUE (ID)
);

-- Criar tabela PacoteServico
CREATE TABLE PacoteServico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10,2),
    Disponibilidade TINYINT(1),
    UNIQUE (ID)
);

-- Criar tabela Agendamento
CREATE TABLE Agendamento (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    ID_Servico INT,
    ID_PacoteServico INT,
    Data DATE,
    Hora TIME,
    Local VARCHAR(255),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID),
    FOREIGN KEY (ID_PacoteServico) REFERENCES PacoteServico(ID),
    UNIQUE (ID)
);

-- Criar tabela OrdemServico
CREATE TABLE OrdemServico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Agendamento INT,
    Status VARCHAR(50),
    FormaPagamento VARCHAR(50),
    FOREIGN KEY (ID_Agendamento) REFERENCES Agendamento(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela RelatorioServico
CREATE TABLE RelatorioServico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_OrdemServico INT,
    Texto TEXT,
    Arquivo BLOB,
    DataEnvio DATE,
    FOREIGN KEY (ID_OrdemServico) REFERENCES OrdemServico(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela ClienteInadimplente
CREATE TABLE ClienteInadimplente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    ValorDevido DECIMAL(10,2),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela NotaFiscal
CREATE TABLE NotaFiscal (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_OrdemServico INT,
    DataEmissao DATE,
    Valor DECIMAL(10,2),
    FOREIGN KEY (ID_OrdemServico) REFERENCES OrdemServico(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela HistoricoAcesso
CREATE TABLE HistoricoAcesso (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Data DATE,
    Hora TIME,
    TipoAcesso VARCHAR(50),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);

-- Criar tabela PesquisaSatisfacao
CREATE TABLE PesquisaSatisfacao (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_OrdemServico INT,
    Link VARCHAR(255),
    DataEnvio DATE,
    FOREIGN KEY (ID_OrdemServico) REFERENCES OrdemServico(ID) ON DELETE CASCADE,
    UNIQUE (ID)
);


-- Populando a tabela Usuario
INSERT INTO Usuario (Nome, Senha, Tipo) VALUES
    ('Carlos', 'C@123', 'Gerente'),
    ('Ariane', 'Ab@363', 'Atendente'),
    ('Claudia', '7901d@do', 'Atendente'),
    ('Felipe', 'Darth123', 'Atendente'),
    ('Fatima', '759fin3', 'Financeiro'),
    ('Cleide', '3645R3', 'Financeiro'),
    ('Luiz', '54223', 'Jardineiro'),
    ('Afonso', '75823', 'Jardineiro'),
    ('Leoncio', '47592', 'Jardineiro'),
    ('Cleonice', '185243', 'Paisagista'),
    ('Charles', '85423', 'Paisagista'),
    ('Lisandra', '78663', 'Paisagista');

-- Populando a tabela Cliente
INSERT INTO Cliente (Nome, Sobrenome, CPFCNPJ, DataNascimento) VALUES
   ('João', 'Silva', '123.456.789-01', '1990-01-15'),
    ('Maria', 'Santos', '987.654.321-01', '1985-03-22'),
    ('Carlos', 'Oliveira', '456.789.123-01', '1992-07-10'),
    ('Ana', 'Pereira', '789.012.345-01', '1980-12-05'),
    ('Rodrigo', 'Almeida', '234.567.890-01', '1995-09-18'),
    ('Juliana', 'Lima', '567.890.123-01', '1988-04-30'),
    ('Felipe', 'Costa', '901.234.567-01', '1993-11-25'),
    ('Camila', 'Martins', '345.678.901-01', '1987-06-08'),
    ('Gustavo', 'Pereira', '678.901.234-01', '1998-02-14'),
    ('Fernanda', 'Souza', '012.345.678-01', '1983-08-03');

-- Populando a tabela endereço cliente
INSERT INTO Endereco (Rua_Avenida, numero, bairro, cep, ID_Cliente) VALUES
	('Rua A', 123, 'Centro', '12200-000', 1),
    ('Avenida B', 456, 'Jardim Bela Vista', '12211-111', 2),
    ('Rua C', 789, 'Vila Industrial', '12222-222', 3),
    ('Avenida D', 101, 'Bosque dos Eucaliptos', '12233-333', 4),
    ('Rua E', 202, 'Jardim das Flores', '12244-444', 5),
    ('Avenida F', 303, 'Parque Industrial', '12255-555', 6),
    ('Rua G', 404, 'Jardim Satélite', '12266-666', 7),
    ('Avenida H', 505, 'Campo dos Alemães', '12277-777', 8),
    ('Rua I', 606, 'Altos de Santana', '12288-888', 9),
    ('Avenida J', 707, 'Bosque dos Ipês', '12299-999', 10);

-- Populando a tabela email cliente
INSERT INTO Email (Email, ID_Cliente) VALUES
    ('joaosilva@gmail.com', 1),
    ('marias321@gmail.com', 2),
    ('oliveirac@gmail.com', 3),
    ('pereiraana@outlook.com', 4),
    ('rodrigo25@gmail.com', 5),
    ('lima658@outlook.com', 6),
    ('felipecos@yahoo.com', 7),
    ('martins58@yahoo.com', 8),
    ('gustavo853@outlook.com', 9),
    ('souzafer@gmail.com', 10);

-- Populando a tabela telefone cliente
INSERT INTO Telefone (Telefone_Fixo, Telefone_Cel, ID_Cliente) VALUES
    ('(012) 3951-1111', '(012) 99104-2222', 1),
    ('(012) 3525-3333', '(012) 99265-4444', 2),
    ('(012) 3952-5555', '(012) 99728-6666', 3),
    ('(012) 3951-7777', '(012) 99191-8888', 4),
    ('(012) 3952-9999', '(012) 99747-0000', 5),
    ('(012) 3955-1125', '(012) 99118-2622', 6),
    ('(012) 3952-3443', '(012) 99748-4433', 7),
    ('(012) 3953-2355', '(012) 99758-6276', 8),
    ('(012) 3952-7227', '(012) 99748-8828', 9),
    ('(012) 3956-9942', '(012) 99142-1235', 10);

-- Populando a tabela Servico com dados de jardinagem
INSERT INTO Servico (Nome, Descricao, Preco, Disponibilidade) VALUES
    ('Manutenção de Jardim', 'Podas, adubação e cuidados gerais', 150.00, 1),
    ('Projeto de Paisagismo', 'Desenvolvimento de projeto personalizado', 500.00, 1),
    ('Controle de Pragas', 'Aplicação de inseticidas e fungicidas', 120.00, 1),
    ('Plantio de Flores e Arbustos', 'Seleção e plantio de espécies adequadas', 100.00, 1);

-- Populando a tabela PacoteServico com pacotes relacionados a paisagismo
INSERT INTO PacoteServico (Nome, Descricao, Preco, Disponibilidade) VALUES
    ('Pacote Básico de Jardinagem', 'Manutenção mensal do jardim', 300.00, 1),
    ('Pacote Avançado de Paisagismo', 'Projeto personalizado + Manutenção', 800.00, 1),
    ('Pacote Completo de Paisagismo', 'Projeto, Manutenção e Controle de Pragas', 1000.00, 1),
    ('Pacote Especial de Flores', 'Seleção, Plantio e Manutenção', 400.00, 1);

-- Populando a tabela Agendamento
INSERT INTO Agendamento (ID_Cliente, ID_Servico, ID_PacoteServico, Data, Hora, Local) VALUES
    (1, 1, NULL, '2024-02-10', '09:00:00', 'Residência do Cliente 1'),
    (2, 2, 3, '2024-02-15', '14:30:00', 'Residência do Cliente 2'),
    (3, 4, 4, '2024-02-20', '10:00:00', 'Residência do Cliente 3'),
    (4, 3, NULL, '2024-02-25', '11:30:00', 'Residência do Cliente 4');

-- Populando a tabela OrdemServico
INSERT INTO OrdemServico (ID_Agendamento, Status, FormaPagamento) VALUES
    (1, 'Agendado', 'Cartão de Crédito'),
    (2, 'Concluído', 'Dinheiro'),
    (3, 'Pendente', 'Transferência Bancária'),
    (4, 'Agendado', 'Boleto Bancário');

-- Populando a tabela RelatorioServico
INSERT INTO RelatorioServico (ID_OrdemServico, Texto, Arquivo, DataEnvio) VALUES
    (1, 'Serviço de manutenção de jardim realizado com sucesso.', NULL, '2024-02-10'),
    (2, 'Projeto de paisagismo concluído conforme especificações.', NULL, '2024-02-15'),
    (3, 'Pacote completo de paisagismo em espera de confirmação de pagamento.', NULL, '2024-02-20'),
    (4, 'Controle de pragas agendado para a próxima semana.', NULL, '2024-02-25');

-- Populando a tabela ClienteInadimplente
INSERT INTO ClienteInadimplente (ID_Cliente, ValorDevido) VALUES
    (3, 200.00),
    (7, 50.00),
    (10, 120.00);

-- Populando a tabela NotaFiscal
INSERT INTO NotaFiscal (ID_OrdemServico, DataEmissao, Valor) VALUES
    (1, '2024-02-11', 150.00),
    (2, '2024-02-16', 800.00),
    (3, '2024-02-21', 1000.00),
    (4, '2024-02-26', 120.00);

-- Populando a tabela HistoricoAcesso
INSERT INTO HistoricoAcesso (ID_Usuario, Data, Hora, TipoAcesso) VALUES
    (1, '2024-02-01', '08:30:00', 'Login'),
    (2, '2024-02-02', '09:15:00', 'Logout'),
    (3, '2024-02-03', '10:00:00', 'Login'),
    (4, '2024-02-04', '11:45:00', 'Logout'),
    (5, '2024-02-05', '12:30:00', 'Login'),
    (6, '2024-02-06', '13:15:00', 'Logout');

-- Populando a tabela PesquisaSatisfacao
INSERT INTO PesquisaSatisfacao (ID_OrdemServico, Link, DataEnvio) VALUES
    (1, 'https://pesquisa.com/1', '2024-02-12'),
    (2, 'https://pesquisa.com/2', '2024-02-17'),
    (3, 'https://pesquisa.com/3', '2024-02-22'),
    (4, 'https://pesquisa.com/4', '2024-02-27');
	
    
    
    -- Questões de segurança, incluindo usuários, papéis e permissões

    
-- Criação de usuário específico, concessão de permissões mínimas necessárias

CREATE USER IF NOT EXISTS 'app_user'@'localhost' IDENTIFIED BY 'senha_segura';

GRANT SELECT, INSERT, UPDATE, DELETE ON PI_JardinagemPaisagismo.* TO 'app_user'@'localhost';



	-- Estou usando um procedimento armazenado (AgendarServico), que é uma prática segura. No entanto, vou melhorar a utilização de Prepared Statements nas consultas diretas também, usando um procedimento armazenado para SELECTs:

DELIMITER //

CREATE PROCEDURE SelectClienteDetalhado (IN cliente_id INT)
BEGIN
    SET @query = CONCAT('SELECT * FROM ViewClienteDetalhado WHERE ID = ', cliente_id);
    PREPARE statement FROM @query;
    EXECUTE statement;
    DEALLOCATE PREPARE statement;
END //

DELIMITER ;

	-- Estou usando senhas em formato de texto plano, vou melhorar utilizando hash para armazenar senhas, no entanto, requer mudanças no lado da aplicação para lidar com a autenticação usando senhas hash.
	
-- Modificando a tabela Usuario para armazenar senhas como hash

ALTER TABLE Usuario MODIFY Senha VARCHAR(255) NOT NULL;

	-- Atualizando senhas existentes para utilizar hash (caso apresente erro, será necessário  aba "Edit" > "Preferences" > "SQL Editor", e no fim da pagina NÂO deixar marcado o item "Safe Updates", para funcionar.)

-- Atualizando senhas existentes para utilizar hash

UPDATE Usuario SET Senha = MD5(Senha);
	
   
	-- Views:

-- View para listar informações de Clientes com seus Endereços, E-mails e Telefones:   
CREATE VIEW  ViewClienteDetalhado AS
SELECT c.ID, c.Nome, c.Sobrenome, c.CPFCNPJ, c.DataNascimento,
       e.Rua_Avenida, e.numero, e.bairro, e.cep,
       em.Email,
       t.Telefone_Fixo, t.Telefone_Cel
FROM Cliente c
JOIN Endereco e ON c.ID = e.ID_Cliente
JOIN Email em ON c.ID = em.ID_Cliente
JOIN Telefone t ON c.ID = t.ID_Cliente;

-- View para listar informações de Agendamentos com detalhes de Serviços:
CREATE VIEW ViewAgendamentoDetalhado AS
SELECT a.ID, c.Nome AS NomeCliente, s.Nome AS NomeServico, ps.Nome AS NomePacote,
       a.Data, a.Hora, a.Local
FROM Agendamento a
JOIN Cliente c ON a.ID_Cliente = c.ID
LEFT JOIN Servico s ON a.ID_Servico = s.ID
LEFT JOIN PacoteServico ps ON a.ID_PacoteServico = ps.ID;


	-- Stored Procedures:


-- Procedure para Agendar Serviço:
DELIMITER //

CREATE PROCEDURE  AgendarServico (
    IN cliente_id INT,
    IN servico_id INT,
    IN pacote_id INT,
    IN data_agendamento DATE,
    IN hora_agendamento TIME,
    IN local_agendamento VARCHAR(255)
)
BEGIN
    INSERT INTO Agendamento (ID_Cliente, ID_Servico, ID_PacoteServico, Data, Hora, Local)
    VALUES (cliente_id, servico_id, pacote_id, data_agendamento, hora_agendamento, local_agendamento);
END //

DELIMITER ;


	-- Functions:


-- Function para Calcular Valor Total de Serviços em uma Ordem de Serviço:
DELIMITER //

CREATE FUNCTION CalcularTotalServicos (ordem_id INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT COALESCE(SUM(s.Preco), 0)
    INTO total
    FROM Servico s
    JOIN Agendamento a ON s.ID = a.ID_Servico
    JOIN OrdemServico os ON a.ID = os.ID_Agendamento
    WHERE os.ID = ordem_id;
    RETURN total;
END //

DELIMITER ;


	-- índice composto na tabela Agendamento
	
CREATE INDEX idx_Agendamento_Cliente_Servico_Pacote ON Agendamento (ID_Cliente, ID_Servico, ID_PacoteServico);
