-- ЗАДАЧИ НА ПОВТОРЕНИЕ

-- 1. Отдел маркетинга готовит программу лояльности. Директору нужен отчет, который покажет самую крупную покупку в каждой товарной категории. 
-- Но это еще не всё: чтобы понять паттерн поведения этих VIP-клиентов, директор хочет видеть рядом с этим рекордным чеком 
-- сумму предыдущей покупки этого же самого клиента
with top as (
	select c.first_name, p.product_name, p.category,
		p.price * o.quantity as "выручка", -- общая сумма покупки каждого клинта
		dense_rank() over(partition by p.category order by p.price desc) as "топ по покупкам", -- топ по покупкам в каждой категории
		lag(price) over(partition by c.first_name order by o.order_date ) as "предыдущая покупка" -- предыдущая покупка клиента
	from products p
	join orders o on o.product_id = p.product_id
	join customers c on c.customer_id = o.customer_id
)
select first_name, product_name, category, "выручка", "топ по покупкам", "предыдущая покупка"
from top
where "топ по покупкам" = 1;


-- Бизнес-кейс: Маркетологам нужно найти «аномально крупные» заказы. 
-- Они хотят увидеть только те чеки, выручка которых выше или равна средней выручке по всем заказам этого же самого клиента.

with anom as (
	select c.first_name, p.product_name, p.price * o.quantity as "выручка",
		avg(p.price * o.quantity) over(partition by c.first_name) as "среднее"
	from products p
	join orders o on p.product_id = o.product_id
	join customers c on c.customer_id = o.customer_id
)
select first_name, product_name, "выручка", "среднее"
from anom
where "выручка" >= "среднее";


























