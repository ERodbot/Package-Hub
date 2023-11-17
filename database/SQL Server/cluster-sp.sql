

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