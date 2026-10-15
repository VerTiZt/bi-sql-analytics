-- 1. ТЕОРИЯ

-- возьми чек, посмотри на номер гостя в нем (orders.customer_id), 
-- найди в толпе человека с точно таким же номером на бейджике (customers.customer_id) и поставь их рядом
select c.first_name, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- inner join (выкидываем строки без совпадений)
-- Ты хочешь посмотреть список продаж с региональными менеджерами. 
--У нас есть продажи в Москве, на Урале и в Сибири. Менеджеры есть для всех трех регионов
SELECT 
    sm.sale_id,
    sm.region,
    rm.manager_name,
    sm.price
FROM sales_mart sm
INNER JOIN region_managers rm ON sm.region = rm.region;

-- left join (оставляет всё из левой таблицы (null, если нет совпадений))
-- Если бы здесь был INNER JOIN, Иван бы просто стерся из результата. 
-- А благодаря LEFT JOIN маркетолог сразу видит: 
-- «Ага! У Ивана в колонке order_id стоит NULL — значит, он зарегистрировался, но еще ничего не купил».
SELECT 
    c.first_name,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 2. ЗАДАЧИ
-- 1) Отделу маркетинга нужен отчет для выявления «спящих» клиентов. 
-- Требуется список всех зарегистрированных покупателей, а рядом — 
-- информация об их заказах (номер и дата), если таковые были
select 
	c.first_name,
	o.order_id,
	o.order_date
from customers c
left join orders o
	on c.customer_id = o.customer_id;
-- Отфильтруй мне только тех клиентов, которые еще ничего не купили, 
-- чтобы я мог выгрузить их контакты для рассылки
select 
	c.first_name,
	o.order_id,
	o.order_date
from customers c
left join orders o
	on c.customer_id = o.customer_id
where o.order_id is null; -- нельзя писать = null (прикол sql)

-- 2) Напиши SQL-запрос, который выведет список региональных менеджеров 
-- и общую сумму выручки, которую принес каждый менеджер по завершенным заказам
select r.manager_name as "имя менеджера", 
	sum(s.price * s.quantity) as "итоговая выручка"
from sales_mart s
inner join region_managers r
	on s.region = r.region
where s.status = 'Completed'
group by r.manager_name
order by sum(s.price * s.quantity) desc;

-- 3) три таблицы!
-- Задача: вывести детализированный чек покупок.
-- Нужные данные:
-- Имя покупателя (c.first_name)
-- Название купленного товара (p.product_name)
-- Количество штук (o.quantity)
-- Дату заказа (o.order_date)
-- Напиши SQL-запрос, объединяющий orders, customers и products
select 
	c.first_name as "Имя покупателя", 
	p.product_name as "Купленный продукт", 
	o.quantity as "Количество", 
	o.order_date as "Дата покупки"
from orders o
join customers c on c.customer_id = o.customer_id
join products p on o.product_id = p.product_id; -- увидел, что в заказах и товарах есть общий products_id

-- 4) с собесов (соединение таблицы с собой же)
-- Бизнес-кейс: конкурентный анализ внутри категории
-- Отделу маркетинга нужно сравнить товары внутри одной и той же категории и составить пары альтернатив. задача:
-- напиши SQL-запрос к таблице products, который выведет пары разных товаров из одной категории, 
-- где второй товар строго дороже первого.
-- Требования к витрине (SELECT):
-- категория товара (category), название первого товара, цена первого товара
-- название более дорогого товара-альтернативы, цена второго товара
select 
	p.category as "Категория товаров",
	p.product_name as "Название первого отовара",
	p.price as "Цена первого товара (дешевле)",
	p2.product_name as "Название второго отовара",
	p2.price as "Цена второго товара (дороже)"
from products p
join products p2
	on p.category = p2.category
where p.price < p2.price;
