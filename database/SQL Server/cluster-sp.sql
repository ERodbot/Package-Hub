

-- Procedure to register a client
CREATE OR ALTER PROCEDURE registerClient
    @name nvarchar(50),
    @lastName nvarchar(50),
    @username nvarchar(50),
    @email nvarchar(50),
    @phone nvarchar(50),
    @address nvarchar(80),
    @city nvarchar(45),
    @country nvarchar(45),
    @postalCode int,
    @password nvarchar(50)
AS
BEGIN
    -- Check if the user already exists
    IF EXISTS (SELECT email FROM [support-sales].[support-sales].[sales].Clients WHERE email = @email)
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(200) = 'User already exists';
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

    -- Declare variables for stored procedure use
    DECLARE @idAddress int;
    DECLARE @idContact int;
    DECLARE @idCity int;
    DECLARE @idAddressType int;
    DECLARE @idContactType int;
	DECLARE @idClient int;
	DECLARE @idGeoposition int;
	DECLARE @geopositionTable TABLE (id INT);
	DECLARE @spQuery NVARCHAR(MAX);


    -- Get id for the AddressType and ContactType
    SELECT @idAddressType = idAddressType FROM hr.[human-resources]..AddressType WHERE name = 'Personal';
    SELECT @idContactType = idContactType FROM hr.[human-resources]..ContactType WHERE name = 'Personal';

    -- Get id for City
    SELECT @idCity = idCity FROM hr.[human-resources]..City WHERE name = @city;
	
	-- Get the last id inserted into Clients
	SELECT TOP 1 @idClient = idClient FROM [support-sales].[support-sales].[sales].Clients ORDER BY idClient DESC;

	-- First 2 numbers should be replaced with something logical, not random numbers, third number should be idClient
	-- Insert into LocationXClient
	SET @idClient += 1;
	EXEC ('EXEC [inventory].[dbo].addPositionClient @latitude = ?, @longitude = ?, @idClient = ?', 10.43, 45.43, 1) AT [na-inventory];


	-- Get the last id inserted into LocationXClient
	INSERT INTO @geopositionTable
	EXEC ('EXEC [inventory].[dbo].getGeopositionClient') AT [na-inventory];

	SELECT @idGeoposition = id FROM @geopositionTable;


    -- Insert new Address into Address table
	-- Constructing the SQL query
	SET @spQuery = N'CALL InsertNewAddress(' + 
             dbo.ConcatString(@address) + ', ' +  -- Address with single quotes escaped
             dbo.ConcatInteger(@postalCode) + ', ' +  -- Postal Code
             dbo.ConcatInteger(@idAddressType) + ', ' +  -- Address Type ID
             dbo.ConcatInteger(@idCity) + ', ' +  -- City ID
             dbo.ConcatInteger(@idGeoposition) + ')';  -- Geoposition ID


-- Executing the query on the linked server
	BEGIN TRY
		EXEC (@spQuery) AT [hr];
	END TRY
	BEGIN CATCH
		PRINT 'Error occurred during execution: ' + @spQuery;
		THROW;  -- Re-throw the caught exception
	END CATCH 

    -- Get newly inserted Address id
    SELECT TOP 1 @idAddress = idAddress FROM hr.[human-resources]..Address ORDER BY idAddress DESC;
	
    -- Insert new Contact into Contact table
	SET @spQuery = N'CALL InsertNewContactInfo(' +
				dbo.ConcatString(@phone) + ', ' +
				dbo.ConcatString(@email) + ', ' +
				dbo.ConcatInteger(@idContactType) + ')';


	BEGIN TRY
		EXEC (@spQuery) AT [hr];
	END TRY
	BEGIN CATCH
		PRINT 'Error occurred during execution: ' + @spQuery;
		THROW;  -- Re-throw the caught exception
	END CATCH 

    -- Get newly inserted Contact id
    SELECT TOP 1 @idContact = idContactInfo FROM hr.[human-resources]..ContactInfo ORDER BY idContactInfo DESC;

    -- Insert new Client into Client table
	BEGIN TRY
		EXEC ('CALL registerClient(?, ?, ?, ?, ?, ?, ?)', @email, @username, @name, @lastName, @idAddress, @idContact, @password) AT [support-sales];
	END TRY
	BEGIN CATCH
		PRINT 'Error occurred during execution: ';
		THROW;  -- Re-throw the caught exception
	END CATCH 

END;

---------------------------------------------------------------------------------------------------

--procedure to login a client

CREATE OR ALTER PROCEDURE loginClient
	@username nvarchar(50),
	@password nvarchar(50)
AS
BEGIN
	-- Check if the user already exists
	IF NOT EXISTS (SELECT username FROM [support-sales].[support-sales].[sales].Clients WHERE username = @username)
	BEGIN
		DECLARE @ErrorMessage NVARCHAR(400) = 'User does not exist';
		RAISERROR(@ErrorMessage, 16, 1);
		RETURN;
	END

	-- Check if the password is correct
	IF NOT EXISTS (SELECT username FROM [support-sales].[support-sales].[sales].Clients WHERE username = @username AND password = @password)
	BEGIN
		DECLARE @ErrorMessagex NVARCHAR(400) = 'Wrong password';
		RAISERROR(@ErrorMessagex, 16, 1);
		RETURN;
	END
	SELECT username FROM [support-sales].[support-sales].[sales].Clients WHERE username = @username AND password = @password
