# test_n1
It's test for SQL.

I made a test database to implement the business logic of a car service.

Смоделируем небольшую базу данных для автосервиса. Для отладки я использую Sqlite3.
Имеем в распоряжении следующие таблицы: 
1.	Клиенты
CREATE TABLE client (
    id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
    name VARCHAR (255)
);
2.	Машины клиентов
CREATE TABLE car (
    id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
    owner_id INT REFERENCES client (id),
    brand VARCHAR (255),
    model VARCHAR (255),
    year INT,
    vin VARCHAR (17) 
);
3.	Заказы клиентов
CREATE TABLE [order] (
Id INTEGER       PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
d_order   DATE          NOT NULL, -- дата заказа
car_id    INT           REFERENCES car (id) NOT NULL,
d_work    DATE          NOT NULL, -- дата работ по ремонту
problem   VARCHAR (255), -- описание проблемы
);
4.	Виды затрат (например, услуга по ремонту, стоимость запчасти, консультация или диагностика) 
CREATE TABLE item_type (
    id   INTEGER       PRIMARY KEY AUTOINCREMENT   UNIQUE   NOT NULL,
    name VARCHAR (100) NOT NULL
);
5.	Справочник видов работ и запчастей
CREATE TABLE service_item (
    id          INTEGER         PRIMARY KEY AUTOINCREMENT  UNIQUE   NOT NULL,
    type_id     INT             REFERENCES item_type (id) NOT NULL DEFAULT (1),
    name        VARCHAR (255)   NOT NULL,
    price       NUMERIC (10, 2),
    part_number VARCHAR (100) -- артикул запчастей
);
6.	Выполненые при ремонте работы и установленные запчасти 
CREATE TABLE car_repair_item (
    id       INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL, 
    order_id INT     REFERENCES [order] (id)  NOT NULL,
    item_id  INT     REFERENCES service_item (id) NOT NULL,
    qty      INT     DEFAULT (1) NOT NULL -- количество работ и запчастей
);

В файле car_service.sql расписано создание и начальная инициализация базы данных.

Для тестирования решим несколько задач:
1) Сделаем запрос для получения максимальной выручки сервиса по дням (orders_by_date.sql):
Select
    "order".d_order,
    Sum(car_repair_item.qty * service_item.price) As sum_service
From
    "order" Inner Join
    car_repair_item On car_repair_item.order_id = "order".id Inner Join
    service_item On car_repair_item.item_id = service_item.id
Group By
    "order".d_order
Order By
    sum_service Desc

Результат:
-----------------------
|d_order  |sum_service|
-----------------------
08.02.2020  3960
07.02.2020   580
09.02.2020   380


2) Сделаем запрос - самая выгодная машина для автосервиса (sum_brand_model.sql):
Select
    car.brand,
    car.model,
    Sum(sum_by_cars.sum_service) As Sum_sum_service
From
    (Select
         "order".car_id,
         Sum(car_repair_item.qty * service_item.price) As sum_service
     From
         "order" Inner Join
         car_repair_item On car_repair_item.order_id = "order".id Inner Join
         service_item On car_repair_item.item_id = service_item.id Inner Join
         "order" order1 On car_repair_item.order_id = order1.id
     Group By
         "order".car_id
     Order By
         sum_service Desc) sum_by_cars Inner Join car On sum_by_cars.car_id = car.id
Group By
    car.brand,
    car.model
Order By
    Sum_sum_service Desc

Результат:
-----------------------------------
|brand	| model  | Sum_sum_service|
-----------------------------------
 Geely	 254	             3960
 BMW	   X5	                420
 Lifan	 F56	              380
 Ford	   Mustang	          160


