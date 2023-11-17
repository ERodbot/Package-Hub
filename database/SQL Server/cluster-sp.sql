

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

