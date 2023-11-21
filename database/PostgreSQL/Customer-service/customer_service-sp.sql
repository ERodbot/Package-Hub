


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
