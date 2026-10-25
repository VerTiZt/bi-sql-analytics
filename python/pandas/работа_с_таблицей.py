import pandas as pd

# Исходные таблицы
clients = pd.DataFrame({"client_id": [1, 2], "name": ["Oleg", "Anna"]})
orders = pd.DataFrame({"client_id": [1, 1, 2], "amount": [500, 1500, 300]})

# 1. Склейка (Аналог: SELECT * FROM orders LEFT JOIN clients ON ...)
merged_df = orders.merge(clients, on="client_id", how="left")
# print("После JOIN")
# print(merged_df)

# 2. Группировка (Аналог: SELECT name, SUM(amount) FROM merged_df GROUP BY name)
revenue_by_client = merged_df.groupby("name")["amount"].sum().reset_index()

# print("\nИтоговая выручка")
# print(revenue_by_client)

products = pd.DataFrame({"item_id": [101, 102], "category": ["Обувь", "Одежда"]})
sales = pd.DataFrame({"item_id": [101, 101, 102], "price": [5000, 5000, 2000]})

df = sales.merge(products, on='item_id', how='left')
print(df)

df = df.groupby("category")["price"].sum().reset_index()
print(df)