END;

---------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[GetProductsByCategory]
    @categoryId INT
AS
BEGIN
    EXEC ('EXEC [inventory].[dbo].GetProductsByCategory @categoryId = ?', @categoryId) AT [na-inventory];

END;

----------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[GetProductDetails]
    @productName NVARCHAR(100)  
AS
BEGIN
    EXEC ('EXEC [inventory].[dbo].[GetProductDetails] @productName = ?', @productName) AT [na-inventory];
END;

-----------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[GetProductImages]
    @productName NVARCHAR(100)
AS
BEGIN
    EXEC ('EXEC [inventory].[dbo].[[GetProductImages]] @productName = ?', @productName) AT [na-inventory];
END;
GO

-----------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE UpdateProductQuantity
    @productName NVARCHAR(100),
    @quantityToSubtract INT
AS
BEGIN
    EXEC ('EXEC [inventory].[dbo].[UpdateProductQuantity] @productName = ?, @quantityToSubtract =?', @productName, @quantityToSubtract) AT [na-inventory];
END;
GO

-------------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ValidateProductAvailability
    @productName NVARCHAR(100),
    @quantityToCheck INT,
    @result INT OUTPUT
AS
BEGIN
    EXEC ('EXEC [inventory].[dbo].[ValidateProductAvailability] @productName = ?, @quantityToCheck = ?, @result = ? OUTPUT', @productName, @quantityToCheck, @result OUTPUT) AT [na-inventory];
END;
GO
---------------------------------------------------------------------------------------------------



CREATE OR ALTER PROCEDURE usp_ReportingByPerformance
@initial_date DATE = NULL,
@final_date DATE = NULL,
@role_filter VARCHAR(50) = NULL,
@country_filter VARCHAR(50) = NULL AS BEGIN -- Some variable declarations and initialization
DECLARE @ErrorNumber INT,
    @ErrorSeverity INT,
    @ErrorState INT,
    @CustomError INT
DECLARE @Message VARCHAR(200)
DECLARE @date DATETIME
DECLARE @computer VARCHAR(50)
DECLARE @username VARCHAR(50)
DECLARE @checksum VARBINARY(150)
SET @date = GETDATE()
SET @computer = 'me'
SET @username = 'root'
SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')
DECLARE @InicieTransaccion BIT = 0 -- Validación de fechas si se proporcionan
    IF (
        @initial_date IS NOT NULL
        AND @final_date IS NOT NULL
    )
    AND @initial_date > @final_date BEGIN
SET @Message = 'Error - La fecha inicial no puede ser posterior a la fecha final.'
SET @ErrorSeverity = ERROR_SEVERITY()
SET @ErrorState = ERROR_STATE()
SET @CustomError = 50000 RAISERROR(
        '%s - Error Number: %i',
        @ErrorSeverity,
        @ErrorState,
        @Message,
        @CustomError
    ) RETURN
END -- Validación de rol_filter si se proporciona
IF @role_filter IS NOT NULL BEGIN IF NOT EXISTS (
    SELECT 1
    FROM hr.[human-resources]..Role
    WHERE Role.name = @role_filter
) BEGIN
SET @Message = 'Error - El rol especificado no existe en la base de datos.'
SET @ErrorSeverity = 16 -- Puedes ajustar el nivel de severidad según tus necesidades
SET @ErrorState = 2 -- Puedes ajustar el estado de error según tus necesidades
SET @CustomError = 50001 -- Puedes definir un número de error personalizado según tus necesidades
    RAISERROR(
        '%s - Error Number: %i',
        @ErrorSeverity,
        @ErrorState,
        @Message,
        @CustomError
    ) RETURN
END
END -- Validación de country_filter si se proporciona
IF @country_filter IS NOT NULL BEGIN IF NOT EXISTS (
    SELECT 1
    FROM hr.[human-resources]..Country
    WHERE Country.name = @country_filter
) BEGIN
SET @Message = 'Error - El país especificado no existe en la base de datos.'
SET @ErrorSeverity = 16 -- Puedes ajustar el nivel de severidad según tus necesidades
SET @ErrorState = 3 -- Puedes ajustar el estado de error según tus necesidades
SET @CustomError = 50002 -- Puedes definir un número de error personalizado según tus necesidades
    RAISERROR(
        '%s - Error Number: %i',
        @ErrorSeverity,
        @ErrorState,
        @Message,
        @CustomError
    ) RETURN
END
END -- Inicialización de variables
-- Verificar si no hay una transacción en curso
IF @@TRANCOUNT = 0 BEGIN
SET @InicieTransaccion = 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED BEGIN TRANSACTION
END -- Inicio de manejo de errores
BEGIN TRY
SET @CustomError = 2001 -- Consulta de rendimiento de empleados
SELECT emp.name,
    emp.lastName,
    emmper.rating,
    ci.phone,
    ci.email,
    dep.name AS department,
    rol.name AS employeeRole,
    co.name AS country,
    st.name AS state,
    cit.name AS city,
    ad.street AS address
