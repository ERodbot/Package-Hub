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
) BEGIN

INSERT INTO `ContactInfo` (`phone`, `email`, `idContactType`, `enabled`)
VALUES (phone, email, idContactType, 1);
END //
 DELIMITER;

DELIMITER // 

DELIMITER $$

CREATE PROCEDURE registerEmployee(
	IN name VARCHAR(45),
    IN lastName VARCHAR(45),
    IN username VARCHAR(45),
    IN idRole INT,
    IN idContactInfo INT,
    IN idPayHourPerEmployee INT,
    IN enabled INT,
    IN idAddress INT,
    IN password VARCHAR(200),
    IN email VARCHAR(80)
)
BEGIN
    INSERT INTO Employee (name, lastName, username, idRole, idContactInfo, idPayHourPerEmployee, enabled, idAddress, password, email)
	VALUES (name, lastName, username, idRole, idContactInfo, idPayHourPerEmployee, enabled, idAddress, password, email);
END $$

