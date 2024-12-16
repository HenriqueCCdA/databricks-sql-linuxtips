-- Databricks notebook source
-- 1. Selecione todos os clientes paulistanos.

SELECT *

FROM silver.olist.cliente

WHERE descCidade = 'sao paulo'

-- COMMAND ----------

-- 2. Selecione todos os cliente paulistas.

SELECT *

FROM silver.olist.cliente

WHERE descUF = 'SP'


-- COMMAND ----------

-- 3. Selecione todos os vendedores cariocas e paulistas

SELECT *

FROM silver.olist.vendedor

WHERE descUF = 'SP' OR descCidade = 'rio de janeiro';

-- COMMAND ----------

-- 4. Selecione produtos de perfumaria e bebes com altura maior que 5 cm

SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('perfumaria', 'bebes') AND vlAlturaCm > 5;



-- COMMAND ----------

-- 5. Selecione os pedidos com mais de um item

SELECT *

FROM silver.olist.item_pedido

WHERE idPedidoItem > 1;


-- COMMAND ----------

-- 6. Selecione os pedidos que o frete é mais caro que o item.

SELECT *

FROM silver.olist.item_pedido

WHERE  vlFrete > vlPreco;

-- COMMAND ----------

-- 7. Listaa de pedidos qua ainda nãao foram enviados

SELECT *

FROM silver.olist.pedido

WHERE dtEnvio IS NULL;

-- COMMAND ----------

-- 8. Lista com pedidos com entrego com atraso

SELECT *

FROM silver.olist.pedido

WHERE date(dtEntregue) > date(dtEstimativaEntrega);

-- COMMAND ----------

-- 9. Lista de pedidos que forram entregues com 2 dias de antecedência.

SELECT * 

FROM silver.olist.pedido

WHERE datediff(date(dtEstimativaEntrega), date(dtEntregue)) = 2

-- COMMAND ----------

-- 10. Selecione os pedidos feitos em dezembro de 2017 e entregues com atraso.

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017 AND month(dtPedido) = 12 AND date(dtEntregue) > date(dtEstimativaEntrega);



-- COMMAND ----------

-- 11. Selecione os pedidos com avaliação maior ou igual que 4

SELECT *

FROM silver.olist.avaliacao_pedido

WHERE vlNota >= 4;

-- COMMAND ----------

-- 12. Selecione pedidos pagos co cartão de crédito com duas ou mais parcelas menores que R$ 40.00

SELECT *

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card' AND nrParcelas >=2 AND vlPagamento / 2 < 40.00;

-- COMMAND ----------


