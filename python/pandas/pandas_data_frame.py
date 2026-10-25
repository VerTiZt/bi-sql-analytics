# ПРИМЕР использования пандас
import pandas as pd

raw_data = [
    {"client": "Oleg", "amount": 5000},
    {"client": "Anna", "amount": 12000},
    {"client": "Ivan", "amount": 300}
]
# сырые данные в DataFrame (в таблицу)
df = pd.DataFrame(raw_data)
# print("Исходная таблица")
# print(df)

# фильтрация данных (WHERE amount > 4000 в SQL)
# "таблица df, дай только те строки df, где колонка 'amount' > 4000"
vip_clients = df[df["amount"] > 4000]
# print("\nVIP Клиенты")
# print(vip_clients)


# ЗАДАЧА
# Склад выгрузил мини-каталог товаров, и тебе нужно 
# программно отфильтровать дешевые позиции перед загрузкой в базу
data = [{'product': 'кроссовки', 'price': 4990},{'product': 'мяч', 
    'price': 1200}, {'product': 'рюкзак', 'price': 2500}]
dm = pd.DataFrame(data)
print(dm)

product = dm[dm['price'] > 2000]
print(product)