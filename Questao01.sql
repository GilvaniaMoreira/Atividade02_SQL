CREATE DATABASE saida_vendas;

USE saida_vendas;

CREATE TABLE vendas(
ID_NF INT NOT NULL,
ID_ITEM INT NOT NULL,
COD_PROD INT NOT NULL,
VALOR_UNIT REAL NOT NULL,
QUANTIDADE INT NOT NULL,
DESCONTO INT
);

INSERT INTO vendas
VALUES 
(1, 1, 1, 25.00, 10, 5),
(1, 2, 2, 13.50, 3, null),
(1, 3, 3, 15.00, 2, null),
(1, 4, 4, 10.00, 1, null),
(1, 5, 5, 30.00, 1, null),
(2, 1, 3, 15.00, 4, null),
(2, 2, 4, 10.00, 5, null),
(2, 3, 5, 30.00, 7, null),
(3, 1, 1, 25.00, 5, null),
(3, 2, 4, 10.00, 4, null),
(3, 3, 5, 30.00, 5, null),
(3, 4, 2, 13.50, 7, null),
(4, 1, 5, 30.00, 10, 15),
(4, 2, 4, 10.00, 12, 5),
(4, 3, 1, 25.00, 13, 5),
(4, 4, 2, 13.50, 15, 5),
(5, 1, 3, 15.00, 3, null),
(5, 2, 5, 30.00, 6, null),
(6, 1, 1, 25.00, 22, 15),
(6, 2, 3, 15.00, 25, 20),
(7, 1, 1, 25.00, 10, 3),
(7, 2, 2, 13.50, 10, 4),
(7, 3, 3, 15.00, 10, 4),
(7, 4, 5, 30.00, 10, 1);

# a) Consulta dos itens vendidos sem desconto
select  ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT 
from vendas 
where DESCONTO is null;

# b) Consulta dos itens vendidos com desconto
select  ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_UNIT-(VALOR_UNIT*(DESCONTO/100)) as VALOR_VENDIDO 
from vendas 
where DESCONTO is not null;

# c) Alterando os valores null para 0
SET SQL_SAFE_UPDATES = 0;
UPDATE vendas
SET DESCONTO = 0
WHERE DESCONTO is null;


# Verificando a alteração de null para 0
select * from vendas;

# d) Consulta de valores vendidos
select ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, DESCONTO,  VALOR_UNIT-(VALOR_UNIT*(DESCONTO/100)) as VALOR_VENDIDO, (QUANTIDADE *VALOR_UNIT) as VALOR_TOTAL 
from vendas 
where DESCONTO > 0;

# e) Consulta do valor total das NF ordenado do maior para o menor e agrupado por ID_NF
select ID_NF, (QUANTIDADE *VALOR_UNIT) as VALOR_TOTAL
from vendas 
group by ID_NF
order by VALOR_TOTAL desc;

# f) Consulta do valor vendido das NF ordenado do maior para o menor
select ID_NF, VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)) as VALOR_VENDIDO
from vendas 
group by ID_NF
order by VALOR_VENDIDO desc;

# g) Consulta do produto mais vendido, agrupado por COD_PROD
select COD_PROD, QUANTIDADE
from vendas
group by COD_PROD;

# h) Consulta das NF vendidas mais de 10 unidades de pelo menos um produto agrupado por ID_NF e COD_PROD
select  ID_NF, COD_PROD, QUANTIDADE
from vendas
where QUANTIDADE = 10
group by ID_NF,COD_PROD;

# i) Consulta valor total das NF maior que 500, ordenado do maior pro menor e agrupado por ID_NF
select ID_NF, (QUANTIDADE * VALOR_UNIT) as VALOR_TOTAL
from vendas
group by ID_NF
having VALOR_TOTAL > 500
order by VALOR_TOTAL desc;

# j) Consulta do valor médio dos descontos por produto agrupado por COD_PROD
select COD_PROD, avg(DESCONTO) as MEDIA_DESCONTO
from vendas
group by COD_PROD;


# k) Consulta menor, maior e media dos descontos por produto agrupado por COD_PROD
select COD_PROD, min(DESCONTO) as "MENOR", max(DESCONTO) as "MAIOR", avg(DESCONTO) as "MÉDIA"
from vendas
group by COD_PROD;

# l) Consulta NF mais de 3 itens agrupado por ID_NF
select ID_NF, count(QUANTIDADE) AS "QTD_ITENS"
from vendas
group by ID_NF
having QTD_ITENS > 3;

select * from vendas;

