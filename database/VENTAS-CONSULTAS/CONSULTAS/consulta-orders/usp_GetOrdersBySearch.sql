CREATE OR ALTER PROCEDURE usp_GetOrdersBySearch
	@usernameclient VARCHAR(100) = NULL,
	@email VARCHAR(100) = NULL,
	@searchparameter VARCHAR(150)
AS 
BEGIN
    -- Variable declarations and initialization
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    DECLARE @date DATETIME
    DECLARE @computer VARCHAR(50)
    DECLARE @username VARCHAR(50)
    DECLARE @checksum VARBINARY(150)

    -- Initialize variables
    SET @date = GETDATE()
    SET @computer = 'me'
    SET @username = 'root'
    SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

    -- Transaction control variable
    DECLARE @InicieTransaccion BIT = 0
    
    -- Validate provided username
	IF @usernameclient IS NOT NULL  
    BEGIN 
		IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.username = @usernameclient) 
			BEGIN 
				SET @Message = 'Error - The specified client does not exist in the database.'
				SET @ErrorSeverity = 1 -- Adjust the severity level as needed
				SET @ErrorState = 404 -- Adjust the error state as needed
				SET @CustomError = 50013 -- Define a custom error number as needed
				RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
				RETURN
		END
	END
	
	-- Validate provided email
	IF @email IS NOT NULL  
    BEGIN 
		IF NOT EXISTS (SELECT * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.email = @email) 
			BEGIN 
				SET @Message = 'Error - The specified client does not exist in the database.'
				SET @ErrorSeverity = 1 -- Adjust the severity level as needed
				SET @ErrorState = 404 -- Adjust the error state as needed
				SET @CustomError = 50013 -- Define a custom error number as needed
				RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
				RETURN
		END
	END
	
    -- Check if there is no ongoing transaction
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        BEGIN TRANSACTION
    END

    -- Error handling block
    BEGIN TRY
        -- Custom error code for tracking
        SET @CustomError = 2001

		-- Query for order details
	SELECT 
		ord.idOrder,
		ord.invoiceNumber, 
		ord.date AS emissionDate,
		os.name AS status,
		CASE WHEN @usernameclient IS NULL THEN cl.name ELSE NULL END AS clientName,
		CASE WHEN @usernameclient IS NULL THEN cl.lastName ELSE NULL END AS clientLastName,
		CASE WHEN @usernameclient IS NULL THEN cl.username ELSE NULL END AS clientUsername,
		CASE WHEN @usernameclient IS NULL THEN sh.kilometers ELSE NULL END AS distance
	FROM [support-sales].[support-sales].[sales].Orders ord
		INNER JOIN [support-sales].[support-sales].[sales].OrderStatus os ON os.idOrderStatus = ord.idOrderStatus
		INNER JOIN [support-sales].[support-sales].[sales].Clients cl ON cl.idClient = ord.idClient
		INNER JOIN [support-sales].[support-sales].[sales].Shipping sh ON sh.idShipping = ord.idShipping
	WHERE (@usernameclient IS NULL OR cl.username IN (SELECT TOP 1 username FROM [support-sales].[support-sales].[sales].Clients WHERE username = @usernameclient)) 
    AND (@email IS NULL OR cl.email IN (SELECT TOP 1 email FROM [support-sales].[support-sales].[sales].Clients WHERE email = @email))
	AND (
		@searchparameter IS NULL OR 
		CONVERT(VARCHAR(50), ord.invoiceNumber) LIKE '%' + @searchparameter + '%' OR
		os.name LIKE '%' + @searchparameter + '%' OR
		cl.name LIKE '%' + @searchparameter + '%' OR
		cl.lastName LIKE '%' + @searchparameter + '%' OR
		cl.username LIKE '%' + @searchparameter + '%' OR
		CAST(ord.date AS VARCHAR) LIKE '%' + @searchparameter + '%'
	)
	
	-- Commit transaction if it was initiated
	IF @InicieTransaccion=1 BEGIN
		COMMIT
	END
	END TRY
	
	-- Catch block for handling errors
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		-- Rollback the transaction if it was initiated
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		
		-- Raise a custom error
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END

-- Return 0 to indicate successful execution
RETURN 0
GO

-- Execute the stored procedure with sample parameters
EXEC usp_GetOrdersBySearch @searchparameter='Doe', @usernameclient='client1';


