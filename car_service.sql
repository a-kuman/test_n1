-- Таблица: car
CREATE TABLE car (
    id       INTEGER       PRIMARY KEY AUTOINCREMENT
                           UNIQUE
                           NOT NULL,
    owner_id INT           REFERENCES client (id),
    brand    VARCHAR (255),
    model    VARCHAR (255),
    year     INT,
    vin      VARCHAR (17) 
);

INSERT INTO car (
                    id,
                    owner_id,
                    brand,
                    model,
                    year,
                    vin
                )
                VALUES (
                    1,
                    1,
                    'BMW',
                    'X5',
                    2020,
                    '12345678901234567'
                );

INSERT INTO car (
                    id,
                    owner_id,
                    brand,
                    model,
                    year,
                    vin
                )
                VALUES (
                    2,
                    2,
                    'Ford',
                    'Mustang',
                    2019,
                    '78901234567891234'
                );

INSERT INTO car (
                    id,
                    owner_id,
                    brand,
                    model,
                    year,
                    vin
                )
                VALUES (
                    3,
                    3,
                    'Geely',
                    '254',
                    2017,
                    '456465465465464646546'
                );

INSERT INTO car (
                    id,
                    owner_id,
                    brand,
                    model,
                    year,
                    vin
                )
                VALUES (
                    4,
                    3,
                    'Lifan',
                    'F56',
                    2020,
                    '4564654654654654654646'
                );


-- Таблица: car_repair_item
CREATE TABLE car_repair_item (
    id       INTEGER PRIMARY KEY AUTOINCREMENT
                     UNIQUE
                     NOT NULL,
    order_id INT     REFERENCES [order] (id) 
                     NOT NULL,
    item_id  INT     REFERENCES service_item (id) 
                     NOT NULL,
    qty      INT     DEFAULT (1) 
                     NOT NULL
);

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                1,
                                1,
                                8,
                                2
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                2,
                                3,
                                4,
                                6
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                3,
                                4,
                                2,
                                4
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                4,
                                3,
                                2,
                                4
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                5,
                                1,
                                3,
                                2
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                6,
                                2,
                                1,
                                4
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                7,
                                3,
                                5,
                                6
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                8,
                                3,
                                6,
                                4
                            );

INSERT INTO car_repair_item (
                                id,
                                order_id,
                                item_id,
                                qty
                            )
                            VALUES (
                                9,
                                4,
                                7,
                                4
                            );


-- Таблица: client
CREATE TABLE client (
    id   INTEGER       PRIMARY KEY AUTOINCREMENT
                       UNIQUE
                       NOT NULL,
    name VARCHAR (255) 
);

INSERT INTO client (
                       id,
                       name
                   )
                   VALUES (
                       1,
                       'Smith'
                   );

INSERT INTO client (
                       id,
                       name
                   )
                   VALUES (
                       2,
                       'Pier'
                   );

INSERT INTO client (
                       id,
                       name
                   )
                   VALUES (
                       3,
                       'Li'
                   );


-- Таблица: item_type
CREATE TABLE item_type (
    id   INTEGER       PRIMARY KEY AUTOINCREMENT
                       UNIQUE
                       NOT NULL,
    name VARCHAR (100) NOT NULL
);

INSERT INTO item_type (
                          id,
                          name
                      )
                      VALUES (
                          1,
                          'Autopart'
                      );

INSERT INTO item_type (
                          id,
                          name
                      )
                      VALUES (
                          2,
                          'Service'
                      );

INSERT INTO item_type (
                          id,
                          name
                      )
                      VALUES (
                          3,
                          'Consultation'
                      );

INSERT INTO item_type (
                          id,
                          name
                      )
                      VALUES (
                          4,
                          'Inspection'
                      );


-- Таблица: order
CREATE TABLE [order] (
    id      INTEGER       PRIMARY KEY AUTOINCREMENT
                          NOT NULL
                          UNIQUE,
    d_order DATE          NOT NULL,
    car_id  INT           REFERENCES car (id) 
                          NOT NULL,
    d_work  DATE          NOT NULL,
    problem VARCHAR (255) 
);

INSERT INTO [order] (
                        id,
                        d_order,
                        car_id,
                        d_work,
                        problem
                    )
                    VALUES (
                        1,
                        '2020-02-07',
                        1,
                        '2020-02-07',
                        'Scratch on left door'
                    );

INSERT INTO [order] (
                        id,
                        d_order,
                        car_id,
                        d_work,
                        problem
                    )
                    VALUES (
                        2,
                        '2020-02-07',
                        2,
                        '2020-02-08',
                        'Repair wheel'
                    );

INSERT INTO [order] (
                        id,
                        d_order,
                        car_id,
                        d_work,
                        problem
                    )
                    VALUES (
                        3,
                        '2020-02-08',
                        3,
                        '2020-02-08',
                        'Repaire valve'
                    );

INSERT INTO [order] (
                        id,
                        d_order,
                        car_id,
                        d_work,
                        problem
                    )
                    VALUES (
                        4,
                        '2022-02-09',
                        4,
                        '2022-02-09',
                        'Repaire break pad'
                    );


-- Таблица: service_item
CREATE TABLE service_item (
    id          INTEGER         PRIMARY KEY AUTOINCREMENT
                                UNIQUE
                                NOT NULL,
    type_id     INT             REFERENCES item_type (id) 
                                NOT NULL
                                DEFAULT (1),
    name        VARCHAR (255)   NOT NULL,
    price       NUMERIC (10, 2),
    part_number VARCHAR (100) 
);

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             1,
                             2,
                             'Wheel replacement',
                             40,
                             NULL
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             2,
                             2,
                             'Replacement of brake pads',
                             70,
                             NULL
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             3,
                             2,
                             'Scratch Removal',
                             200,
                             NULL
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             4,
                             2,
                             'Engine valve replacement',
                             500,
                             NULL
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             5,
                             1,
                             'Valve',
                             100,
                             '121321354'
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             6,
                             1,
                             'Brake pad',
                             20,
                             '135456131'
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             7,
                             1,
                             'Brake pad',
                             25,
                             '45651351'
                         );

INSERT INTO service_item (
                             id,
                             type_id,
                             name,
                             price,
                             part_number
                         )
                         VALUES (
                             8,
                             1,
                             'Auto polish',
                             10,
                             '54665'
                         );