FROM hr.[human-resources]..PerfomanceByEmployee emmper
    INNER JOIN hr.[human-resources]..Employee emp ON emp.idEmployee = emmper.idEmpleado
    INNER JOIN hr.[human-resources]..ContactInfo ci ON ci.idContactInfo = emp.idContactInfo
    INNER JOIN hr.[human-resources]..Address ad ON ad.idAddress = emp.idAddress
    INNER JOIN hr.[human-resources]..City cit ON cit.idCity = ad.idCity
    INNER JOIN hr.[human-resources]..State st ON st.idState = cit.idState
    INNER JOIN hr.[human-resources]..Country co ON co.idCountry = st.idCountry
    INNER JOIN hr.[human-resources]..Role rol ON rol.idRole = emp.idRole
    INNER JOIN hr.[human-resources]..Departments dep ON dep.idDepartments = rol.idDepartments
WHERE (
        @initial_date IS NULL
        OR emmper.startDate BETWEEN @initial_date AND @final_date
    )
    AND (
        @final_date IS NULL
        OR emmper.endDate BETWEEN emmper.startDate AND @final_date
    )
    AND (
        @role_filter IS NULL
        OR emp.idRole IN (
            SELECT idRole
            FROM hr.[human-resources]..Role
            WHERE Role.name = @role_filter
        )
    )
    AND (
        @country_filter IS NULL
        OR st.idCountry IN (
            SELECT idCountry
            FROM hr.[human-resources]..Country
            WHERE Country.name = @country_filter
        )
    ) IF @InicieTransaccion = 1 BEGIN COMMIT
END
END TRY BEGIN CATCH
SET @ErrorNumber = ERROR_NUMBER()
SET @ErrorSeverity = ERROR_SEVERITY()
SET @ErrorState = ERROR_STATE()
SET @Message = ERROR_MESSAGE() IF @InicieTransaccion = 1 BEGIN ROLLBACK
END RAISERROR(
    '%s - Error Number: %i',
    @ErrorSeverity,
    @ErrorState,
    @Message,
    @CustomError
)
END CATCH
END RETURN 0
GO

---------------------------------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE usp_ReportingSalaryStructure
@initial_date DATE = NULL,
@final_date DATE = NULL AS BEGIN -- Some variable declarations and initialization
DECLARE @ErrorNumber INT,
    @ErrorSeverity INT,
    @ErrorState INT,
    @CustomError INT
DECLARE @Message VARCHAR(200)
DECLARE @date DATETIME
DECLARE @computer VARCHAR(50)
DECLARE @username VARCHAR(50)
DECLARE @checksum VARBINARY(150)
SET @date = GETDATE()
SET @computer = 'me'
SET @username = 'root'
SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')
DECLARE @InicieTransaccion BIT = 0 -- Validación de fechas si se proporcionan
    IF (
        @initial_date IS NOT NULL
        AND @final_date IS NOT NULL
    )
    AND @initial_date > @final_date BEGIN
SET @Message = 'Error - La fecha inicial no puede ser posterior a la fecha final.'
SET @ErrorSeverity = ERROR_SEVERITY()
SET @ErrorState = ERROR_STATE()
SET @CustomError = 50000 RAISERROR(
        '%s - Error Number: %i',
        @ErrorSeverity,
        @ErrorState,
        @Message,
        @CustomError
    ) RETURN
END -- Inicialización de variables
-- Verificar si no hay una transacción en curso
IF @@TRANCOUNT = 0 BEGIN
SET @InicieTransaccion = 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED BEGIN TRANSACTION
END -- Inicio de manejo de errores
BEGIN TRY
SET @CustomError = 2001 -- Consulta de rendimiento de empleados
SELECT emp.name,
    emp.lastName,
    dep.name AS department,
    rol.name AS employeeRole,
    co.name AS country,
    pbe.startDate,
    pbe.endDate,
    pbe.grossSalary,
    pbe.netSalary,
    red.name reduction,
    redbc.percentage
FROM hr.[human-resources]..PerfomanceByEmployee emmper
    INNER JOIN hr.[human-resources]..Employee emp ON emp.idEmployee = emmper.idEmpleado
    INNER JOIN hr.[human-resources]..Address ad ON ad.idAddress = emp.idAddress
    INNER JOIN hr.[human-resources]..City cit ON cit.idCity = ad.idCity
    INNER JOIN hr.[human-resources]..State st ON st.idState = cit.idState
    INNER JOIN hr.[human-resources]..Country co ON co.idCountry = st.idCountry
    INNER JOIN hr.[human-resources]..Role rol ON rol.idRole = emp.idRole
    INNER JOIN hr.[human-resources]..Departments dep ON dep.idDepartments = rol.idDepartments
    INNER JOIN hr.[human-resources]..ReductionbyCountry redbc ON co.idCountry = redbc.idCountry
    INNER JOIN hr.[human-resources]..Reduction red ON red.idReduction = redbc.idReduction
    INNER JOIN hr.[human-resources]..PayByEmployee pbe ON emp.idEmployee = pbe.idEmployee
