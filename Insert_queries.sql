USE ecommerce;

-- Tabela Cliente
INSERT INTO cliente (Nome, Sobrenome, Tipo_de_cliente, Endereco)
VALUES 
('Ana', 'Silva', 'PF', 'Rua A, 123'),
('Carlos', 'Souza', 'PJ', 'Av. Central, 456'),
('Fernanda', 'Lima', 'PF', 'Rua B, 789');

-- Tabela Cliente_PF
INSERT INTO cliente_pf (idCliente, CPF, Data_de_nascimento)
VALUES
(1, '12345678901', '1990-05-12'),
(3, '32165498700', '1985-11-23');

-- Tabela Cliente_PJ
INSERT INTO cliente_cnpj (idCliente, CNPJ, Razao_Social)
VALUES
(2, '11222333444455', 'Carlos Tech LTDA');

-- Tabela Estoque
INSERT INTO estoque (Nome_local, Disponibilidade)
VALUES 
('Estoque SP', 'DISPONÍVEL'),
('Estoque RJ', 'RESERVADO');

-- Tabela Produto
INSERT INTO produto (idEstoque, Categoria, Tamanho, Avaliacao, Valor_Produto)
VALUES 
(1, 'ELETRÔNICO', NULL, 4.5, 1500.00),
(2, 'MODA E ACESSÓRIO', 'M', 4.0, 89.90),
(1, 'ESPORTE E LAZER', NULL, 5.0, 499.99);

-- Tabela Pedido
INSERT INTO pedido (idCliente, Status_do_pedido, Descricao_do_Pedido, Valor_Pedido)
VALUES 
(1, 'APROVADO', 'notebook', 1500.00),
(2, 'EM ANDAMENTO', 'Pedido empresarial', 89.90),
(3, 'APROVADO', ' bicicleta', 499.99),
(1, 'NEGADO', 'Pedido cancelado', 200.00);

-- Tabela Pedido_Produto 
INSERT INTO pedido_produto (idPedido, idProduto, Quantidade)
VALUES 
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 2, 2);

-- Tabela Pagamento 
INSERT INTO pagamento (idPedido, Tipo_de_Pagamento, Status_doPagamento, Valor_pago, Data_de_pagamento)
VALUES 
(1, 'PIX', 'APROVADO', 1500.00, '2024-12-01'),
(2, 'BOLETO', 'PENDENTE', 89.90, NULL),
(3, 'CARTÃO DE CRÉDITO', 'APROVADO', 499.99, '2024-12-03');

-- Quantos pedidos foram feitos por cada cliente?
SELECT c.idCliente, CONCAT(c.Nome, ' ', c.Sobrenome) AS Nome_Completo, COUNT(p.idPedido) AS Total_Pedidos
FROM cliente c
LEFT JOIN pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente, c.Nome, c.Sobrenome;

-- Tabela Fornecedor 
INSERT INTO fornecedor (Razao_Social, CNPJ, Contato)
VALUES 
('TechFornece LTDA', '99999999999999', '11999999999'),
('ModaBrasil', '88888888888888', '21988888888');

-- Tabela Fornecedor_Produto
INSERT INTO fornecedor_produto (idFornecedor, idProduto, Quantidade)
VALUES 
(1, 1, 10),
(2, 2, 50);

-- Tabela Fornecedor_Terceiro
INSERT INTO fornecedor_terceiro (Nome, CNPJ, Contato)
VALUES
('Esportes Terceiros', '77777777777777', '11977777777');

-- Tabela Fornecedor_ Terceiro_Produto
INSERT INTO fornecedor_terceiro_produto (idFornecedorTerceiro, idProduto, Quantidade)
VALUES
(1, 3, 20);

-- Relação de produtos, fornecedores e estoques
SELECT p.idProduto, p.Categoria, e.Nome_local AS Estoque, f.Razao_Social AS Fornecedor, fp.Quantidade
FROM produto p
JOIN estoque e ON p.idEstoque = e.idEstoque
JOIN fornecedor_produto fp ON p.idProduto = fp.idProduto
JOIN fornecedor f ON fp.idFornecedor = f.idFornecedor;

--  Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.Razao_Social AS Fornecedor, p.Categoria AS Produto, p.Valor_Produto
FROM fornecedor f
JOIN fornecedor_produto fp ON f.idFornecedor = fp.idFornecedor
JOIN produto p ON fp.idProduto = p.idProduto
UNION
SELECT ft.Nome AS Fornecedor_Terceiro, p.Categoria AS Produto, p.Valor_Produto
FROM fornecedor_terceiro ft
JOIN fornecedor_terceiro_produto ftp ON ft.idFornecedorTerceiro = ftp.idFornecedorTerceiro
JOIN produto p ON ftp.idProduto = p.idProduto;

-- Tabela Entega 
INSERT INTO entrega (Metodo_entrega, Status_entrega, Data_envio, Data_entrega)
VALUES 
('CORREIOS', 'ENTREGUE', '2024-12-02', '2024-12-05'),
('MOTOBOY', 'EM ROTA', '2024-12-04', NULL);


-- Tabela Pedido_Entega 
INSERT INTO pedido_entrega (idPedido, idEntrega)
VALUES 
(1, 1),
(2, 2);




