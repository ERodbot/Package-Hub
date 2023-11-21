

-- Create a Stored Procedure in PostgreSQL to insert into Clients with the following parameters
-- email, username, name, lastName, idAddress, idContact, password

CREATE OR REPLACE PROCEDURE registerClient(
    email VARCHAR,
    username VARCHAR,
    name VARCHAR,
    lastName VARCHAR,
    idAddress INT,
    idContact INT,
    password VARCHAR
)

LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO "Clients" ("email", "username", "name", "lastName", "idAddress", "idContact", "password", "enabled")
    VALUES (email, username, name, lastName, idAddress, idContact, password, 1);
END;
$$;



-- Create a Stored Procedure in PostgreSQL to insert into Orders with the following parameters
-- idClient, totalPrice, statusActual, idEmployee, idOrderStatus, idShipping, isEnabled, idPayStatus, idPayType

CREATE OR REPLACE PROCEDURE registerOrder(
    idClient INT,            -- Input parameter: client ID
    totalPrice FLOAT,        -- Input parameter: total price
    statusActual INT,        -- Input parameter: actual status
    idEmployee INT,          -- Input parameter: employee ID
    idOrderStatus INT,       -- Input parameter: order status ID
    idShipping INT,          -- Input parameter: shipping ID
    isEnabled INT,           -- Input parameter: enabled status
    idPayStatus INT,         -- Input parameter: payment status ID
    idPayType INT           -- Input parameter: payment type ID
)
LANGUAGE plpgsql
AS $$
DECLARE
    date_var DATE;          -- Variable to store the current date
    invoiceNumber TEXT;     -- Variable to store the generated invoice number
    totalPriceMoney MONEY;  -- Variable to store the total price as MONEY
BEGIN
    -- Declare and set the date variable
    date_var := NOW();

    -- Convert total price to MONEY type
    totalPriceMoney := totalPrice::NUMERIC::MONEY;

    -- Generate a unique invoice number using the current timestamp and idClient
    invoiceNumber := to_char(date_var, 'YYYYMMDDHH24MISS') || '-' || idClient;

    -- Insert into the "Orders" table in the "sales" schema

    INSERT INTO "sales"."Orders" ("idClient", "date", "total", "status", "idEmployee", "idOrderStatus", "idShipping", "enabled", "invoiceNumber", "idPayStatus", "idPayType")
    VALUES (idClient, date_var, totalPriceMoney, statusActual, idEmployee, idOrderStatus, idShipping, isEnabled, invoiceNumber, idPayStatus, idPayType);
END;
$$;



-- Create a Stored Procedure in PostgreSQL to insert into Shipping with the following parameters
--  costPKilometer, kilometers

CREATE OR REPLACE PROCEDURE registerShipping(
    costPKilometer FLOAT,    -- Input parameter: cost per kilometer
    kilometers NUMERIC     -- Input parameter: total kilometers
)
LANGUAGE plpgsql
AS $$
DECLARE
    totalMoney MONEY;        -- Variable to store the total cost as MONEY
    costPKilometerMoney MONEY; -- Variable to store the cost per kilometer as MONEY
BEGIN
    -- Convert cost per kilometer to MONEY type
    costPKilometerMoney := costPKilometer::NUMERIC::MONEY;
    
    -- Calculate the total cost by multiplying cost per kilometer with total kilometers
    totalMoney := costPKilometer::NUMERIC * kilometers;

    -- Insert into the "Shipping" table in the "sales" schema
    INSERT INTO "sales"."Shipping" (costxkm, kilometers, total)
    VALUES (costPKilometerMoney, kilometers, totalMoney);
END;
$$;

-- Call the registerShipping stored procedure with specific parameters
--CALL registerShipping(2.5, 10);

-- Select all records from the "Shipping" table in the "sales" schema
--SELECT * FROM "sales"."Shipping";


-- Sp to insert orders in sqlserver

CREATE OR ALTER PROCEDURE createOrder
    @email VARCHAR(MAX),
    @totalPrice FLOAT,
    @PayType VARCHAR(50)