WHERE (
        @initial_date IS NULL
        OR pbe.startDate BETWEEN @initial_date AND @final_date
    )
    AND (
        @final_date IS NULL
        OR pbe.endDate BETWEEN pbe.startDate AND @final_date
    ) IF @InicieTransaccion = 1 BEGIN COMMIT
END
END TRY BEGIN CATCH
SET @ErrorNumber = ERROR_NUMBER()
SET @ErrorSeverity = ERROR_SEVERITY()
SET @ErrorState = ERROR_STATE()
SET @Message = ERROR_MESSAGE() IF @InicieTransaccion = 1 BEGIN ROLLBACK
END RAISERROR(
    '%s - Error Number: %i',
    @ErrorSeverity,
    @ErrorState,
    @Message,
    @CustomError
)
END CATCH
END RETURN 0
GO

---------------------------------------------------------------------------------------------------



-- EXEC usp_ReportingByPerformance;
--     EXEC usp_ReportingByPerformance 
--        @initial_date = '2023-11-01',
--        @final_date = '2023-11-30',
--        @role_filter = 'Gerente' ,
--        @country_filter = 'Estados Unidos';
--     EXEC usp_ReportingByPerformance 
--        @initial_date = '2023-11-30',
--        @final_date = '2023-11-01';
--     EXEC usp_ReportingByPerformance  
--        @role_filter = 'RolInexistente';
--     EXEC usp_ReportingByPerformance 
--        @country_filter = 'PaísInexistente';
--     EXEC usp_ReportingByPerformance 
--        @initial_date = '2023-11-01',
--        @final_date = '2023-11-30',
--        @role_filter = 'Asistente de Soporte',
--        @country_filter = 'Japón';

-- EXEC usp_ReportingSalaryStructure; 
-- EXEC usp_ReportingSalaryStructure
--    @initial_date = '2023-11-01',
--    @final_date = '2023-11-30'; 
-- EXEC usp_ReportingSalaryStructure
--    @initial_date = '2023-11-30',
--    @final_date = '2023-11-01';


--EXEC usp_ReportingByPerformance;
--     EXEC usp_ReportingByPerformance 
--    @initial_date = '2023-11-01',
--    @final_date = '2023-11-30',
--    @role_filter = 'Gerente',
--    @country_filter = 'Estados Unidos';


-- EXEC usp_ReportingByPerformance 
--    @initial_date = '2023-11-30',
--    @final_date = '2023-11-01';


-- EXEC usp_ReportingByPerformance  
--    @role_filter = 'RolInexistente';


-- EXEC usp_ReportingByPerformance 
--    @country_filter = 'Pa�sInexistente';


-- EXEC usp_ReportingByPerformance 
--    @initial_date = '2023-11-01',
--    @final_date = '2023-11-30',
--    @role_filter = 'Asistente de Soporte',
--    @country_filter = 'Jap�n';

 


-- EXEC usp_ReportingSalaryStructure; 

-- EXEC usp_ReportingSalaryStructure
--    @initial_date = '2023-11-01',
--    @final_date = '2023-11-30'; 


-- EXEC usp_ReportingSalaryStructure
--    @initial_date = '2023-11-30',
--    @final_date = '2023-11-01'; 

-------------------------------------------------------------------------
-- Insert Order Details
-------------------------------------------------------------------------

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

-- EXEC insert_order_detail @in_order_id = 1, @in_product_id = 2, @in_quantity = 3, @in_price_unit = 40.00, @in_discount = 15.00



-------------------------------------------------------------------------
-- Verify product quantity price
-------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE calculate_total_price
	 @productName NVARCHAR(100),  
	 @in_quantity INT,
	 @in_discount FLOAT,
	 @out_total FLOAT
AS
BEGIN
	DECLARE @currentPrice MONEY;
	DECLARE @currentPriceF FLOAT;

	IF EXISTS (SELECT 1 FROM [cluster].[dbo].[Products] WHERE name = @productName)
    BEGIN
        SELECT @currentPrice = Pr.price 
        FROM
            [cluster].[dbo].[Products] AS Pr
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

-- EXEC calculate_total_price @productName = 'Bolitas de queso', @in_quantity = 3,  @in_discount = 0, @out_total = NULL

--------------------------------------------------------------------------------------
-- Muetsra reporte por fechas que se puede filtrar por producto, categoria y fecha
-------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Si da un error sobre Support sales es que hay que correr primero todos los procedures de sales
---------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE viewReport
    @productName NVARCHAR(30) = NULL,
	@categoryName NVARCHAR(30) = NULL,
    @startDate DATE = NULL
