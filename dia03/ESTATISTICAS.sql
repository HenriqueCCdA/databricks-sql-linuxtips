-- Databricks notebook source
SELECT  
  avg(vlPreco),              -- média aritimética
  min(vlPreco),              -- mínimo de um campo
  percentile(vlPreco, 0.25),
  max(vlFrete),              -- máximo de frete pago,
  std(vlFrete),              -- desvio padrão
  percentile(vlFrete, 0.5),  -- mediana
  avg(vlFrete),               -- média

  sum(vlPreco) / count(vlPreco)  --
FROM silver.olist.item_pedido
