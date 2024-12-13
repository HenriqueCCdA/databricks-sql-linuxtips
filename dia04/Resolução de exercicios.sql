-- Databricks notebook source
-- Qual categoria tem mais produtos vendidos?

SELECT 
  t2.descCategoria, 
  count(*) as qtdeCategoria,
  count(DISTINCT t1.idPedido) as qtdePedidos
  
FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2

ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY qtdeCategoria DESC

-- COMMAND ----------

-- 2) Qual categoria que tem productos mais caros, em média ? E mediana?

SELECT 
  t2.descCategoria, 
  AVG(t1.vlPreco) as avgPreco,
  percentile(t1.vlPreco, 0.5) as medianPreco

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2

ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY medianPreco DESC

LIMIT 1


-- COMMAND ----------

-- 3) Qual categoria tem maiores valores de frete, em média?

SELECT 
  t2.descCategoria, 
  AVG(t1.vlFrete) as avgFrete

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2

ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY avgFrete DESC

LIMIT 1

-- COMMAND ----------

-- 4) Os clientes de que estado pagama mais frete, em média?

SELECT 
  t3.descUF,
  sum(t1.vlFrete) / count(DISTINCT t1.idPedido) as avgFrete,
  avg(t1.vlFrete) as avgFreteItem,
  sum(t1.vlFrete) / count(DISTINCT t2.idCliente) avgFreteCliente

FROM silver.olist.item_pedido AS t1

INNER JOIN silver.olist.pedido AS t2 

ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3

ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF
ORDER BY avgFrete DESC


-- COMMAND ----------

-- 5) Cliente de quais estados valia melhor, em média ? Proporção de 5 ?

SELECT 
  t3.descUF,
  avg(t1.vlNota) AS avgNota,
  avg(CASE WHEN t1.vlNota = 5 THEN 1 ELSE 0 END) AS prop5
  
FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.pedido AS t2

ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3

ON t3.idCliente = t2.idCliente

GROUP BY t3.descUF

ORDER BY avgNota DESC

-- COMMAND ----------

-- Vendedores de quais estados tem as piores reputações ?

SELECT 
  t3.descUF,
  avg(t1.vlNota) AS avgNota

FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

GROUP BY t3.descUF
ORDER BY avgNota ASC

LIMIT 1

-- COMMAND ----------

-- Quais estados de clientes levam mais tempo para a mercadoria chegar?

SELECT 
  t2.descUF,
  avg(datediff(t1.dtEntregue, t1.dtPedido)) as qtdeDias

FROM silver.olist.pedido as t1

LEFT JOIN silver.olist.cliente as t2
ON t1.idCliente = t2.idCliente

WHERE dtEntregue IS NOT NULL

GROUP BY t2.descUF

ORDER BY qtdeDias DESC

-- COMMAND ----------

-- Qual meio de pagamento é mais utilizado por clientes RJ?

SELECT 
  t1.descTipoPagamento,
  count(DISTINCT t1.idPedido) as qtdePedidos

FROM silver.olist.pagamento_pedido AS t1

INNER JOIN silver.olist.pedido AS t2

ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3

ON t2.idCliente = t3.idCliente

WHERE t3.descUF = 'RJ'

GROUP BY t1.descTipoPagamento

ORDER BY qtdePedidos DESC

-- COMMAND ----------

-- Qual estado sai mais ferramentas ?

SELECT 
  t3.descUF,
  count(*) as qtdeProdutoVendido

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

LEFT JOIN silver.olist.vendedor AS t3
ON t1.idVendedor = t3.idVendedor

WHERE t2.descCategoria ILIKE '%ferramentas%'

GROUP BY t3.descUF

ORDER BY qtdeProdutoVendido DESC

-- COMMAND ----------

-- Qual estado tem mais compras por cliente?

SELECT 
  count(DISTINCT t1.idPedido) as qtdePedido,
  count(DISTINCT t2.idClienteUnico) as qtdeClienteUnico,
  count(DISTINCT t1.idPedido) / count(DISTINCT t2.idClienteUnico) as avgPedidoCliente,
  t2.descUF

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t2.descUF

ORDER BY avgPedidoCliente DESC  

-- COMMAND ----------

SELECT 
  t1.idVendedor,
  count(t1.idVendedor)

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2

ON t1.idProduto = t2.idProduto

WHERE t2.descCategoria = 'pcs'

GROUP BY(t1.idVendedor)


