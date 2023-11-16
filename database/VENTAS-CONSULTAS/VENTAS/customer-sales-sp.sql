# Create a Stored Procedure in PostgreSQL to insert into Clients with the following parameters
# email, username, name, lastName, idAddress, idContact, password

CREATE OR REPLACE PROCEDURE registerClient(
    email VARCHAR,
    username VARCHAR,
    name VARCHAR,
    lastName VARCHAR,
    idAddress INT,
    idContact INT,
    password VARCHAR
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO "Clients" ("email", "username", "name", "lastName", "idAddress", "idContact", "password", "enabled")
    VALUES (email, username, name, lastName, idAddress, idContact, password, 1);
END;
$$;

