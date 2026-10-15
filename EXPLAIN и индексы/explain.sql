-- ТЕОРИЯ
-- эксплейн (маршрут для выполнения запроса + время выполнения)
EXPLAIN ANALYZE
SELECT * FROM customers WHERE email = 'alex@mail.ru';

-- индексация (для ускорения доступа к определённым элементам бд)
-- синтаксис: CREATE INDEX <имя_индекса> ON <таблица>(<колонка>);
CREATE INDEX idx_customers_email ON customers(email);
-- до индексации находил имейл за 2 мс, сейчас за 0,042 мс


-- ЗАДАЧА
-- Финансовый отдел регулярно фильтрует витрину sales_mart по конкретным датам.
-- Тебе поручили оптимизировать этот процесс, чтобы при росте данных до миллионов 
-- строк отчеты не тормозили.
explain analyze
select * from sales_mart WHERE sale_date = '2026-10-05';
create index inx_sales_mart_sale_date on sales_mart(sale_date);
-- seq scan сё равно остался, т.к. таблица маленькая (дешевле искать без индексов)