AS
BEGIN
    -- Crear una tabla temporal
    CREATE TABLE TempProductList (
        [idProduct] INT,
        [name] NVARCHAR(30), 
		[categoryName] NVARCHAR(30)
    );

    -- Insertar datos en la tabla temporal desde el procedimiento [na-inventory].[inventory].[dbo].[GetAllProducts]
    INSERT INTO TempProductList ([idProduct], [name], [categoryName])
    EXEC [na-inventory].[inventory].[dbo].[GetAllProducts];

    -- Crear o alterar la tabla permanente
    IF OBJECT_ID('dbo.TempReportResults') IS NULL
    BEGIN
        CREATE TABLE dbo.TempReportResults (
            [clientName] NVARCHAR(255),
            [clientEmail] NVARCHAR(255),
            [orderDate] DATE,
            [productName] NVARCHAR(255),
            [categoryName] NVARCHAR(255),
            [quantity] INT,
            [Total] MONEY
        );
    END
    ELSE
    BEGIN
        -- Puedes realizar acciones adicionales si la tabla ya existe, por ejemplo, truncarla
        TRUNCATE TABLE dbo.TempReportResults;
    END;

    -- Insertar resultados en la tabla permanente
    INSERT INTO dbo.TempReportResults ([clientName], [clientEmail], [orderDate], [productName], [categoryName], [quantity], [Total])
    SELECT
        vr.[clientName],
        vr.[clientEmail],
        vr.[orderDate],
        p.[name], -- Refiriéndose al nombre obtenido en el JOIN
        p.[categoryName],
        vr.[quantity],
        vr.[lineTotal] AS Total
    FROM OPENQUERY([support-sales], 'SELECT * FROM public.get_sales_report()') vr
    LEFT JOIN TempProductList p ON vr."idProduct" = p."idProduct"
    WHERE
        (@productName IS NULL OR p.[name] LIKE '%' + @productName + '%')
        AND (@startDate IS NULL OR vr.[orderDate] >= @startDate)
		AND (@categoryName IS NULL OR p.[categoryName] LIKE '%' + @categoryName + '%');

    -- Seleccionar desde la tabla permanente para mostrar los datos
		SELECT * FROM dbo.TempReportResults;

    -- Eliminar las tablas temporales al finalizar el procedimiento
    DROP TABLE dbo.TempProductList;
END;

-- SELECT * FROM dbo.TempReportResults
-- EXEC viewReport  @productName = 'Bolitas de queso', @categoryName = 'snacks';


CREATE OR ALTER PROCEDURE viewSalesReport
    @productName NVARCHAR(30) = NULL,
	@categoryName NVARCHAR(30) = NULL,
    @startDate DATE = NULL
AS
BEGIN
	EXEC viewReport  @productName = @productName , @categoryName = @categoryName, @startDate = @startDate;
	SELECT * FROM dbo.TempReportResults
END;

-- EXEC viewSalesReport  @productName = 'Bolitas de queso'

--------------------------------------------------------------------------------------
-- Crear un ticket de complaint (estoy seguro que esta bien pero no corre, debe haber un error de sintaxis)
-------------------------------------------------------------------------------------

DROP PROCEDURE insertTicket

CREATE OR ALTER PROCEDURE insertTicket
    @p_description NVARCHAR(MAX),
    @p_createdAt DATETIMEOFFSET,
    @p_updatedAt DATETIMEOFFSET,
    @p_idTicketType INT,
    @p_idOrder INT,
    @p_idClient INT
AS
BEGIN
	EXEC ('CALL InsertTicket(?, ?, ?, ?, ?, ?)', @p_description, @p_createdAt, @p_updatedAt, @p_idTicketType, @p_idOrder, @p_idClient ) AT [support-sales];
END;
GO

-- EXEC insertTicket @p_description = 'Descripción del ticket', @p_createdAt = GETDATE(), @p_updatedAt = GETDATE(),  @p_idTicketType = 1,  @p_idOrder = 22,  @p_idClient = 456

CREATE OR ALTER PROCEDURE createOrderDetail
    @orderid INT,
    @product varchar(MAX),
    @quantity INT,
    @price FLOAT,
    @discount FLOAT
AS
BEGIN
    DECLARE @idProduct INT;

    -- Obtener el idProduct utilizando una variable local
    (SELECT TOP 1 @idProduct = idProduct FROM [na-inventory].[inventory].[dbo].[Products] WHERE [name] = @product)

    BEGIN TRY
        -- Ejecutar el procedimiento almacenado en el servidor remoto
        EXEC('CALL insert_order_detail(?,?,?,?,?)',
            @orderid,
            @idProduct,
            @quantity,
            @price,
            @discount) AT [support-sales]
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred during execution: ' + ERROR_MESSAGE();
        THROW;  -- Re-throw the caught exception
    END CATCH
END;


--Query to get the list of consults in sqlserver
---------------------------------------------------------------------------------------------------

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

---------------------------------------------------------------------------------------------------
--Query to get the info of a consult in sqlserver
CREATE OR ALTER PROCEDURE usp_getConsultInfo
-- AS 
-- BEGIN
--     -- Some variable declarations and initialization
--     DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
--     DECLARE @Message VARCHAR(200)
--     DECLARE @date DATETIME
--     DECLARE @computer VARCHAR(50)
--     DECLARE @username VARCHAR(50)
--     DECLARE @checksum VARBINARY(150)

