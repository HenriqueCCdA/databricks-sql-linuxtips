-- Databricks notebook source
SELECT '2023-01-01'

-- COMMAND ----------

SELECT date_add('2023-01-01', 45)

-- COMMAND ----------

SELECT date_add('2023-01-01', -15)

-- COMMAND ----------

SELECT date_sub('2023-01-01', 15)

-- COMMAND ----------

SELECT add_months('2023-01-01', 12)

-- COMMAND ----------

SELECT year('2023-01-01')

-- COMMAND ----------

SELECT month('2023-01-01')

-- COMMAND ----------

SELECT day('2023-01-01')

-- COMMAND ----------

SELECT dayofweek('2023-01-01')

-- COMMAND ----------

SELECT datediff('2023-06-01', '2023-01-01')

-- COMMAND ----------

SELECT months_between('2023-06-01', '2023-01-01')

-- COMMAND ----------

SELECT *,
  datediff(dtEntregue, dtPedido)
FROM silver.olist.pedido

-- COMMAND ----------

SELECT idCliente,
       idCliente,
       dtPedido,
       dtEntregue,
       datediff(dtEntregue, dtPedido) as diasEntreEntregaPedido
FROM silver.olist.pedido

-- COMMAND ----------


