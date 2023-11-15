INSERT INTO ContactType (name) VALUES ("Personal");

INSERT INTO AddressType (name) VALUES ("Personal");

INSERT INTO Currency (name, symbol) VALUES ("Costa Rican Colon", "₡");

INSERT INTO Country (name, idCurrency) VALUES ("Costa Rica", 1);

INSERT INTO State (name, idCountry) VALUES ("San Jose", 1);

INSERT INTO City (name, idState) VALUES ("Desamparados", 1);