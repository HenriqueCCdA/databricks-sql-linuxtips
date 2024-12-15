-- Databricks notebook source
WITH tb_rn AS (
  SELECT 
    idProduto,
    descCategoria,
    vlPesoGramas, 
    row_number() OVER (PARTITION BY descCategoria ORDER BY vlPesoGramas DESC) AS nrProduto
  FROM silver.olist.produto

  WHERE descCategoria IS NOT null
)

SELECT * 
FROM tb_rn
WHERE nrProduto <= 5

-- COMMAND ----------

WITH tb_rn AS (
  SELECT
    descCategoria,
    vlComprimentoCm * vlAlturaCm * vlLarguraCm AS volumeProduto,
    row_number() OVER (PARTITION BY descCategoria ORDER BY  vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC) AS nrProduto

  FROM silver.olist.produto

  WHERE descCategoria is NOT null
)

SELECT *
FROM tb_rn
WHERE nrProduto = 1



-- COMMAND ----------


