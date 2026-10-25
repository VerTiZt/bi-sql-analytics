# выгружаем таблицу sales_mart в csv
import pandas as pd
from sqlalchemy import create_engine

LOCAL_URL = 'postgresql+psycopg2://postgres:1234@localhost:5432/sales'
local_engine = create_engine(LOCAL_URL)

# 2. Читаем таблицу витрины из локальной базы
table_name = 'sales_mart' 
df = pd.read_sql(f'SELECT * FROM {table_name}', local_engine)

# 3. Сохраняем в CSV-файл
# index=False важен, чтобы не сохранять технические номера строк (0, 1, 2...)
df.to_csv('sales_mart.csv', index=False)

print("файл sales_mart.csv успешно выгружен на диск")
print(f"Всего строк выгружено: {len(df)}")