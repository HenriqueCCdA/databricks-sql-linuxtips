-- Databricks notebook source
-- Quais são os Top 5 vendedores campões de vendas de cada UF?

WITH tb_vendas AS (
  SELECT 
    t1.idVendedor,
    t2.descUF,
    sum(t1.vlPreco) AS receitaVendedor,
    count(*) AS qtVendaItens,
    count(distinct t1.idPedido) AS qtVendaPedidos

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.vendedor AS t2
  ON t1.idVendedor = t2.idVendedor

  GROUP BY  t1.idVendedor, t2.descUF
)

SELECT *,
      row_number() OVER (PARTITION BY descUF ORDER BY receitaVendedor DESC) AS rnReceitaVendedor,
      row_number() OVER (PARTITION BY descUF ORDER BY qtVendaPedidos DESC) AS rnVendaPedidos

FROM tb_vendas

QUALIFY rnVendaPedidos <= 5




-- COMMAND ----------

-- Quais são os Top 5 vendedores campões de vendas em cada categoria ?

WITH tb_pedidos AS (
  SELECT 
    t1.idVendedor,
    t2.descCategoria,
    count(DISTINCT t1.idPedido) AS qtPedido,
    count(*) AS qtItens

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  WHERE descCategoria IS NOT NULL

  GROUP BY idVendedor, descCategoria
)

SELECT *,
  row_number() OVER (PARTITION BY descCategoria ORDER BY qtItens DESC) AS rnItens

FROM tb_pedidos

QUALIFY rnItens <= 5


-- COMMAND ----------

-- Qual é a Top 1 categoria de cada vendedor?

WITH tb_itens AS (
  SELECT 
    t1.idVendedor,
    t2.descCategoria,
    count(*) AS qtItens

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  WHERE t2.descCategoria IS NOT NULL 

  GROUP BY t1.idVendedor, t2.descCategoria
)

SELECT *, 
  row_number() OVER (PARTITION BY idVendedor ORDER BY qtItens DESC) AS rnItem

FROM tb_itens

QUALIFY rnItem = 1

-- COMMAND ----------

-- Quais são as Top 2 categorias que mais vendem para clientes de cada estado ?

WITH tb_completa AS (
  SELECT * 

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  LEFT JOIN silver.olist.cliente AS t4
  ON t3.idCliente = t4.idCliente

  WHERE t2.descCategoria IS NOT null
), 

tb_group AS (
  SELECT 
    descUF,
    descCategoria,
    count(*) AS qtItens

  FROM tb_completa

  GROUP BY descUF, descCategoria

  ORDER BY descUF, descCategoria
)

SELECT *,
  row_number() OVER (PARTITION BY descUF ORDER BY qtItens DESC) AS rnItens

FROM tb_group





-- COMMAND ----------

-- Quantidade acumulada de itens vendidos por categoria ao longo do tempo.

WITH tb_vendas AS (
  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  WHERE t2.descCategoria IS NOT null
),

tb_group AS (
  SELECT descCategoria,
    date(dtPedido) AS dataPedido,
    count(*) AS qtItens
  FROM tb_vendas

  GROUP BY descCategoria, dataPedido
  ORDER BY descCategoria, dataPedido
)

SELECT *,
  SUM(qtItens) OVER (PARTITION BY descCategoria ORDER BY dataPedido ASC) AS qtAcumItens

FROM tb_group


-- COMMAND ----------

-- Receita acumulada de itens vendidos por categoria ao longo do tempo.

WITH tb_vendas AS (
  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  WHERE t2.descCategoria IS NOT null
),

tb_group AS (
  SELECT descCategoria,
    date(dtPedido) AS dataPedido,
    sum(vlPreco) AS vlReceita

  FROM tb_vendas

  GROUP BY descCategoria, dataPedido
  ORDER BY descCategoria, dataPedido
)

SELECT *,
  SUM(vlReceita) OVER (PARTITION BY descCategoria ORDER BY dataPedido ASC) AS receitaAcum

FROM tb_group
