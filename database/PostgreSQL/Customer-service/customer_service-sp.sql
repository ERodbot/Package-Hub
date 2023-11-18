--Query to get the list of consults in sqlserver

CREATE OR ALTER PROCEDURE usp_getConsultsList
	@name VARCHAR(50) = NULL,
	@lastName VARCHAR(50) = NULL
AS 
BEGIN
    -- Some variable declarations and initialization
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    DECLARE @date DATETIME
    DECLARE @computer VARCHAR(50)
    DECLARE @username VARCHAR(50)
    DECLARE @checksum VARBINARY(150)

    SET @date = GETDATE()
    SET @computer = 'me'
    SET @username = 'root'
    SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

    DECLARE @InicieTransaccion BIT = 0
    

    -- Validaci�n de rol_filter si se proporciona
IF @name IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.name = @name)
    BEGIN 
        SET @Message = 'Error - El cliente con nombre especificado no existe en la base de datos.'
        SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
        SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
        SET @CustomError = 50016 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
        RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
        RETURN
    END
END

-- Validaci�n de country_filter si se proporciona
IF @lastName IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.lastName = @lastName)
    BEGIN 
        SET @Message = 'Error - El cliente con apellido especificado no existe en la base de datos.'
        SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
        SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
        SET @CustomError = 50017 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
        RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
        RETURN
    END
END
  

    -- Verificar si no hay una transacci�n en curso
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        BEGIN TRANSACTION
    END

    -- Inicio de manejo de errores
    BEGIN TRY
        SET @CustomError = 2001

		-- Consulta de servicio al cliente
		SELECT 
			ti.description,
			ti.createdAt,
			ord.invoiceNumber,
			st.name AS ticketState,
			tt.name AS inquiryType,
			cll.date AS callDate,
			ct.name as callType,
			ct.description as callDescription
		FROM [support-sales].[support-sales].[human-resources].Tickets ti
		INNER JOIN  
			 [support-sales].[support-sales].[sales].Orders ord ON ord.idOrder = ti.idOrder
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].TicketType tt ON tt.idTicketType = ti.idTicketType
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].Calls cll  ON cll.idTicket = ti.idTicket
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].CallType ct  ON cll.idTicket = ti.idTicket
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].StateType st  ON st.idStateType = cll.idStateType
		INNER JOIN  
			[support-sales].[support-sales].sales.Clients cli  ON cli.idClient = ord.idClient
		WHERE 
			([support-sales].[support-sales].[human-resources].StateType.name IN ('Open', 'Pending'))
			AND (@name IS NULL OR  cli.name = @name)
			AND (@lastName IS NULL OR cli.lastName = @lastName)
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO




--Query to get the info of a consult in sqlserver

CREATE OR ALTER PROCEDURE usp_getConsultInfo
AS 
BEGIN
    -- Some variable declarations and initialization
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    DECLARE @date DATETIME
    DECLARE @computer VARCHAR(50)
    DECLARE @username VARCHAR(50)
    DECLARE @checksum VARBINARY(150)

    SET @date = GETDATE()
    SET @computer = 'me'
    SET @username = 'root'
    SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

    DECLARE @InicieTransaccion BIT = 0
    

    -- Validaci�n de rol_filter si se proporciona
IF @name IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.name = @name)
    BEGIN 
        SET @Message = 'Error - El cliente con nombre especificado no existe en la base de datos.'
        SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
        SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
        SET @CustomError = 50016 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
        RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
        RETURN
    END
END

-- Validaci�n de country_filter si se proporciona
IF @lastName IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.lastName = @lastName)
    BEGIN 
        SET @Message = 'Error - El cliente con apellido especificado no existe en la base de datos.'
        SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
        SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
        SET @CustomError = 50017 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
        RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
        RETURN
    END
