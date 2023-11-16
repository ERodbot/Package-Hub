
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