-- ТЕОРИЯ
ФУНКЦИЯ() OVER (
    PARTITION BY колонка_группировки -- 1. «Комнаты»: на какие группы делим данные
    ORDER BY колонка_сортировки      -- 2. «Порядок»: в каком порядке обходим строки в комнате
    ROWS BETWEEN ... AND ...         -- 3. «Фрейм»: сколько строк до/после текущей захватываем
)
-- PARTITION BY - аналог group by

-- ПРИМЕР
-- мы хотим вывести каждый заказ из нашей витрины sales_mart, 
-- но рядом с ценой чека добавить справочную колонку с общей суммарной выручкой 
-- по всему региону этого заказа
SELECT 
    sale_id,
    product_name,
    region,
    price * quantity AS order_revenue,
    SUM(price * quantity) OVER(PARTITION BY region) AS total_region_revenue
FROM sales_mart;


-- ЗАДАЧА
-- Склад хочет проанализировать успешно завершенные сделки (status = 'Completed') 
-- в витрине sales_mart и проранжировать чеки внутри каждой отдельной товарной 
-- категории
select
	sale_date, category, product_name, quantity,
	row_number() over ( -- раздаёт строкам порядковые номера
	partition by category
	order by quantity desc
	) as "порядковый номер внутри категории"
from sales_mart
where status = 'Completed';

-- что, если у двух чеков одинаковое кол-во купленных товаров?
-- row_number() даст им разные номера, но это неправильно
select
	sale_date, category, product_name, quantity,
	rank() over ( -- проставляет порядковый номер по order by
	partition by category
	order by quantity desc -- (если одинаковый quantity - одинаковый номер)
	)
from sales_mart
where status = 'Completed';

-- rank() выбросила порядковый номер 3
-- (бизнесу нужно, чтобы нумерация шла строго по порядку)
-- чтобы этого избежать, нужно использовать dense_rank() (dense - плотный)
select
	sale_date, category, product_name, quantity,
	dense_rank() over ( -- проставляет порядковый номер по order by
	partition by category
	order by quantity desc -- (если одинаковый quantity - одинаковый номер)
	)
from sales_mart
where status = 'Completed';



















