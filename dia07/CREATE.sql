-- Databricks notebook source
CREATE TABLE sandbox.linuxtips.top5_pedido_hcca AS (
  SELECT * FROM silver.olist.pedido LIMIT 5
) 



-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.top5_pedido_hcca

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top5_pedido_hcca AS (
  SELECT * FROM silver.olist.pedido 
  ORDER BY rand()
  LIMIT 5
) 

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top50_pedido_hcca AS (
  SELECT idPedido FROM silver.olist.pedido 
  ORDER BY rand()
  LIMIT 50
) 

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.top50_pedido_hcca

-- COMMAND ----------

CREATE TABLE sandbox.linuxtips.nova_tabela_vazia_hcca (
  descNome string,
  vlIdade int,
  vlSalario float
)

-- COMMAND ----------

CREATE TABLE 
