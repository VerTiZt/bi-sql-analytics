import pandas as pd
from sqlalchemy import create_engine

# Сырые данные
raw_data = [
    {"user": "Oleg", "email": "oleg@mail.ru"},
    {"user": "Anna", "email": None}  # У Анны нет почты
]
df = pd.DataFrame(raw_data)

# 1. Отлавливаем битые строки (там, где email пустой)
bad_users = df[df['email'].isna()]

# 2. Выгружаем битые строки в текстовый файл на диске
bad_users.to_csv('bad_users_log.csv', index=False)
# print("Битые юзеры улетели в карантин.")

# 3. Отбираем чистые строки (там, где email НЕ пустой)
clean_users = df[df['email'].notna()]

# print("\nЧистые юзеры, готовые к загрузке в БД:")
# print(clean_users)


# Теперь реализуем эту энтерпрайз-логику для нашего магазина.
# Нам нужно отсеять чеки с кривой ценой и пустым количеством.

# 1. Читаем грязный файл
df = pd.read_csv('dirty_sales.csv', sep=',')

# 2. переводим цену в числа (ошибки станут NaN)
df['price'] = pd.to_numeric(df['price'], errors='coerce')

# 3. Маршрутизируем данные
bad_data = df[(df['price'].isna()) | (df['quantity'].isna())]
clean_data = df[(df['price'].notna()) & (df['quantity'].notna())]

# 4. Выгружаем карантин
bad_data.to_csv('quarantine.csv', index=False)
print("Грязные строки отправлены в карантин.")

# 5. Считаем выручку для чистых данных
clean_data = clean_data.copy()
clean_data['revenue'] = clean_data['price'] * clean_data['quantity']

# 6. Заливаем чистую витрину в БД
engine = create_engine('postgresql+psycopg2://postgres:1234@localhost:5432/postgres')
clean_data.to_sql('clean_sales_mart', engine, if_exists='replace', index=False)
print("Чистые данные успешно загружены в базу")