-- Databricks notebook source
-- Qual pedido com maior valor de frete ? E o menor?

SELECT 
  idPedido,
  sum(vlFrete) AS totalFrete
FROM silver.olist.item_pedido 
GROUP BY idPedido

ORDER BY totalFrete DESC

-- COMMAND ----------

-- QUal vendor tem mais pedidos ?

SELECT 
  idVendedor,
  count(DISTINCT idVendedor) as qtPedidos
FROM silver.olist.item_pedido
GROUP BY idVendedor 
ORDER BY qtPedidos DESC


-- COMMAND ----------

-- 3. Qual vendedor tem mais itens vendidos? E o com menos?

SELECT idVendedor,
  count(idProduto) AS qtItens

FROM silver.olist.item_pedido

GROUP BY idVendedor
ORDER BY qtItens DESC



-- COMMAND ----------

-- 4. Qual dia tivemos mais pedidos?

SELECT 
  date(dtPedido) AS diaPedido,
  count(DISTINCT idPedido) AS qtPedido

FROM silver.olist.pedido

GROUP BY diaPedido
ORDER BY qtPedido DESC

-- COMMAND ----------

-- 5. Quantos vendedores são do estado de São Paulo?

SELECT 
  count(distinct idVendedor) as qtVendedor

FROM silver.olist.vendedor

WHERE descUF = 'SP'

-- COMMAND ----------

-- 6. Quantos vendedores são de Presidente prudente ?

SELECT
  count(DISTINCT idVendedor) AS qtVendedor

FROM silver.olist.vendedor

WHERE descCidade = 'presidente prudente'

-- COMMAND ----------

-- 7. Quantos clientes são do estado do Rio de Janeiro?

SELECT count(distinct idCliente) AS qtCliente

FROM silver.olist.cliente

WHERE descUF = 'RJ'



-- COMMAND ----------

-- 8. Quantos produtos são de construção?

SELECT 
  COUNT(distinct idProduto) AS qtProduto

FROM silver.olist.produto

WHERE descCategoria LIKE '%construcao%'

-- COMMAND ----------

-- 9. Qual o valor médio de um pedido? e do frete ?

SELECT 
  sum(vlPreco) / count(distinct idPedido) AS vlMedioPedido, -- valor médio pedido
  sum(vlFrete) / count(distinct idPedido) AS vlMedioFretePedido, -- preço médio frete pedido

  avg(vlPreco) AS avgPedido, -- valor médio item
  avg(vlFrete) AS avgFrete   -- peço médio frete por item
FROM silver.olist.item_pedido

-- COMMAND ----------

-- 10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?

SELECT 
  avg(nrParcelas) AS avgQtParcelas,
  avg(vlPagamento / nrParcelas) AS avgValorParcela 

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'

-- COMMAND ----------

-- 11. Quanto tempo tem média demora para um pedido chegar depois de aprovado?

SELECT 
  avg(datediff(dtEntregue, dtAprovado)) as qtDias
FROM silver.olist.pedido
WHERE descSituacao = 'delivered'

-- COMMAND ----------

-- 12 Qual estado tem mais vendedores?

SELECT descUF,
  count(DISTINCT idVendedor) AS qtVendedor
FROM silver.olist.vendedor
GROUP BY descUF
ORDER BY qtVendedor DESC

-- COMMAND ----------

-- 13. Qual cidade tem mais clientes?

SELECT descCidade,
  count(DISTINCT idCliente) as qtCliente, -- cliente que podem não ser unicos
  count(DISTINCT idClienteUnico) as qtClienteUnico -- cliente únicos
FROM silver.olist.cliente
GROUP BY descCidade
ORDER BY qtCliente DESC

-- COMMAND ----------

-- 14. Qual categoria que mais items?
SELECT descCategoria,
  count(DISTINCT idProduto) AS qtProduto
FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY qtProduto DESC

-- COMMAND ----------

-- 15. Qual caategoria tem maior peso médio de produto?
SELECT descCategoria,
  avg(vlPesoGramas) as pesoMedio
FROM silver.olist.produto
GROUP BY descCategoria
ORDER BY pesoMedio DESC

-- COMMAND ----------

-- 16. Qual a série histórica de pedidos por dia? E receitia?

SELECT 
  date(dtPedido) AS diaPedido,
  count(distinct idPedido) AS qtPedido
FROM silver.olist.pedido 
GROUP BY diaPedido
ORDER BY diaPedido

-- COMMAND ----------

-- 17. Qual o produto compeão de vendas?

SELECT idProduto,
  count(*) AS qtVenda,
  sum(vlPreco) as vlReceita
FROM silver.olist.item_pedido
GROUP BY idProduto
ORDER BY vlReceita DESC
