-- Guia para conexión con Postgrese
-- EXEC ('CALL registerClient(?, ?, ?, ?, ?, ?, ?)', @email, @username, @name, @lastName, @idAddress, @idContact, @password) AT [support-sales];

-------------------------------------------------------------------------
-- Insert Order Details
-------------------------------------------------------------------------

--Query en Postgrese para insertar orden
CREATE OR REPLACE PROCEDURE insert_order_detail(
    in_order_id INT,
    in_product_id INT,
    in_quantity INT,
    in_price_unit FLOAT,
    in_discount FLOAT
)
LANGUAGE plpgsql
AS $$
DECLARE
    total_price MONEY;
    price_unit_money MONEY;
    discount_money MONEY;
BEGIN
    price_unit_money := in_price_unit::NUMERIC::MONEY;
    discount_money := in_discount::NUMERIC::MONEY;

    total_price := (in_quantity * price_unit_money) - discount_money;

    INSERT INTO sales."OrderDetails" ("idOrder", "idProduct", quantity, "priceUnit", discount, "lineTotal", "date")
    VALUES (in_order_id, in_product_id, in_quantity, price_unit_money, discount_money, total_price, CURRENT_DATE);
END;
$$;

-- Query en Main Cluster

CREATE OR ALTER PROCEDURE insert_order_detail
	 @in_order_id INT,
	 @in_product_id INT,
	 @in_quantity INT,
	 @in_price_unit FLOAT,
	 @in_discount FLOAT
AS
BEGIN
	EXEC ('CALL insert_order_detail(?, ?, ?, ?, ?)', @in_order_id, @in_product_id, @in_quantity, @in_price_unit, @in_discount ) AT [support-sales];
END;
GO

-- Llamada del query
EXEC insert_order_detail @in_order_id = 1, @in_product_id = 2, @in_quantity = 3, @in_price_unit = 40.00, @in_discount = 15.00




-------------------------------------------------------------------------
-- Verify product quantity price
-------------------------------------------------------------------------

--Query Postgrese viewTotal price
CREATE OR REPLACE PROCEDURE calculate_total_price(
    in_quantity INT,
    in_price_unit FLOAT,
    in_discount FLOAT,
    OUT out_total FLOAT
)
LANGUAGE plpgsql
AS $$
DECLARE
    price_unit_money FLOAT;
    discount_money FLOAT;
BEGIN
    price_unit_money := in_price_unit;
    discount_money := in_discount;
    out_total := (in_quantity * price_unit_money) - discount_money;
END;  
$$;

-- SQL Main Cluster CALL Con Product

CREATE OR ALTER PROCEDURE calculate_total_price
	 @productName NVARCHAR(100),  
	 @in_quantity INT,
	 @in_discount FLOAT,
	 @out_total FLOAT
AS
BEGIN
	DECLARE @currentPrice MONEY;
	DECLARE @currentPriceF FLOAT;

	IF EXISTS (SELECT 1 FROM [inventory].[dbo].[Products] WHERE name = @productName)
    BEGIN
        SELECT @currentPrice = Pr.price 
        FROM
            [inventory].[dbo].[Products] AS Pr
        WHERE
            Pr.name = @productName;


		SET @currentPriceF = CAST(@currentPrice AS FLOAT);
		EXEC ('CALL calculate_total_price(?, ?, ?, ?)', @in_quantity, @currentPriceF, @in_discount, @out_total) AT [support-sales];
    END
    ELSE
    BEGIN
        DECLARE @ErrorMessage VARCHAR(100) = 'No existe el producto ingresado'
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN; 
    END
END;
GO

-- Llamada del query
EXEC calculate_total_price @productName = 'Bolitas de queso', @in_quantity = 3,  @in_discount = 0, @out_total = NULL