END
  

    -- Verificar si no hay una transacci�n en curso
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        BEGIN TRANSACTION
    END

    -- Inicio de manejo de errores
    BEGIN TRY
        SET @CustomError = 2001

		-- Consulta de servicio al cliente
		SELECT 
			ti.description,
			ti.createdAt,
			ord.invoiceNumber,
			st.name AS ticketState,
			tt.name AS inquiryType,
			cll.date AS callDate,
			ct.name as callType,
			ct.description as callDescription
		FROM [support-sales].[support-sales].[human-resources].Tickets ti
		INNER JOIN  
			 [support-sales].[support-sales].[sales].Orders ord ON ord.idOrder = ti.idOrder
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].TicketType tt ON tt.idTicketType = ti.idTicketType
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].Calls cll  ON cll.idTicket = ti.idTicket
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].CallType ct  ON cll.idTicket = ti.idTicket
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].StateType st  ON st.idStateType = cll.idStateType
		INNER JOIN  
			[support-sales].[support-sales].sales.Clients cli  ON cli.idClient = ord.idClient
		WHERE 
			([support-sales].[support-sales].[human-resources].StateType.name IN ('Open', 'Pending'))
			AND (@name IS NULL OR  cli.name = @name)
			AND (@lastName IS NULL OR cli.lastName = @lastName)
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO








CREATE OR ALTER PROCEDURE usp_getConsultInfo
AS 
BEGIN
    -- Some variable declarations and initialization
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    DECLARE @date DATETIME
    DECLARE @computer VARCHAR(50)
    DECLARE @username VARCHAR(50)
    DECLARE @checksum VARBINARY(150)

    SET @date = GETDATE()
    SET @computer = 'me'
    SET @username = 'root'
    SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

    DECLARE @InicieTransaccion BIT = 0
    

    -- Validaci�n de rol_filter si se proporciona
IF @name IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.name = @name)
    BEGIN 
        SET @Message = 'Error - El cliente con nombre especificado no existe en la base de datos.'
        SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
        SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
        SET @CustomError = 50016 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
        RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
        RETURN
    END
END

-- Validaci�n de country_filter si se proporciona
IF @lastName IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.lastName = @lastName)
    BEGIN 
        SET @Message = 'Error - El cliente con apellido especificado no existe en la base de datos.'
        SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
        SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
        SET @CustomError = 50017 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
        RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
        RETURN
    END
END
  

    -- Verificar si no hay una transacci�n en curso
    IF @@TRANCOUNT = 0
    BEGIN
        SET @InicieTransaccion = 1
        SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        BEGIN TRANSACTION
    END

    -- Inicio de manejo de errores
    BEGIN TRY
        SET @CustomError = 2001

		-- Consulta de servicio al cliente
		SELECT 
			ti.description,
			ti.createdAt,
			ord.invoiceNumber,
			st.name AS ticketState,
			tt.name AS inquiryType,
			cll.date AS callDate,
			ct.name as callType,
			ct.description as callDescription
		FROM [support-sales].[support-sales].[human-resources].Tickets ti
		INNER JOIN  
			 [support-sales].[support-sales].[sales].Orders ord ON ord.idOrder = ti.idOrder
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].TicketType tt ON tt.idTicketType = ti.idTicketType
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].Calls cll  ON cll.idTicket = ti.idTicket
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].CallType ct  ON cll.idTicket = ti.idTicket
		INNER JOIN  
			[support-sales].[support-sales].[human-resources].StateType st  ON st.idStateType = cll.idStateType
		INNER JOIN  
			[support-sales].[support-sales].sales.Clients cli  ON cli.idClient = ord.idClient
		WHERE 
			([support-sales].[support-sales].[human-resources].StateType.name IN ('Open', 'Pending'))
			AND (@name IS NULL OR  cli.name = @name)
			AND (@lastName IS NULL OR cli.lastName = @lastName)
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO



-------------------------------------------------------------------------
-- Insert Ticket
-------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE "customer-service"."InsertTicket"(
    IN p_description text,
    IN p_createdAt timestamp with time zone,
    IN p_updatedAt timestamp with time zone,
    IN p_idTicketType integer,
    IN p_idOrder integer,
    IN p_idClient integer
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    INSERT INTO "customer-service"."Tickets" (
        description,
        "createdAt",
        "updatedAt",
        "idTicketType",
        "idOrder",
        "idClient"
    ) VALUES (
        p_description,
        p_createdAt,
        p_updatedAt,
        p_idTicketType,
        p_idOrder,
        p_idClient
    );
END;
$procedure$;
-- CALL "customer-service"."InsertTicket"('Descripción del ticket', NOW(), NOW(), 1, 123, 456);
