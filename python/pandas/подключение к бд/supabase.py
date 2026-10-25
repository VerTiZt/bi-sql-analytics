import pandas as pd
from sqlalchemy import create_engine

# 1. Читаем сформированную витрину
df = pd.read_csv('sales_mart.csv')

# 2. Данные из вкладки Session pooler
USER = 'postgres.dknngjwghnukghpfswxj'
PASSWORD = 'PiRJO21vv1234'
HOST = 'aws-0-eu-west-1.pooler.supabase.com'
PORT = '5432'
DBNAME = 'postgres'

# 3. Добавляем sslmode=require в строку подключения
connection_string = f'postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DBNAME}?sslmode=require'

# 4. Создаем engine с отключенным кэшированием подготовленных выражений для пулера
engine = create_engine(
    connection_string,
    connect_args={'sslmode': 'require'}
)

# 5. Выгружаем данные
df.to_sql('sales_mart', engine, if_exists='replace', index=False)

print("Таблица sales_mart успешно загружена в облачную БД Supabase")