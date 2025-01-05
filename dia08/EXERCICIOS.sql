-- Databricks notebook source
-- 1)

DROP TABLE IF EXISTS sandbox.linuxtips.hcca;

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.hcca (
  ID INT,
  nome string,
  dta_nascimento date,
  profissao string,
  renda FLOAT,
  uf string,
  nacionalidade string
);


-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.hcca;

-- COMMAND ----------

-- 2 )
INSERT INTO sandbox.linuxtips.hcca
VALUES
  (1, "Maria", "1989-01-18", "Artesã", 1450.90, "MG", "Brasileira"),
  (2, "José", "1987-06-25", "Mecânico", 2756.87, "SP", "Brasileira"),
  (3, "Manoel", "1995-09-13", "Operador de máquinas pesadas", 3245.53, "SP", "Brasileira"),
  (4, "Antônia", "1991-02-28", "Tratorista", 3135.47, "SC", "Brasileira"),
  (5, "Maria Eduarda", "1985-12-29", "Serviço gerais", 1649.21, "BA", "Brasileira"),
  (6, "João de Deus", "1999-03-14", "Manobrista", 2375.78, "PE", "Brasileira"),
  (7, "Eduardo", "2003-05-04", "Atendente", 3157.06, "AM", "Haiti"),
  (8, "Mônica", "2006-10-09", "Estudante", 550.00, "SP", "Brasileira"),
  (9, "Bruno", "1998-02-26", "Encanador", 1459.98, "MG", "Brasileira"),
  (10, "Letícia", "1982-04-01", "Marceneira", 1698.74, "SP", "Angolana"),
  (11, "Tomé", "1971-07-31", "Porteiro", 2670.32, "SP", "Brasileira")
;



-- COMMAND ----------

-- 3
UPDATE sandbox.linuxtips.hcca SET renda =(
  SELECT round(renda * 1.15 , 2)
  FROM sandbox.linuxtips.hcca 
  WHERE id = 7
)  
WHERE ID = 7

-- COMMAND ----------

-- 4)
UPDATE sandbox.linuxtips.hcca SET renda = 2150, profissao = "Copeira" WHERE ID = 5

-- COMMAND ----------

-- 5)
DELETE FROM sandbox.linuxtips.hcca WHERE ID = 3

-- COMMAND ----------

-- 6)
UPDATE sandbox.linuxtips.hcca SET renda = round(renda * 1.05, 2)

-- COMMAND ----------

-- 7)
UPDATE sandbox.linuxtips.hcca SET renda = round(renda * 1.025, 2) 
WHERE nacionalidade != "Brasileira"
