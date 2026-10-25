import pandas as pd
from sqlalchemy import create_engine

def fetch_data_from_db():
    try:
        # 1. Создаем мост к базе (обязательно укажи свой пароль и имя БД!)
        engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/sales')
        
        # 2. Пишем наш SQL-запрос
        sql_query = "SELECT product_name, price FROM sales_mart WHERE status = 'Completed'"
        
        # 3. Pandas сам выполняет запрос и возвращает DataFrame
        df_from_db = pd.read_sql(sql_query, engine)
        
        print("Данные успешно выгружены из базы:")
        print(df_from_db)
        
    except Exception as e:
        # Если база недоступна или в SQL-запросе ошибка, скрипт не умрет, а выведет сообщение
        print(f"Произошла критическая ошибка при работе с БД: {e}")

# Основной код: вызываем нашу защищенную функцию
# fetch_data_from_db()


# Аналитический отдел просит тебя написать скрипт, который будет регулярно 
# забирать из твоей базы PostgreSQL агрегированную статистику продаж.
def  export_sales_metrics():
    try:
        # 1. Создаем мост к базе (обязательно укажи свой пароль и имя БД!)
                engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/sales')
                
                # 2. Пишем наш SQL-запрос
                sql_query = "select region, sum(price * quantity) from sales_mart group by region"
                
                # 3. Pandas сам выполняет запрос и возвращает DataFrame
                df_from_db = pd.read_sql(sql_query, engine)
                
                print("Данные успешно выгружены из базы:")
                print(df_from_db)
    except Exception as e:
        print(f"Произошла критическая ошибка при работе с БД: {e}")
export_sales_metrics()