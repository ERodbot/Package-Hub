-- Procedure to insert a new address

DELIMITER //

CREATE PROCEDURE InsertNewAddress(
    IN address VARCHAR(80),
    IN postalCode INT,
    IN idAddressType INT,
    IN idCity INT,
    IN idGeoposition INT
)
BEGIN
    INSERT INTO `Address` (`street`, `postalCode`, `idAddressType`, `idCity`, `enabled`, `idGeoposition`)
    VALUES (address, postalCode, idAddressType, idCity, 1, idGeoposition);
END //

DELIMITER ;

-- Procedure to insert into ContactInfo table, receives phone, email and idContactType like parameters

DELIMITER //

CREATE PROCEDURE InsertNewContactInfo(
    IN phone VARCHAR(45),
    IN email VARCHAR(80),
    IN idContactType INT
)
BEGIN
    INSERT INTO `ContactInfo` (`phone`, `email`, `idContactType`, `enabled`)
    VALUES (phone, email, idContactType, 1);
END //

DELIMITER ;