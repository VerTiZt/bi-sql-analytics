-- задача 1
select region as "регион", sum(price * quantity) as "реальная_прибыль"
from sales_mart
where status = 'Completed'
group by region
having sum(price * quantity) > 100000;
-- реальная прибыль завёршенных заказов по регионам (где прибыль больше 100к)

-- задача 2
select product_name as "Название товара", sum(quantity) as "Количество заказов"
from sales_mart
where category = 'Электроника'
group by product_name
having sum(quantity) > 3;
-- самые популярные товары категории электроника, которые заказли больше 3 раз

-- задание 3
select product_name as "название", sum(price * quantity) as "суммарнаня прибыль"
from sales_mart
where status = 'Completed'
group by product_name
having sum(price * quantity) > 30000
order by sum(price * quantity) desc;
-- какие товары принесли прибыль больше 30к (самые прибыльные вверху)