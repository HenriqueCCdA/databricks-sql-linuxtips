-- Databricks notebook source
SELECT *
FROM silver.olist.pedido
LIMIT 10

-- COMMAND ----------

SELECT *,
  vlPreco + vlFrete AS vlTotal
FROM silver.olist.item_pedido
LIMIT 10

-- COMMAND ----------

SELECT idPedido,
       idProduto,
       vlPreco,
       vlFrete,
       vlPreco + vlFrete AS vlTotal
FROM silver.olist.item_pedido
