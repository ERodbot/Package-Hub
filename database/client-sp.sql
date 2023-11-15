
-- Procedure to add the location of the client, receives latitude, longitude and idClient
CREATE OR ALTER PROCEDURE addPositionClient
    @latitude FLOAT,
    @longitude FLOAT,
    @idClient INT
AS
BEGIN
    
    -- Declare geoposition variable to create geography
    DECLARE @geoposition GEOGRAPHY = GEOGRAPHY::Point(@latitude, @longitude, 4326);

    -- Insert into LocationXClinet
    INSERT INTO LocationXClient (geoposition, idClient)
    VALUES (@geoposition, @idClient);

END;

-- Procedure to get the last geoposition inserted into LocationXClient
CREATE OR ALTER PROCEDURE getGeopositionClient
AS
BEGIN
    SELECT TOP 1 idLocationXClient FROM LocationXClient ORDER BY idLocationXClient DESC;
END;

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
    INSERT INTO hr.[human-resources]..Address (street, postalCode, idAddressType, idCity, enabled, idGeoposition)
    VALUES (@address, @postalCode, @idAddressType, @idCity, 1, @idGeoposition);

    -- Get newly inserted Address id
    SELECT @idAddress = idAddress FROM hr.[human-resources]..Address WHERE street = @address AND postalCode = @postalCode;
	
    -- Insert new Contact into Contact table
    INSERT INTO hr.[human-resources]..ContactInfo (phone, email, idContactType, enabled)
    VALUES (@phone, @email, @idContactType, 1);

    -- Get newly inserted Contact id
    SELECT @idContact = idContactInfo FROM hr.[human-resources]..ContactInfo WHERE phone = @phone AND email = @email;

    -- Insert new Client into Client table
    INSERT INTO [support-sales].[support-sales].[sales].Clients (email, username, name, lastName, idAddress, idContact, password)
    VALUES (@email, @username, @name, @lastName, @idAddress, @idContact, @password);
END;