--     SET @date = GETDATE()
--     SET @computer = 'me'
--     SET @username = 'root'
--     SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

--     DECLARE @InicieTransaccion BIT = 0
    

--     -- Validaci�n de rol_filter si se proporciona
-- IF @name IS NOT NULL
-- BEGIN
--     IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.name = @name)
--     BEGIN 
--         SET @Message = 'Error - El cliente con nombre especificado no existe en la base de datos.'
--         SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
--         SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
--         SET @CustomError = 50016 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
--         RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
--         RETURN
--     END
-- END

-- -- Validaci�n de country_filter si se proporciona
-- IF @lastName IS NOT NULL
-- BEGIN
--     IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.lastName = @lastName)
--     BEGIN 
--         SET @Message = 'Error - El cliente con apellido especificado no existe en la base de datos.'
--         SET @ErrorSeverity = 2 -- Puedes ajustar el nivel de severidad seg�n tus necesidades
--         SET @ErrorState = 2 -- Puedes ajustar el estado de error seg�n tus necesidades
--         SET @CustomError = 50017 -- Puedes definir un n�mero de error personalizado seg�n tus necesidades
--         RAISERROR('%s - Error Number: %i', @ErrorSeverity, @ErrorState, @Message, @CustomError)
--         RETURN
--     END
-- END
  

--     -- Verificar si no hay una transacci�n en curso
--     IF @@TRANCOUNT = 0
--     BEGIN
--         SET @InicieTransaccion = 1
--         SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--         BEGIN TRANSACTION
--     END

--     -- Inicio de manejo de errores
--     BEGIN TRY
--         SET @CustomError = 2001

-- 		-- Consulta de servicio al cliente
-- 		SELECT 
-- 			ti.description,
-- 			ti.createdAt,
-- 			ord.invoiceNumber,
-- 			st.name AS ticketState,
-- 			tt.name AS inquiryType,
-- 			cll.date AS callDate,
-- 			ct.name as callType,
-- 			ct.description as callDescription
-- 		FROM [support-sales].[support-sales].[human-resources].Tickets ti
-- 		INNER JOIN  
-- 			 [support-sales].[support-sales].[sales].Orders ord ON ord.idOrder = ti.idOrder
-- 		INNER JOIN  
-- 			[support-sales].[support-sales].[human-resources].TicketType tt ON tt.idTicketType = ti.idTicketType
-- 		INNER JOIN  
-- 			[support-sales].[support-sales].[human-resources].Calls cll  ON cll.idTicket = ti.idTicket
-- 		INNER JOIN  
-- 			[support-sales].[support-sales].[human-resources].CallType ct  ON cll.idTicket = ti.idTicket
-- 		INNER JOIN  
-- 			[support-sales].[support-sales].[human-resources].StateType st  ON st.idStateType = cll.idStateType
-- 		INNER JOIN  
-- 			[support-sales].[support-sales].sales.Clients cli  ON cli.idClient = ord.idClient
-- 		WHERE 
-- 			([support-sales].[support-sales].[human-resources].StateType.name IN ('Open', 'Pending'))
-- 			AND (@name IS NULL OR  cli.name = @name)
-- 			AND (@lastName IS NULL OR cli.lastName = @lastName)
-- 		IF @InicieTransaccion=1 BEGIN
-- 			COMMIT
-- 		END
-- 	END TRY
-- 	BEGIN CATCH
-- 		SET @ErrorNumber = ERROR_NUMBER()
-- 		SET @ErrorSeverity = ERROR_SEVERITY()
-- 		SET @ErrorState = ERROR_STATE()
-- 		SET @Message = ERROR_MESSAGE()
		
-- 		IF @InicieTransaccion=1 BEGIN
-- 			ROLLBACK
-- 		END
-- 		RAISERROR('%s - Error Number: %i', 
-- 			@ErrorSeverity, @ErrorState, @Message, @CustomError)
-- 	END CATCH	
-- END
-- RETURN 0
-- GO








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





--Procedure to get orders by search

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


--procedure to get orders list

CREATE OR ALTER PROCEDURE usp_GetOrdersList
    @usernameclient VARCHAR(100) = NULL,
    @email VARCHAR(100) = NULL
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
        IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales]. [support-sales].[sales].Clients WHERE Clients.email = @email) 
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
        SET @CustomError = 2001

        -- Query for order details without OPENQUERY
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
        WHERE 
            (@usernameclient IS NULL OR cl.username IN (SELECT TOP 1 username FROM [support-sales].[support-sales].[sales].Clients WHERE username = @usernameclient)) 
            AND (@email IS NULL OR cl.email IN (SELECT TOP 1 email FROM [support-sales].[support-sales].[sales].Clients WHERE email = @email))

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




--procedure to getReceipt

CREATE OR ALTER PROCEDURE getReceipt
    @invoiceNumber VARCHAR(100)  
