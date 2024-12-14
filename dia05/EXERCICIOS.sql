-- Databricks notebook source
-- 1. Qual a nota (média, mínima e máxima) de cada vendendor que tiveram vendas no ano 2017? E o percentual de pedidos avaliados com nota 5? 
WITH tb_pedidos AS (
  SELECT 
    DISTINCT t1.idPedido,
    t2.idVendedor
  
    FROM silver.olist.pedido AS t1

    INNER JOIN silver.olist.item_pedido AS t2
    ON t1.idPedido = t2.idPedido

    WHERE year(dtPedido) = 2017
), 

tb_avaliacoes AS (
    SELECT *,
      CASE WHEN vlNota = 5 THEN 1 ELSE 0 END AS flNota5

    FROM tb_pedidos AS t1

    INNER JOIN silver.olist.avaliacao_pedido AS t2
    ON t1.idPedido = t2.idPedido
)

SELECT 
  idVendedor,
  avg(vlNota) AS avgNota,
  max(vlNota) AS maxNota,
  min(vlNota) AS mingNota,
  avg(flNota5) AS pctNota5,
  avg(CASE WHEN vlNota = 5 THEN 1 ELSE 0 END) AS pctNota5_v2
FROM tb_avaliacoes

GROUP BY idVendedor

-- COMMAND ----------

-- Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30
WITH tb_item_pedido ( 
  SELECT t2.idPedido,
    t2.idVendedor,
    t2.vlPreco

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido <= '2017-06-30'
), 

tb_pedido_receita AS (
  SELECT idVendedor,
    idPedido,
    sum(vlPreco) AS vlTotal,
    count(*)

  FROM tb_item_pedido

  GROUP BY idVendedor, idPedido
),

tb_final AS (
  SELECT idVendedor,
    avg(vlTotal) AS avgValorPedido,
    min(vlTotal) AS minValorPedido,
    max(vlTotal) AS maxValorPedido

  FROM tb_pedido_receita

  GROUP BY idVendedor
)

SELECT * FROM tb_final




-- COMMAND ----------

WITH tb_pedido_receita ( 
  SELECT t2.idPedido,
    t2.idVendedor,
    sum(t2.vlPreco) AS vlTotal

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido <= '2017-06-30'

  GROUP BY t2.idVendedor, t2.idPedido
), 

tb_final AS (
  SELECT idVendedor,
    avg(vlTotal) AS avgValorPedido,
    min(vlTotal) AS minValorPedido,
    max(vlTotal) AS maxValorPedido

  FROM tb_pedido_receita

  GROUP BY idVendedor
)

SELECT * FROM tb_final

-- COMMAND ----------

-- 3. Calcule a quantidade de peditos por meio de pagamento que cada vendedor teve em seus pedidos entre 2017-01-01 e 2017-06-30

WITH tb_pedido_vendedor AS (
  SELECT 
    DISTINCT t2.idPedido,
    t2.idVendedor

  FROM silver.olist.pedido AS T1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido < '2017-07-01'
),

td_pedido_pagamento AS (

  SELECT 
    t1.idVendedor,
    t1.idPedido,
    t2.descTipoPagamento

  FROM tb_pedido_vendedor AS t1

  LEFT JOIN silver.olist.pagamento_pedido AS t2
  ON t1.idPedido = t2.idPedido
)

SELECT 
  idVendedor,
  descTipoPagamento,
  count(DISTINCT idPedido)
FROM td_pedido_pagamento


GROUP BY idVendedor, descTipoPagamento
ORDER BY idVendedor, descTipoPagamento

-- COMMAND ----------

WITH tb_pedido_receita (
  SELECT 
    t2.idPedido,
    t2.idVendedor,
    sum(vlPreco) AS vlReceita

  FROM silver.olist.pedido AS T1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido < '2017-07-01'

  GROUP BY t2.idVendedor, t2.idPedido
),

tb_sumario_pedidos AS (
  SELECT 
    idVendedor,
    avg(vlReceita) AS avgReceita,
    min(vlReceita) AS minReceita,
    max(vlReceita) AS maxgReceita

  FROM tb_pedido_receita 

  GROUP BY idVendedor  
),

tb_pedido_pagamento AS (

  SELECT 
    t1.idVendedor,
    t2.descTipoPagamento,
    count(DISTINCT t1.idPedido) AS qtdePedido

  FROM tb_pedido_receita AS t1

  LEFT JOIN silver.olist.pagamento_pedido AS t2
  ON t1.idPedido = t2.idPedido

  GROUP BY t1.idVendedor, t2.descTipoPagamento
  ORDER BY t1.idVendedor, t2.descTipoPagamento
),

tb_pagamento_coluna AS (
  SELECT 
    idVendedor,
    SUM(CASE WHEN descTipoPagamento = 'boleto' THEN qtdePedido END) AS qtdeBoleto,
    SUM(CASE WHEN descTipoPagamento = 'credit_card' THEN qtdePedido END) AS qtdeCreditCard,
    SUM(CASE WHEN descTipoPagamento = 'voucher' THEN qtdePedido END) AS qtdeVoucher,
    SUM(CASE WHEN descTipoPagamento = 'debit_card' THEN qtdePedido END) AS qtdeDebitCard

  FROM tb_pedido_pagamento

  GROUP BY idVendedor
)

SELECT 
  t1.*,
  t2.qtdeBoleto,
  t2.qtdeCreditCard,
  t2.qtdeVoucher,
  t2.qtdeDebitCard

FROM tb_sumario_pedidos AS t1

LEFT JOIN tb_pagamento_coluna AS t2
ON t1.idVendedor = t2.idVendedor
