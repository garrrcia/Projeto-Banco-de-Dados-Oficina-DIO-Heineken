-- Criação do Banco de Dados 
CREATE DATABASE IF NOT EXISTS oficina_mecanica;
USE oficina_mecanica;

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    ID_Cliente INT,
    Modelo VARCHAR(100) NOT NULL,
    Marca VARCHAR(100) NOT NULL,
    Ano INT,
    Placa VARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    ID_Equipe INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Equipe VARCHAR(100)
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    ID_Mecanico INT PRIMARY KEY AUTO_INCREMENT,
    ID_Equipe INT,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255),
    Especialidade VARCHAR(100),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Tabela Ordem_de_Servico
CREATE TABLE Ordem_de_Servico (
    Numero_OS INT PRIMARY KEY AUTO_INCREMENT,
    ID_Veiculo INT,
    ID_Equipe INT,
    Data_Emissao DATE NOT NULL,
    Data_Entrega DATE,
    Valor_Total DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Tabela Servico
CREATE TABLE Servico (
    ID_Servico INT PRIMARY KEY AUTO_INCREMENT,
    Descricao TEXT NOT NULL,
    Valor_Mao_de_Obra DECIMAL(10, 2) NOT NULL
);

-- Tabela Item_OS (Relacionamento N:M entre Ordem_de_Servico e Servico)
CREATE TABLE Item_OS (
    Numero_OS INT,
    ID_Servico INT,
    Quantidade INT NOT NULL DEFAULT 1,
    Valor_Unitario DECIMAL(10, 2) NOT NULL,
    Valor_Total_Item DECIMAL(10, 2),
    PRIMARY KEY (Numero_OS, ID_Servico),
    FOREIGN KEY (Numero_OS) REFERENCES Ordem_de_Servico(Numero_OS),
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico)
);

-- Tabela Peca
CREATE TABLE Peca (
    ID_Peca INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT,
    Valor_Unitario DECIMAL(10, 2) NOT NULL
);

-- Tabela Item_Peca_OS (Relacionamento N:M entre Ordem_de_Servico e Peca)
CREATE TABLE Item_Peca_OS (
    Numero_OS INT,
    ID_Peca INT,
    Quantidade INT NOT NULL DEFAULT 1,
    Valor_Unitario DECIMAL(10, 2) NOT NULL,
    Valor_Total_Item DECIMAL(10, 2),
    PRIMARY KEY (Numero_OS, ID_Peca),
    FOREIGN KEY (Numero_OS) REFERENCES Ordem_de_Servico(Numero_OS),
    FOREIGN KEY (ID_Peca) REFERENCES Peca(ID_Peca)
);