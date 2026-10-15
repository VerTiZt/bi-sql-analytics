-- ТЕОРИЯ (CTE - having для оконных функций (которые как раз как group by))
WITH my_temp_table AS (
    -- Внутренний запрос
	SELECT ...
)
-- Внешний запрос: обращаемся к CTE как к обычной таблице
SELECT ...
FROM my_temp_table
WHERE ... = 1;


-- ПРИМЕР
-- бизнес хочет узнать, какой товар был продан самым первым (исторически) 
-- в каждом из регионов.
-- Мы не можем просто отфильтровать оконную функцию в WHERE. 
-- Поэтому мы создаем временную таблицу (CTE) с помощью WITH, раздаем там места, 
-- а затем обращаемся к ней, как к обычной таблице.

-- 1. Объявляем CTE (временную таблицу) и даем ей понятное имя
WITH regional_first_sales AS (
    -- Внутренний запрос: собираем данные и раздаем порядковые номера
    SELECT 
        region,
        sale_date,
        product_name,
        row_number() over (
            partition by region 
            order by sale_date -- сортируем по дате от старых к новым
        ) as row_num
    FROM sales_mart
    WHERE status = 'Completed'
)
-- 2. Внешний запрос: обращаемся к нашей временной таблице
SELECT 
    region,
    sale_date,
    product_name
FROM regional_first_sales
WHERE row_num = 1; -- спокойно фильтруем по колонке с рангом


-- ЗАДАЧА
-- 1. Бизнес хочет узнать, какой конкретно товар принес максимальную выручку 
-- (в рамках одного чека) в каждой из категорий.
with ranked_sales as ( 
	select product_name, category, 
	price * quantity as "Прибыль",
	rank() over (
		partition by category
		order by price * quantity desc -- нам надо самые прибыльные товары
	) as rs
	from sales_mart
	where status = 'Completed'
)
select product_name, category, 
"Прибыль" -- НЕ price * quantity as "Прибыль"
from ranked_sales -- НЕ sales_mart !
where rs = 1
order by "Прибыль" desc;























