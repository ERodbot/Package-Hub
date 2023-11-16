USE [inventory]
GO -- Brands
INSERT INTO [dbo].[Brands] (
    [name],
    [idAddress],
    [idContact]
  )
VALUES ('Tosty', 1, 1),
  ('DosPinos', 2, 2),
  ('Marca3', 3, 3),
  ('Marca4', 4, 4),
  ('Marca5', 5, 5);
GO -- Categorias
INSERT INTO [dbo].[Category] ([name])
VALUES ('Snacks'),
  ('Bebidas'),
  ('Ropa'),
  ('Skate');
GO -- Colors
INSERT INTO [dbo].[Colors] ([name])
VALUES ('Rojo'),
  ('Azul'),
  ('Verde'),
  ('Negro'),
  ('Blanco');
GO -- Location
INSERT INTO [dbo].[Location] (
    [idLocation],
    [aisle],
    [shelf],
    [store],
    [geoposition]
  )
VALUES (
    1,
    1,
    2,
    3,
    geography::Point(37.7749, -122.4194, 4326)
  ),
  (
    2,
    2,
    3,
    1,
    geography::Point(34.0522, -118.2437, 4326)
  );
-- OperationTypes
INSERT INTO [dbo].[OperationTypes] ([name])
VALUES ('Insert'),
  ('Remove');
-- Products
INSERT INTO [dbo].[Products] (
    [name],
    [idCategory],
    [description],
    [idLocation],
    [quantity],
    [price],
    [weight],
    [idColor],
    [idBrand]
  )
VALUES (
    'Bolitas de queso',
    1,
    'Bolas amarillas crujuente con queso',
    1,
    50,
    75.99,
    10.5,
    1,
    1
  ),
  (
    'Chocolate',
    1,
    '	Chocolate Amargo',
    1,
    50,
    75.99,
    10.5,
    1,
    1
  ),
  (
    'Gomitas',
    1,
    'Gomitas acidas de gusanos coloridos',
    1,
    50,
    75.99,
    10.5,
    1,
    1
  ),
  (
    'Fresco Leche',
    2,
    'Fresco leche de fresa',
    1,
    50,
    75.99,
    10.5,
    1,
    2
  ),
  (
    'Rompope',
    2,
    'Tan solo con un 4% de alchol',
    1,
    150,
    50,
    10.5,
    1,
    2
  ),
  (
    'Jugo de Naranja',
    2,
    'Naranja 100% fresca',
    1,
    30,
    90,
    20,
    2,
    2
  ),
  (
    'Camisa',
    3,
    '100% Hecho de algodon',
    1,
    30,
    90,
    20,
    2,
    3
  ),
  (
    'Pantalon',
    3,
    '100% Hecho de algodon',
    1,
    30,
    90,
    20,
    2,
    3
  ),
  (
    'Sueter',
    3,
    'De gran calidad',
    1,
    50,
    190,
    12,
    3,
    3
  ),
  (
    'Skateboard',
    4,
    'Skateboard de 17 pulgadas',
    1,
    30,
    90,
    20,
    2,
    4
  ),
  (
    'Casco',
    4,
    'Gran calidad y fuerza',
    1,
    30,
    90,
    20,
    2,
    4
  ),
  (
    'Espinilleras',
    4,
    'Gran calidad de plastico',
    1,
    30,
    90,
    20,
    2,
    4
  );
-- Images
INSERT INTO [dbo].[Images] ([name], [path])
VALUES ('Imagen1', 0x1234),
  ('Imagen2', 0x5678),
  ('Imagen3', 0x9ABC),
  ('Imagen4', 0xDEF0),
  ('Imagen5', 0x1122);
GO -- ImagesXProducts
INSERT INTO [dbo].[ImagesXProducts] ([idProduct], [idImage])
VALUES (1, 1),
  (2, 2),
  (3, 3),
  (1, 4),
  (2, 5);
-- Materials
INSERT INTO [dbo].[Materials] ([name])
VALUES ('Aluminio'),
  ('Plastico'),
  ('Madera'),
  ('Comida');
-- MaterialsXProduct
INSERT INTO [dbo].[MaterialsXProduct] ([idMaterial], [idProduct])
VALUES (1, 1),
  (2, 1),
  (2, 2),
  (3, 3);
-- Suppliers
INSERT INTO [dbo].[Suppliers] ([name], [idAddress], [idContact])
VALUES ('Suplier1', 1, 1),
  ('Supplier2', 2, 2),
  ('Suplier3', 3, 3);
-- ProductsXSuppliers
INSERT INTO [dbo].[ProductsXSuppliers] ([idProduct], [idSupplier])
VALUES (1, 1),
  (2, 2),
  (3, 2),
  (1, 3)