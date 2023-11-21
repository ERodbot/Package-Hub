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
    'Brownies', 1, 'Dulces y grandes', 1, 50, 75.99, 10.5, 1, 2),
	('Vino', 1, 'Caro y exclusivo', 2, 50, 75.99, 10.5, 4, 1);


-----------------------------------------------------------------
-- Insert para tabla del caribe, se corre todo lo anterior menos products
-----------------------------------------------------------------
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
    'Helado', 1, 'Helado de fresa', 1, 50, 75.99, 10.5, 1, 2),
	('Tronaditas', 1, 'Salas y acidas', 2, 50, 75.99, 10.5, 4, 1),
	('Pollo', 1, 'Con salsa BBQ', 2, 150, 175.99, 10.5, 4, 1);


