-- Databricks notebook source
SELECT 
  count(*),
  count(1)
FROM silver.olist.pedido

-- COMMAND ----------

SELECT count(descSituacao), -- linhas não nulas deste campo (descSituacao)
       count(DISTINCT descSituacao) -- linhas distintas do campo descSituacao
FROM silver.olist.pedido


-- COMMAND ----------

SELECT count(idPedido), -- linhas não nula para idPedido
  count(distinct idPedido) -- linhas distintasa para idPedido
FROM silver.olist.pedido

