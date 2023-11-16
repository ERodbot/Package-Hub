-- Procedure to insert a new address
DELIMITER // CREATE PROCEDURE InsertNewAddress(
    IN address VARCHAR(80),
    IN postalCode INT,
    IN idAddressType INT,
    IN idCity INT,
    IN idGeoposition INT
) BEGIN
INSERT INTO `Address` (
        `street`,
        `postalCode`,
        `idAddressType`,
        `idCity`,
        `enabled`,
        `idGeoposition`
    )
VALUES (
        address,
        postalCode,
        idAddressType,
        idCity,
        1,
        idGeoposition
    );
END // DELIMITER;
-- Procedure to insert into ContactInfo table, receives phone, email and idContactType like parameters
DELIMITER // CREATE PROCEDURE InsertNewContactInfo(
    IN phone VARCHAR(45),
    IN email VARCHAR(80),
    IN idContactType INT
) BEGIN
INSERT INTO `ContactInfo` (`phone`, `email`, `idContactType`, `enabled`)
VALUES (phone, email, idContactType, 1);
END // DELIMITER;
DELIMITER // CREATRE PROCEDURE getCountries() CREATE
OR ALTER PROCEDURE usp_ReportingByPerformance @initial_date DATE = NULL,
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
GO -- EXEC usp_ReportingByPerformance;
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
    CREATE
    OR ALTER PROCEDURE usp_ReportingSalaryStructure @initial_date DATE = NULL,
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
GO -- EXEC usp_ReportingSalaryStructure; 
    -- EXEC usp_ReportingSalaryStructure
    --    @initial_date = '2023-11-01',
    --    @final_date = '2023-11-30'; 
    -- EXEC usp_ReportingSalaryStructure
    --    @initial_date = '2023-11-30',
    --    @final_date = '2023-11-01';