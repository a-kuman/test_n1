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