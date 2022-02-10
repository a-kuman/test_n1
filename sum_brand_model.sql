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