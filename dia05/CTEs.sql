-- Databricks notebook source
SELECT *

FROM (
  SELECT *
  FROM silver.olist.pedido
  WHERE descSituacao = 'delivered'
  AND dtEntregue <= dtEstimativaEntrega
)


-- COMMAND ----------

WITH tb_pedidos_sem_atraso AS(
  SELECT *
  FROM silver.olist.pedido
  WHERE descSituacao = 'delivered'
  AND dtEntregue <= dtEstimativaEntrega
),

tb_produto_bebes AS (
  SELECT *
  FROM silver.olist.produto
  WHERE descCategoria = 'bebes'
)

SELECT * 

FROM tb_pedidos_sem_atraso AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

INNER JOIN tb_produto_bebes AS t3
ON t2.idProduto = t3.idProduto

-- COMMAND ----------

WITH tb_mes (
  SELECT
  -- IDENTIFICA MES COM MAIS VENDAS
  date(date_trunc('month', dtPedido)) AS dtMonth
  FROM silver.olist.pedido
  GROUP BY dtMonth
  ORDER BY count(distinct idPedido) DESC
  LIMIT 1
)


SELECT 
  t2.idVendedor,
  count(*) AS qtdeItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2

ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = (SELECT * FROM tb_mes)
GROUP BY t2.idVendedor
ORDER BY qtdeItens DESC

LIMIT 10

-- COMMAND ----------

WITH tb_vendedores (
  SELECT DISTINCT t2.idVendedor
  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

SELECT idVendedor,
  count(DISTINCT idPedido) AS qtdePedido

FROM silver.olist.item_pedido

WHERE idVendedor IN (SELECT * FROM tb_vendedores)

GROUP BY idVendedor

-- COMMAND ----------

WITH tb_vendedores_bf_bebes (

  SELECT DISTINCT t2.idVendedor
  
  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

SELECT t1.idVendedor,
  count(DISTINCT t1.idPedido) AS qtdePedido

FROM silver.olist.item_pedido AS t1

INNER JOIN tb_vendedores_bf_bebes AS t2
ON t1.idVendedor = t2.idVendedor

GROUP BY t1.idVendedor
ORDER BY qtdePedido DESC
