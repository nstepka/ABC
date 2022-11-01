INSERT INTO abc_management.storage_type (type_name, created_by) VALUES
('Store Front', 'Initialized Data')
, ('Warehouse', 'Initialized Data')
, ('Barge', 'Initialized Data');


INSERT INTO abc_management.resource_type (type_name, created_by) VALUES
('Appliance', 'Initialized Data')
, ('Window', 'Initialized Data')
, ('Tool', 'Initialized Data')
, ('Bathroom', 'Initialized Data')
, ('Flooring', 'Initialized Data')
, ('Garden', 'Initialized Data')
, ('Frozen Good', 'Initialized Data')
, ('Dairy', 'Initialized Data')
, ('Storage', 'Initialized Data')
, ('Lighting', 'Initialized Data')
, ('Paint', 'Initialized Data')
, ('Vegetable', 'Initialized Data')
, ('Fruit', 'Initialized Data')
, ('Paper Product', 'Initialized Data')
, ('Electronic', 'Initialized Data')
, ('Pet Care', 'Initialized Data')
, ('Automotive', 'Initialized Data')
, ('Snacks', 'Initialized Data')
, ('Breakfast', 'Initialized Data')
, ('Bakery', 'Initialized Data')
, ('Baby', 'Initialized Data')
, ('Candy', 'Initialized Data')
, ('Deli', 'Initialized Data');


INSERT INTO abc_management.address (created_by, country, state, address_line_1, address_line_2, postal_code, city) VALUES
('Initialized Data', 'USA', 'WA', '1365 NE 6th Ave', NULL, '98277', 'Oak Harbor')
, ('Initialized Data', 'USA', 'NJ', '2135 W County Line Rd', '#8A', '08527', 'Jackson')
, ('Initialized Data', 'USA', 'MT', '614 Birch Ave', NULL, '59474', 'Shelby')
, ('Initialized Data', 'USA', 'CA', '374 2nd Ave', NULL, '94014', 'Daly City')
, ('Initialized Data', 'USA', 'TX', '188 N Plano Rd', NULL, '75081', 'Richardson')
, ('Initialized Data', 'USA', 'CA', '1661 W 259th St', '#APT 207', '90710', 'Harbor City')
, ('Initialized Data', 'USA', 'AL', '513 Rosebury Rd', NULL, '35080', 'Helena')
, ('Initialized Data', 'USA', 'MA', '11 S Elm St', NULL, '01835', 'Haverhill')
, ('Initialized Data', 'USA', 'AZ', '11410 E Kathy Ln', NULL, '86327', 'Dewey')
, ('Initialized Data', 'USA', 'CA', '1640 Riverside Drive', NULL, '91103', 'Hill Valley')
, ('Initialized Data', 'USA', 'NY', '1407 Graymalkin Lane', NULL, '11103', 'Salem Center');


INSERT INTO abc_management.abc_client (client_name, company_address_id, phone_number, created_by) VALUES
('Kruger', 1, '999-999-9999', 'Initialized Data')
, ('Lowels', 2, '999-999-9999', 'Initialized Data')
, ('Ham Deput', 3, '999-999-9999', 'Initialized Data')
, ('Pooblix', 4, '999-999-9999', 'Initialized Data')
, ('Targit', 5, '999-999-9999', 'Initialized Data')
, ('Amazoom', 6, '999-999-9999', 'Initialized Data')
, ('Toys R We', 7, '999-999-9999', 'Initialized Data')
, ('EB Gamers', 8, '999-999-9999', 'Initialized Data')
, ('WW Chocolate', 9, '999-999-9999', 'Initialized Data')
, ('Hello World', 10, '999-999-9999', 'Initialized Data')
, ('Baby Made', 11, '999-999-9999', 'Initialized Data');


INSERT INTO abc_management.inventory (abc_client_id, inventory_name, storage_type_id, max_item_capacity, created_by)
SELECT abc_client.abc_client_id
, CONCAT(abc_client.client_name, ' ', storage_type.type_name)
, storage_type.storage_type_id
, IF(type_name= 'Store Front', 10000, 100000)
, 'Initialized Data'
FROM abc_management.abc_client
JOIN abc_management.storage_type;


INSERT INTO abc_management.abc_resource (inventory_id, resource_name, resource_type_id, max_number_of_resources, current_number_of_resources, created_by)
SELECT inventory.inventory_id
, CONCAT(abc_client.client_name, ' ', resource_type.type_name , ' ', a.num_value)
, resource_type.resource_type_id
, 100
, 100
, 'Initialized Data'
FROM abc_management.inventory
JOIN abc_management.abc_client USING(abc_client_id)
JOIN abc_management.storage_type USING(storage_type_id)
JOIN abc_management.resource_type
JOIN (select 0 num_value union select 1 union select 2 union select 3 union select 4 union
select 5 union select 6 union select 7 union select 8 union select 9) a
ORDER BY abc_client.abc_client_id ASC, inventory.inventory_id ASC, resource_type.resource_type_id ASC, a.num_value ASC;