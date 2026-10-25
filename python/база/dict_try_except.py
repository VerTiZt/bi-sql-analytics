# словари + списки + трай
# напоминание синтаксиса словаря
order_data = {
    "order_id": 101,
    "status": "Completed",
    "total_amount": 3200
}
current_status = order_data["status"]
#print(current_status)


# Python-скрипт забрал из внешней CRM-системы данные о клиенте, 
# тебе нужно программно вытащить из них его регион для дальнейшей маршрутизации заказа
customers = {
    'client_name': 'Oleg',
    'region': 'Moscow',
    'loyalty_points': 10
}
current_region = customers['region']
#print(current_region)


# Мы получили из внешней системы список цен на товары, 
# но из-за бага в одной строке вместо числа пришел текст "бесплатно". 
# Тебе нужно перевести все цены в целые числа с помощью функции int(), 
# но текст сломает программу ошибкой ValueError.
prices = [1500, 3200, "бесплатно", 450]
for x in prices:
    try:
        clean_price = int(x)
        print(f'цена: {clean_price}')
    except ValueError:
        print(f'с ценой "{x}" что-то не так')
