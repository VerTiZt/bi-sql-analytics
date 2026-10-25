# ПРИМЕР
import pandas as pd
from sqlalchemy import create_engine # Импортируем инструмент для создания подключения

# 1. Формируем строку подключения
# Шаблон: 'postgresql+psycopg2://пользователь:пароль@сервер:порт/имя_базы'
# Локально сервер обычно 'localhost', порт '5432', пользователь 'postgres'
engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/postgres')

# 2. Создаем тестовый DataFrame
test_data = pd.DataFrame({"client": ["Oleg", "Anna", "Кирилл"], "points": [10, 50, 11]})

# 3. Отправляем таблицу напрямую в PostgreSQL
# if_exists='replace' удалит старую таблицу с таким именем и создаст новую (можно 'append' для дозаписи)
# index=False предотвращает загрузку системной колонки с порядковыми номерами (0, 1) в базу
test_data.to_sql('python_test_table', engine, if_exists='replace', index=False)

print("Данные успешно улетели в базу!")


# ЗАДАЧА
# из прошлого скрипта (пандас) который фильтрует каталог, оставляя товары дороже 2000. 
# Теперь нужно выгрузить этот результат в базу данных
data = {'product': ['кроссовки', 'мяч', 'рюкзак'], 'price': [4990, 1200, 2500]}
dm = pd.DataFrame(data) 

product = dm[dm['price'] > 2000]
# сделали таблицу через дата фрейм и отфильтровали по цене
engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/postgres')
product.to_sql('new_table', engine, if_exists='replace', index=0)
print('ready')