AS
BEGIN
    -- Variable for error messages
    DECLARE @ErrorMessage NVARCHAR(200);

    -- Check if the specified payment type exists
    IF NOT EXISTS (SELECT name FROM [support-sales].[support-sales].[sales].PayType WHERE name = @PayType)
    BEGIN
        SET @ErrorMessage = 'Payment type is not supported or does not exist';
        RAISERROR(@ErrorMessage, 5, 1);
        RETURN;
    END

    -- Check if the total price is valid
    IF @totalPrice < 0
    BEGIN
        SET @ErrorMessage = 'Price cannot be lower than 0';
        RAISERROR(@ErrorMessage, 5, 1);
        RETURN;
    END

    -- Declare variables for stored procedure use
    DECLARE @statusActual VARCHAR(MAX);
    DECLARE @idEmployee INT;
    DECLARE @idClient INT;
    DECLARE @idOrderStatus INT;
    DECLARE @idShipping INT;
    DECLARE @isEnabled INT;
    DECLARE @idPayStatus INT;
    DECLARE @idPayType INT;
    DECLARE @idOrder INT;


    -- Get the order status for processing
    SELECT @statusActual = idOrderStatus FROM [support-sales].[support-sales].[sales].OrderStatus WHERE name = 'Processing';

    -- Get a random employee ID
    SELECT TOP 1 @idEmployee = idEmployee FROM hr.[human-resources]..Employee ORDER BY NEWID();

    -- Get the last inserted client ID based on the specified email
    SELECT TOP 1 @idClient = idClient FROM [support-sales].[support-sales].[sales].Clients WHERE email = @email;

    -- Get the order status for processing
    SELECT @idOrderStatus = idOrderStatus FROM [support-sales].[support-sales].[sales].OrderStatus WHERE name = 'Processing';

	
    -- Call registerShipping to get the shipping information
    BEGIN TRY
        EXEC ('CALL registerShipping(?, ?)',
            2.1,
            1120
        ) AT [support-sales];
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred during execution: ';
        THROW;  -- Re-throw the caught exception
    END CATCH


	SELECT  TOP 1 @idShipping = idShipping FROM [support-sales].[support-sales].[sales].Shipping ORDER BY idShipping DESC;

    -- Set the order as enabled
    SET @isEnabled = 1;

    -- Get the payment status for 'Paid'
    SELECT @idPayStatus = idPayStatus FROM [support-sales].[support-sales].[sales].PayStatus WHERE name = 'Paid';

    -- Get the payment type ID based on the specified PayType
    SELECT @idPayType = idPayType FROM [support-sales].[support-sales].[sales].PayType WHERE name = @PayType;


    -- Insert a new order into the Orders table
    BEGIN TRY
        EXEC ('CALL registerOrder(?, ?, ?, ?, ?, ?, ?, ?, ?)',
            @idClient,
            @totalPrice,
            @statusActual,
            @idEmployee,
            @idOrderStatus,
            @idShipping,
            @isEnabled,
            @idPayStatus,
            @idPayType
        ) AT [support-sales];
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred during execution: dickcock';
        THROW;  -- Re-throw the caught exception
    END CATCH

	SELECT TOP 1 @idOrder = idOrder FROM [support-sales].[support-sales].[sales].Orders ORDER BY idOrder DESC;

    -- Now, @idOrder contains the idOrder value returned from registerOrder
    SELECT @idOrder;

END;

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

-------------------------------------------------------------------------
-- Get Sales Report
-------------------------------------------------------------------------

-- DROP FUNCTION public.get_sales_report()
CREATE OR REPLACE FUNCTION public.get_sales_report()
RETURNS TABLE (
    "idOrderDetails" integer,
    "idOrder" integer,
    "clientName" text,
    "clientEmail" text, 
    "orderDate" date,
    "idProduct" integer,
    "quantity" integer,
    "lineTotal" money
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        od."idOrderDetails",
        o."idOrder",
        c."name" AS "clientName",
        c."email" AS "clientEmail",
        o.date AS "orderDate",
        od."idProduct",
        od."quantity",
        od."lineTotal"
    FROM
        sales."OrderDetails" od
    JOIN
        sales."Orders" o ON od."idOrder" = o."idOrder"
    JOIN
        sales."Clients" c ON o."idClient" = c."idClient";
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM get_sales_report();