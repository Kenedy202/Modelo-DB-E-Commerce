
-- Criar banco
-- drop database ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela cliente
CREATE TABLE cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(25) NOT NULL,
    Sobrenome VARCHAR(30) NOT NULL,
    Tipo_de_cliente ENUM('PF','PJ') NOT NULL,
    Endereco VARCHAR(45) NOT NULL
);

-- Tabela cliente PF
CREATE TABLE cliente_pf (
    idCliente_PF INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Data_de_nascimento DATE NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE
);

-- Tabela cliente PJ
CREATE TABLE cliente_cnpj (
    idCliente_PJ INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    Razao_Social VARCHAR(30) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE
);

-- Tabela estoque
CREATE TABLE estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Nome_local VARCHAR(45) NOT NULL,
    Disponibilidade ENUM('DISPONÍVEL', 'RESERVADO', 'EM FALTA', 'EM TRÂNSITO') DEFAULT 'DISPONÍVEL'
);

-- Tabela produto
CREATE TABLE produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    idEstoque INT,
    Categoria ENUM('ELETRÔNICO', 'MODA E ACESSÓRIO', 'CASA E DECORAÇÃO', 'ESPORTE E LAZER', 'BRINQUEDO E JOGOS') NOT NULL,
    Tamanho ENUM('P','M','G'),
    Avaliacao FLOAT DEFAULT 0,
    Valor_Produto DECIMAL(10,2),
    FOREIGN KEY (idEstoque) REFERENCES estoque(idEstoque)
);

-- Tabela pedido
CREATE TABLE pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    Status_do_pedido ENUM('APROVADO', 'EM ANDAMENTO', 'NEGADO') NOT NULL DEFAULT 'EM ANDAMENTO',
    Descricao_do_Pedido VARCHAR(255),
    Valor_Pedido DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE
);

-- Tabela pedido_produto 
CREATE TABLE pedido_produto (
    idPedido INT NOT NULL,
    idProduto INT NOT NULL,
    Quantidade INT NOT NULL,
    PRIMARY KEY (idPedido, idProduto),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido) ON DELETE CASCADE,
    FOREIGN KEY (idProduto) REFERENCES produto(idProduto) ON DELETE CASCADE
);

-- Tabela pagamento
CREATE TABLE pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    Tipo_de_Pagamento ENUM('PIX', 'CARTÃO DE DÉBITO','CARTÃO DE CRÉDITO', 'BOLETO') NOT NULL,
    Status_doPagamento ENUM('PENDENTE', 'APROVADO', 'RECUSADO', 'CANCELADO') NOT NULL DEFAULT 'PENDENTE',
    Valor_pago DECIMAL(10,2) NOT NULL,
    Data_de_pagamento DATE,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido) ON DELETE CASCADE
);

-- Tabela fornecedor
CREATE TABLE fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Razao_Social VARCHAR(45) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL UNIQUE,
    Contato VARCHAR(20) NOT NULL 
);

-- Tabela fornecedor_produto (N:N entre fornecedor e produto)
CREATE TABLE fornecedor_produto (
    idFornecedor INT NOT NULL,
    idProduto INT NOT NULL, 
    Quantidade INT NOT NULL,
    PRIMARY KEY (idFornecedor, idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES fornecedor(idFornecedor) ON DELETE CASCADE,
    FOREIGN KEY (idProduto) REFERENCES produto(idProduto) ON DELETE CASCADE
);

-- Tabela fornecedor_terceiro
CREATE TABLE fornecedor_terceiro (
    idFornecedorTerceiro INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(14) UNIQUE,
    Contato VARCHAR(100)
);

-- Tabela fornecedor_terceiro_produto 
CREATE TABLE fornecedor_terceiro_produto (
    idFornecedorTerceiro INT NOT NULL,
    idProduto INT NOT NULL, 
    Quantidade INT NOT NULL,
    PRIMARY KEY (idFornecedorTerceiro, idProduto),
    FOREIGN KEY (idFornecedorTerceiro) REFERENCES fornecedor_terceiro(idFornecedorTerceiro) ON DELETE CASCADE,
    FOREIGN KEY (idProduto) REFERENCES produto(idProduto) ON DELETE CASCADE
);

-- Tabela entrega
CREATE TABLE entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    Metodo_entrega ENUM('MOTOBOY', 'CORREIOS', 'TRANSPORTADORA', 'RETIRADA') NOT NULL,
    Status_entrega ENUM('PENDENTE', 'EM ROTA', 'ENTREGUE', 'DEVOLVIDA') NOT NULL DEFAULT 'PENDENTE',
    Data_envio DATE,
    Data_entrega DATE
);

-- Tabela associativa entre pedido e entrega
CREATE TABLE pedido_entrega (
    idPedido INT NOT NULL,
    idEntrega INT NOT NULL,
    PRIMARY KEY (idPedido, idEntrega),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido) ON DELETE CASCADE,
    FOREIGN KEY (idEntrega) REFERENCES entrega(idEntrega) ON DELETE CASCADE
);


