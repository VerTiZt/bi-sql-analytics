-- ОЧИСТКА СТАРЫХ ТАБЛИЦ
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales_mart;
DROP TABLE IF EXISTS region_managers;


-- ИНТЕРНЕТ-МАГАЗИН

-- 1. Таблица клиентов
CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(50),
    email VARCHAR(100),
    registration_date DATE
);

INSERT INTO customers (customer_id, first_name, email, registration_date) VALUES
(1, 'Алексей', 'alex@mail.ru', '2026-09-01'),
(2, 'Мария', 'maria@gmail.com', '2026-09-05'),
(3, 'Иван', 'ivan@yandex.ru', '2026-09-10');


-- 2. Таблица товаров (сразу с категориями)
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    price NUMERIC(10, 2),
    in_stock BOOLEAN,
    category VARCHAR(50)
);

INSERT INTO products (product_id, product_name, price, in_stock, category) VALUES 
(1, 'Кроссовки', 4990.00, true, 'Футбол'),
(2, 'Рюкзак', 2500.50, true, 'Разное'),
(3, 'Футбольный мяч', 1200.00, false, 'Футбол'),
(4, 'Гетры', 500.00, true, 'Футбол'),
(5, 'Бутсы', 5500.00, false, 'Футбол'),
(6, 'Спортивная сумка', 3200.00, true, 'Разное'),
(7, 'Ракетка 3 звезды Quarzee', 1500.00, true, 'Настольный теннис'),
(8, 'Ракетка 3 звезды Hueson', 1400.00, true, 'Настольный теннис');


-- 3. Таблица заказов
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);

INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity) VALUES 
(1, 1, 2, '2026-09-11', 1), 
(2, 2, 7, '2026-09-11', 2), 
(3, 1, 3, '2026-09-12', 1);


-- ВИТРИНЫ

-- 4. Витрина продаж 
CREATE TABLE sales_mart (
    sale_id INT,
    sale_date DATE,
    region VARCHAR(50),
    category VARCHAR(50),
    product_name VARCHAR(100),
    price NUMERIC(10, 2),
    quantity INT,
    status VARCHAR(20)
);

INSERT INTO sales_mart (sale_id, sale_date, region, category, product_name, price, quantity, status) VALUES
(1, '2026-10-01', 'Москва', 'Электроника', 'Смартфон Alpha', 80000.00, 2, 'Completed'),
(2, '2026-10-02', 'Урал', 'Обувь', 'Кроссовки RunX', 5000.00, 1, 'Completed'),
(3, '2026-10-02', 'Москва', 'Обувь', 'Кроссовки RunX', 5000.00, 2, 'Returned'),
(4, '2026-10-03', 'Сибирь', 'Электроника', 'Ноутбук Pro', 120000.00, 1, 'Completed'),
(5, '2026-10-04', 'Москва', 'Электроника', 'Наушники Sound+', 15000.00, 4, 'Completed'),
(6, '2026-10-05', 'Урал', 'Электроника', 'Смартфон Alpha', 80000.00, 1, 'Processing'),
(7, '2026-10-05', 'Урал', 'Электроника', 'Смартфон Alpha', 80000.00, 1, 'Completed'),
(8, '2026-10-06', 'Москва', 'Обувь', 'Ботинки Winter', 12000.00, 1, 'Completed'),
(9, '2026-10-07', 'Сибирь', 'Обувь', 'Ботинки Winter', 12000.00, 2, 'Completed'),
(10, '2026-10-08', 'Москва', 'Электроника', 'Наушники Sound+', 15000.00, 2, 'Completed');


-- 5. менеджеры
CREATE TABLE region_managers (
    region VARCHAR(50),
    manager_name VARCHAR(100)
);

INSERT INTO region_managers (region, manager_name) VALUES
('Москва', 'Иван Грозный'),
('Урал', 'Петр Первый'),
('Сибирь', 'Ермак Тимофеевич');