AS
BEGIN
	SELECT cl.name,
		   cl.lastName,
		   cl.email,
		   ord.invoiceNumber,
		   ord.total,
		   ordd.lineTotal,
		   prod.name
	FROM [support-sales].[support-sales].[sales].Clients cl
		INNER JOIN [support-sales].[support-sales].[sales].Orders ord ON ord.idClient = cl.idClient 
		INNER JOIN [support-sales].[support-sales].[sales].OrderDetails ordd ON ordd.idOrder = ord.idOrder
		INNER JOIN [na-inventory].[inventory].[dbo].Products prod ON prod.idProduct = ordd.idProduct 
	WHERE ord.invoiceNumber = @invoiceNumber
END;



CREATE OR ALTER PROCEDURE usp_GetBranchList
AS 
BEGIN
   SELECT bo.branchName,
		  
		  bo.opens,
		  bo.closes,
		  co.name AS country,
		  cu.name AS currency,
		  emp.name AS clientName,
		  emp.lastName AS clientLastName,

	FROM [support-sales].[support-sales].[sales].BranchOffice bo
	INNER JOIN [hr].[human-resources]..Country as co ON co.idCountry = bo.idCountry
	INNER JOIN [hr].[human-resources]..Currency as cu ON cu.idCurrency = bo.idCurrency
	INNER JOIN [hr].[human-resources]..Employee as cl ON emp.idClient = bo.idManager
END
RETURN 0
GO

 EXEC usp_GetBranchList




CREATE OR ALTER PROCEDURE usp_updateBranchData
    @branchNameNew NVARCHAR(MAX),
    @branchNameOld NVARCHAR(MAX),
    @opens NVARCHAR(MAX),
    @closes NVARCHAR(MAX),
    @description NVARCHAR(MAX),
    @currency NVARCHAR(MAX),
    @managerName NVARCHAR(MAX),
	@managerLastName NVARCHAR(MAX),
    @country NVARCHAR(MAX)
AS 
BEGIN
    DECLARE @idCountry INT;
    DECLARE @idManager INT;
    DECLARE @idCurrency INT;

    SELECT @idCountry = idCountry FROM [hr].[human-resources]..Country WHERE name = @country;
    SELECT @idManager = idEmployee FROM [hr].[human-resources]..Employee WHERE name = @managerName AND lastName = @managerLastName;
    SELECT @idCurrency = idCurrency FROM [hr].[human-resources]..Currency WHERE name = @currency;

    UPDATE [support-sales].[support-sales].[sales].BranchOffice
    SET idCountry = @idCountry,
        idManager = @idManager,
        idCurrency = @idCurrency,
        opens = @opens,
        closes = @closes,
        description = @description,
        branchName = @branchNameNew
    WHERE branchName = @branchNameOld;

    RETURN 0;
END;


	
------------------------------------------------------------------------
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

CREATE OR ALTER PROCEDURE usp_GetOrdersListClient
    @usernameclient VARCHAR(100) = NULL,
    @email VARCHAR(100) = NULL
AS 
BEGIN
    -- Variable declarations and initialization
    DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
    DECLARE @Message VARCHAR(200)
    
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
        IF NOT EXISTS (SELECT TOP 1 * FROM [support-sales].[support-sales].[sales].Clients WHERE Clients.email = @email) 
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
        SET @CustomError = 2001

        -- Query for order details without OPENQUERY
        SELECT 
            ord.invoiceNumber, 
            ord.date AS emissionDate,
            os.name AS status,
            sh.kilometers AS distance
        FROM [support-sales].[support-sales].[sales].Orders ord
            INNER JOIN [support-sales].[support-sales].[sales].OrderStatus os ON os.idOrderStatus = ord.idOrderStatus
            INNER JOIN [support-sales].[support-sales].[sales].Shipping sh ON sh.idShipping = ord.idShipping
            LEFT JOIN [support-sales].[support-sales].[sales].Clients cl ON cl.idClient = ord.idClient
        WHERE 
            (@usernameclient IS NULL OR cl.username = @usernameclient) 
            AND (@email IS NULL OR cl.email = @email)

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

-- EXEC usp_GetOrdersListClient



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

--procedure to get register employee

CREATE or alter PROCEDURE [dbo].[registerEmployee]
	@name nvarchar(50),
    @lastName nvarchar(50),
    @username nvarchar(50),
    @email nvarchar(50),
    @phone nvarchar(50),
    @address nvarchar(80),
    @city nvarchar(45),
    @country nvarchar(45),
    @postalCode int,
    @password nvarchar(MAX),
	@role nvarchar(200)
