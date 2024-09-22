-- Databricks notebook source
SELECT *,
  CASE 
    WHEN vlPreco <= 100 THEN '000 -| 100'
    WHEN vlPreco <= 200 THEN '100 -| 200'
    ELSE '>200'
  END AS fxPreco
FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT *,
  CASE
    WHEN vlFrete / (vlFrete + vlPreco) = 0 THEN 'Frete Gratuito'
    WHEN vlFrete / (vlFrete + vlPreco) <= 0.2 THEN 'Frete Baixo'
    WHEN vlFrete / (vlFrete + vlPreco) <= 0.4 THEN 'Frete Médio'
    ELSE 'Frete Alto'
  END AS descFrete
FROM silver.olist.item_pedido


-- COMMAND ----------

SELECT *,
  CASE 
    WHEN descUF IN ('SC', ' PR', 'RS') THEN 'Sul'
    WHEN descUF IN ('SP', ' MG', 'RJ', 'ES') THEN 'Sudeste'
  END as descRegiao
FROM silver.olist.cliente

-- COMMAND ----------

SELECT *,
  CASE WHEN descUF = 'SP' THEN ' Paulista'
  ELSE 'Não mapeado'
  END as descNacilalidade
FROM silver.olist.vendedor
