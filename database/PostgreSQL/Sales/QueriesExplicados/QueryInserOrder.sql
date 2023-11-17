-- Guia para conexión con Postgrese
-- EXEC ('CALL registerOrder(?, ?, ?, ?, ?, ?, ?, ?, ?)', @idClient, @totalPrice, @statusActual, @idOrderStatus, @idShipping, @isEnabled, @idPayStatus, @idPayType) AT [support-sales];
-- EXEC ('CALL registerShipping(?, ?)', 2.1, 1120) AT [support-sales];
-------------------------------------------------------------------------
-- Insert Order
-------------------------------------------------------------------------

--Query en Postgrese para insertar orden

DROP PROCEDURE registerorder(integer,double precision,integer,integer,integer,integer,integer,integer,integer);

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

-- Call the registerOrder stored procedure with specific parameters
CALL registerOrder(
    1,
    100.50, -- Convert the numeric value to MONEY
    1,
    1,
    1,
    1,
    1,
    1,
    1
);

-- Select all records from the "Orders" table in the "sales" schema
SELECT * FROM "sales"."Orders";




-- Query en Main Cluster

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

-- Example of calling the createOrder procedure

EXEC createOrder
    @email = 'client1@example.com',
    @totalPrice = 550.25,
    @PayType = 'Credit Card';