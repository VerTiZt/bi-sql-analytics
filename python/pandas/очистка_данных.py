import pandas as pd

# Сырые данные (дубликат Монитора, текст в Клавиатуре, пустота в Проводе)
raw_data = [
    {"item": "Мышь", "price": 1000},
    {"item": "Клавиатура", "price": "подарок"},
    {"item": "Монитор", "price": 15000},
    {"item": "Монитор", "price": 15000},
    {"item": "Провод", "price": None} 
]
df = pd.DataFrame(raw_data)

# 1. Сносим полные дубликаты строк
df_clean = df.drop_duplicates()

# 2. Форсируем превращение колонки price в числа ("подарок" станет NaN)
df_clean['price'] = pd.to_numeric(df_clean['price'], errors='coerce')

# 3. Удаляем все строки, где образовалась пустота (NaN, None)
df_clean = df_clean.dropna()

# print(df_clean)


# Отдел маркетинга скинул таблицу с возрастом клиентов, 
# но файл грязный. Тебе нужно подготовить его к заливке в БД.
data = [{"client_id": 1, "age": 25}, {"client_id": 2, "age": "неизвестно"}, {"client_id": 1, "age": 25}, {"client_id": 3, "age": None}]
df = pd.DataFrame(data)
df_clean = df.drop_duplicates()
df_clean['age'] = pd.to_numeric(df_clean['age'], errors='coerce')
df_clean = df_clean.dropna()
print(df_clean)