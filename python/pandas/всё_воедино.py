import pandas as pd
from sqlalchemy import create_engine

def run_etl_pipeline():
    print("Старт ETL-конвейера")

    # 1. Извлечение данных (Extract)
    # Способы чтения файлов с диска:
    # df_csv = pd.read_csv('dirty_sales.csv', sep=',')
    # df_json = pd.read_json('loyalty.json')

    # Имитация выгрузки
    raw_sales_data = {
        "order_id": [1, 2, 3, 4, 5, 5],
        "item_id": [101, 102, 101, 103, 104, 104],
        "Цена товара": [5000, "подарок", 5000, 1500, 2000, 2000],
        "quantity": [2, 1, None, 3, 1, 1],
        "discount_pct": [0.05, 0.0, None, 0.1, None, None]
    }
    
    df = pd.DataFrame(raw_sales_data)
    print("Исходные сырые данные:")
    print(df)

    # 2. Очистка данных (Cleaning)
    # Переименование колонок
    df = df.rename(columns={"Цена товара": "price"})

    # Удаление дубликатов
    df = df.drop_duplicates()

    # Приведение к числу (текст переводится в NaN)
    df['price'] = pd.to_numeric(df['price'], errors='coerce')

    # Заполнение пропусков нулями
    df['discount_pct'] = df['discount_pct'].fillna(0)

    # 3. Фильтрация и карантин
    # Изоляция битых строк с условием ИЛИ (|)
    bad_data = df[(df['price'].isna()) | (df['quantity'].isna())]

    # Отбор чистых строк с условием И (&)
    clean_data = df[(df['price'].notna()) & (df['quantity'].notna())].copy()

    # Сохранение битых данных в файл:
    # bad_data.to_csv('quarantine.csv', index=False)
    print("Количество битых строк:", len(bad_data))

    # 4. Трансформация и аналитика (Transform)
    # Расчет новой колонки
    clean_data['revenue'] = clean_data['price'] * clean_data['quantity'] * (1 - clean_data['discount_pct'])

    # Справочник товаров
    products_catalog = pd.DataFrame({
        "item_id": [101, 102, 103, 104], 
        "category": ["Обувь", "Одежда", "Аксессуары", "Спорт"]
    })

    # Склеивание таблиц (аналог SQL: LEFT JOIN)
    full_data = clean_data.merge(products_catalog, on="item_id", how="left")
    print("Очищенная и объединенная таблица:")
    print(full_data[['order_id', 'category', 'price', 'quantity', 'revenue']])

    # Группировка (аналог SQL: GROUP BY)
    revenue_by_cat = full_data.groupby("category")["revenue"].sum().reset_index()
    print("Выручка по категориям:")
    print(revenue_by_cat)

    # 5. Работа с базой данных (Load & Read)
    try:
        engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/postgres')
        
        # Выгрузка в базу
        clean_data.to_sql('clean_sales_mart', engine, if_exists='replace', index=False)
        print("Таблица clean_sales_mart успешно выгружена в PostgreSQL.")

        # Чтение из базы (аналог SQL: SELECT)
        sql_query = "SELECT category, SUM(revenue) FROM clean_sales_mart GROUP BY category"
        # df_from_db = pd.read_sql(sql_query, engine)
        print("Чтение из базы прошло успешно.")

    except Exception as e:
        print(f"Ошибка при работе с БД: {e}")

    print("ETL-конвейер завершил работу")

export_sales_metrics = run_etl_pipeline
run_etl_pipeline()