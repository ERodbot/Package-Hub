


-------------------------------------------------------------------------
-- Insert Ticket
-------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE "customer-service"."InsertTicket"(
    IN p_description text,
    IN p_createdAt timestamp with time zone,
    IN p_updatedAt timestamp with time zone,
    IN p_idTicketType integer,
    IN p_idOrder integer,
    IN p_idClient integer
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    INSERT INTO "customer-service"."Tickets" (
        description,
        "createdAt",
        "updatedAt",
        "idTicketType",
        "idOrder",
        "idClient"
    ) VALUES (
        p_description,
        p_createdAt,
        p_updatedAt,
        p_idTicketType,
        p_idOrder,
        p_idClient
    );
END;
$procedure$;
-- CALL "customer-service"."InsertTicket"('Descripción del ticket', NOW(), NOW(), 1, 123, 456);


CREATE OR REPLACE FUNCTION getTicketInfo()
RETURNS TABLE (
    idTicket integer,
    description text,
    createdAt timestamp with time zone,
    updatedAt timestamp with time zone,
    idTicketType integer,
    idOrder integer,
    idClient integer,
    clientName text
)
AS $$
BEGIN
    RETURN QUERY
    SELECT Tickets."idTicket", Tickets.description, Tickets."createdAt", Tickets."updatedAt", Tickets."idTicketType", Tickets."idOrder", Tickets."idClient", Clientes.name as clientName
    FROM "customer-service"."Tickets" as Tickets
    JOIN "sales"."Clients" as Clientes ON Tickets."idClient" = Clientes."idClient";
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getTicketInfo()
RETURNS TABLE (
    idTicket integer,
    description text,
    createdAt timestamp with time zone,
    updatedAt timestamp with time zone,
    idTicketType integer,
    idOrder integer,
    clientName text -- Aquí es donde declaras clientName como una columna independiente
)
AS $$
BEGIN
    RETURN QUERY
    SELECT Tickets."idTicket", Tickets.description, Tickets."createdAt", Tickets."updatedAt", Tickets."idTicketType", Tickets."idOrder", Clientes.name as clientName
    FROM "customer-service"."Tickets" as Tickets
    JOIN "sales"."Clients" as Clientes ON Tickets."idClient" = Clientes."idClient";
END;
$$ LANGUAGE plpgsql;