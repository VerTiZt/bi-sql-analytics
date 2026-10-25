# ПРИМЕР
import pandas as pd
from sqlalchemy import create_engine

# # 1. Чтение CSV (sep - это разделитель колонок, обычно ',' или ';')
# df_csv = pd.read_csv('my_data.csv', sep=',')
# print("Данные из CSV:")
# print(df_csv)

# # 2. Чтение Excel (указываем название файла)
# # df_excel = pd.read_excel('my_report.xlsx')


# ЗАДАЧА
# Коммерческий отдел скинул тебе выгрузку продаж в формате CSV. 
# Там есть "грязные" данные (заказы с нулевым количеством). 
# Тебе нужно написать скрипт, который прочитает этот файл, очистит его и 
# зальет в базу
df_csv = pd.read_csv('raw_sales.csv', sep=',') 
product = df_csv[df_csv['quantity'] > 0]
print(product)
engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/postgres')
product.to_sql('imported_sales', engine, if_exists='replace', index=0)