AS
BEGIN
    -- Check if the user already exists
    IF EXISTS (SELECT email FROM hr.[human-resources]..Employee WHERE email = @email)
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(200) = 'User already exists';
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

	-- Declare variables for stored procedure use
    DECLARE @idAddress int;
    DECLARE @idContact int;
    DECLARE @idCity int;
    DECLARE @idAddressType int;
    DECLARE @idContactType int;
	DECLARE @idRole int;
	DECLARE @idEmployee int;
	DECLARE @idGeoposition int;
	DECLARE @spQuery NVARCHAR(MAX);
	DECLARE @idPayHourPerEmployee INT;


    -- Get id for the AddressType and ContactType
    SELECT @idAddressType = idAddressType FROM hr.[human-resources]..AddressType WHERE name = 'Personal';
    SELECT @idContactType = idContactType FROM hr.[human-resources]..ContactType WHERE name = 'Personal';


    -- Get id for City
    SELECT @idCity = idCity FROM hr.[human-resources]..City WHERE name = @city;
	SELECT @idRole = idRole FROM hr.[human-resources]..Role WHERE name = @role;
	
	-- Get the last id inserted into Clients
	SELECT TOP 1 @idEmployee = idEmployee FROM hr.[human-resources]..Employee ORDER BY idEmployee DESC;

	-- First 2 numbers should be replaced with something logical, not random numbers, third number should be idClient
	-- Insert into LocationXClient
	SET @idEmployee += 1;

	SET @idGeoposition = 1

    -- Insert new Address into Address table
	-- Constructing the SQL query
	SET @spQuery = N'CALL InsertNewAddress(' + 
             dbo.ConcatString(@address) + ', ' +  -- Address with single quotes escaped
             dbo.ConcatInteger(@postalCode) + ', ' +  -- Postal Code
             dbo.ConcatInteger(@idAddressType) + ', ' +  -- Address Type ID
             dbo.ConcatInteger(@idCity) + ', ' +  -- City ID
             dbo.ConcatInteger(@idGeoposition) + ')';  -- Geoposition ID


-- Executing the query on the linked server
	BEGIN TRY
		EXEC (@spQuery) AT [hr];
	END TRY
	BEGIN CATCH
		PRINT 'Error occurred during execution: ' + @spQuery;
		THROW;  -- Re-throw the caught exception
	END CATCH 

    -- Get newly inserted Address id
    SELECT TOP 1 @idAddress = idAddress FROM hr.[human-resources]..Address ORDER BY idAddress DESC;
	
    -- Insert new Contact into Contact table
	SET @spQuery = N'CALL InsertNewContactInfo(' +
				dbo.ConcatString(@phone) + ', ' +
				dbo.ConcatString(@email) + ', ' +
				dbo.ConcatInteger(@idContactType) + ')';


	BEGIN TRY
		EXEC (@spQuery) AT [hr];
	END TRY
	BEGIN CATCH
		PRINT 'Error occurred during execution: ' + @spQuery;
		THROW;  -- Re-throw the caught exception
	END CATCH 

    -- Get newly inserted Contact id
    SELECT TOP 1 @idContact = idContactInfo FROM hr.[human-resources]..ContactInfo ORDER BY idContactInfo DESC;
	
	SET @idPayHourPerEmployee = 1;
	
	SELECT @name, @lastName, @username, @idRole, @idContact, @idPayHourPerEmployee, @idAddress, @password, @email;

	SET	@spQuery = N'CALL registerEmployee(' +
				dbo.ConcatString(@name) + ', ' +
				dbo.ConcatString(@lastName) + ', ' +
				dbo.ConcatString(@username) + ', ' +
				dbo.ConcatInteger(@idRole) + ', ' +
				dbo.ConcatInteger(@idContact) + ', ' +
				dbo.ConcatInteger(@idPayHourPerEmployee) + ', ' +
				dbo.ConcatInteger(1) + ', ' +
				dbo.ConcatInteger(@idAddress) + ', ' +
				dbo.ConcatString(@password) + ', ' +
				dbo.ConcatString(@email) + ')';

    -- Insert new Client into Client table
	BEGIN TRY
		EXEC (@spQuery) AT [hr];
	END TRY
	BEGIN CATCH
		PRINT 'Error occurred during execution: ';
		THROW;  -- Re-throw the caught exception
	END CATCH 

END;



CREATE OR ALTER PROCEDURE GetAllInventoryProducts
AS
BEGIN
    -- Seleccionar columnas específicas de la primera tabla
    SELECT 
        P.[name],
        P.[description],
		B.[name] AS NombreMarca,
		P.[idLocation],
        P.[quantity],
        P.[price],
		'NA-Inventory' AS bodega
    FROM [na-inventory].[inventory].[dbo].[products] P
	INNER JOIN [na-inventory].[inventory].[dbo].[Brands] B ON P.[idBrand] = B.[idBrand]



    -- Agregar los resultados de la segunda tabla
    UNION ALL

    SELECT 
        P.[name],
        P.[description],
		B.[name] AS NombreMarca,
		P.[idLocation],
        P.[quantity],
        P.[price],
		'SA-Inventory' AS bodega
    FROM [sa-inventory].[inventory].[dbo].[products] P 
	INNER JOIN [sa-inventory].[inventory].[dbo].[Brands] B ON P.[idBrand] = B.[idBrand]


    -- Agregar los resultados de la tercera tabla
    UNION ALL

    SELECT 
        P.[name],
        P.[description],
		B.[name] AS NombreMarca,
		P.[idLocation],
        P.[quantity],
        P.[price],
		'caribbean-Inventory' AS bodega

    FROM [caribbean-inventory].[inventory].[dbo].[products] P
	INNER JOIN [caribbean-inventory].[inventory].[dbo].[Brands] B ON P.[idBrand] = B.[idBrand]
END

-- EXEC GetAllInventoryProducts