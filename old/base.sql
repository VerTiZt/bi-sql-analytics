-- таблица с товаром
create table IF NOT EXISTS products (
	product_id int, product_name varchar(100), price numeric(10, 2), in_stock boolean
);

insert into products (product_id, product_name, price, in_stock)
values 
	(1, 'Мяч', 200, true),
	(2, 'Кросы', 1999.99, true),
	(3, 'Футболка с месси', 1010.10, true),
	(4, 'Гетры', 500.00, true),
    (5, 'Бутсы', 5500.00, false),
    (6, 'Спортивная сумка', 3200.00, true);

select product_name, price from products
where price > 500;
select * from products
where product_id  = 1;

select * from products
order by price desc;
select product_name, price from products
order by price desc
limit 3;
select count(*) from products;


ALTER TABLE products ADD COLUMN category VARCHAR(50); -- добавили колонку категорий

-- обновляем категории у старых товаров
UPDATE products SET category = 'Футбол' WHERE product_id IN (1, 3, 4, 5);
UPDATE products SET category = 'Разное' WHERE product_id IN (2, 6);

INSERT INTO products (product_id, product_name, price, in_stock, category) 
VALUES 
    (7, 'Ракетка 3 звезды Quarzee', 1500.00, true, 'Настольный теннис'),
    (8, 'Ракетка 3 звезды Hueson', 1400.00, true, 'Настольный теннис');

select category, count(*) from products
group by category;

select category, avg(price) from products
group by category;


CREATE TABLE IF NOT EXISTS customers ( -- для таблицы заказов
    customer_id INT,
    first_name VARCHAR(50),
    email VARCHAR(100),
    registration_date DATE
);

INSERT INTO customers (customer_id, first_name, email, registration_date) VALUES
(1, 'Алексей', 'alex@mail.ru', '2026-09-01'),
(2, 'Мария', 'maria@gmail.com', '2026-09-05'),
(3, 'Иван', 'ivan@yandex.ru', '2026-09-10');
select * from customers;


-- таблица заказов (потом через джоин фиганём сюда кастомерсов)
CREATE TABLE IF NOT EXISTS orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);

INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity) 
VALUES 
    (1, 1, 2, '2026-09-11', 1), -- Алексей купил Кроссовки
    (2, 2, 7, '2026-09-11', 2), -- Мария купила 2 ракетки Quarzee
    (3, 1, 3, '2026-09-12', 1); -- Алексей купил Футболку
select * from orders;


select orders.order_id, customers.first_name from orders -- взяли то, что будет понятно глазу
join customers on orders.customer_id = customers.customer_id; -- но склеили по id

select orders.order_id, products.product_name, orders.quantity from orders
join products on orders.product_id = products.product_id;

select * from products;