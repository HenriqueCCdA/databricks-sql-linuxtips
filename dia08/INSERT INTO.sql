-- Databricks notebook source
CREATE TABLE sandbox.linuxtips.usuarios_hcca (
  id int,
  nome string,
  idade int
)

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_hcca (id, nome, idade) VALUES (1, "Henrique", "39")

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_hcca (id, nome, idade) VALUES 
(2, "Nah", "33"),
(3, "Maria", "1")

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.usuarios_hcca

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_hcca (id, nome) VALUES (4, 'JOSE')

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_hcca VALUES (5, 'João', 25)

-- COMMAND ----------

SELECT * from silver.olist.cliente limit 10

-- COMMAND ----------

CREATE TABLE sandbox.linuxtips.cliente_olist_hcca (
  id string,
  estado string
)

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.cliente_olist_hcca 

SELECT idCliente AS id, descUF as estado from silver.olist.cliente limit 10

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.cliente_olist_hcca
