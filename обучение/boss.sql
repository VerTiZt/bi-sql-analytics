-- Генеральный директор хочет оценить эффективность региональных менеджеров. 
-- Ему нужен лаконичный отчет, где видно, сколько менеджер принес компании в целом, 
-- и какая конкретно единичная сделка (чек) стала его личным рекордом.

with rank_managers as ( -- cte чтобы отфильтровать ранг
	select s.product_name, s.category, m.manager_name, s.region,
	s.price * s.quantity as "Прибыль",
	sum(s.price * s.quantity) over (partition by m.manager_name) as summ, -- общая сумма у каждого менеджера
	rank() over ( -- ранг менеджеров по деньгам
		partition by m.manager_name
		order by s.price * s.quantity desc
	) as top1
	from sales_mart s
	join region_managers m on m.region = s.region -- соединяю две таблицы по общему региону
	where s.status = 'Completed'
)
select product_name, category, manager_name, region, "Прибыль" as "топ 1 прибыль", summ as "общая прибыль"
from rank_managers
where top1 = 1
order by summ desc;
