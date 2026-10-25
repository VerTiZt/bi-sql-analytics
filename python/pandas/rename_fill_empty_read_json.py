import pandas as pd

# 1. Читаем реальный файл с жесткого диска
df = pd.read_json('loyalty.json')

# 2. Переименовываем кривые колонки (старое_имя: новое_имя)
df = df.rename(columns={"Имя Пользователя": "user_name", "бонусы": "bonus_points"})

# 3. Заполняем пустоты нулями (перезаписываем колонку саму в себя)
df['bonus_points'] = df['bonus_points'].fillna(0)

print(df)