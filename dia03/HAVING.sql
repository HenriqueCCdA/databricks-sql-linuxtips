-- Databricks notebook source
SELECT 
  descCategoria,
  count(DISTINCT idProduto) AS qtdProduto,
  avg(vlPesoGramas) as avgPeso

FROM silver.olist.produto

WHERE descCategoria in ('bebes', 'perfumaria', 'moveis_decoracao')
OR descCategoria like '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100

AND  avgPeso > 1000

ORDER BY descCategoria DESC

-- COMMAND ----------


