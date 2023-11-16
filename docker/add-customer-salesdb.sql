-- -- DROP DATABASE IF EXISTS "customer-sales";
-- DROP DATABASE IF EXISTS "customer-sales";

-- -- Create the database
-- CREATE DATABASE "customer-sales"
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     LC_COLLATE = 'en_US.utf8'
--     LC_CTYPE = 'en_US.utf8'
--     TABLESPACE = pg_default
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

-- -- Connect to the newly created database
-- -- \c "customer-sales"

-- Create schemas
CREATE SCHEMA IF NOT EXISTS "sales";
CREATE SCHEMA IF NOT EXISTS "customer-service";

-- Start transaction
BEGIN;

-- Creation of tables and constraints for 'customer-service' schema

-- DROP and CREATE TABLE statements for 'customer-service' schema
DROP TABLE IF EXISTS "customer-service"."Calls";

CREATE TABLE IF NOT EXISTS "customer-service"."Calls"
(
    "idCall" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    date date NOT NULL,
    "idEmployee" integer NOT NULL,
    "idCallType" integer NOT NULL,
    "idStateType" integer NOT NULL,
    "idTicket" integer NOT NULL,
    PRIMARY KEY ("idCall")
);

DROP TABLE IF EXISTS "customer-service"."CallType";

CREATE TABLE IF NOT EXISTS "customer-service"."CallType"
(
    "idCallType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text NOT NULL,
    PRIMARY KEY ("idCallType")
);

DROP TABLE IF EXISTS "customer-service"."TicketLog";

CREATE TABLE IF NOT EXISTS "customer-service"."TicketLog"
(
    "idTicketLog" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "idTicket" integer NOT NULL,
    posttime timestamp with time zone NOT NULL,
    "idOperationType" integer NOT NULL,
    description text NOT NULL,
    checksum text NOT NULL,
    PRIMARY KEY ("idTicketLog")
);

DROP TABLE IF EXISTS "customer-service"."Tickets";

CREATE TABLE IF NOT EXISTS "customer-service"."Tickets"
(
    "idTicket" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    description text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "idTicketType" integer NOT NULL,
    "idOrder" integer NOT NULL,
    "idClient" integer NOT NULL,
    PRIMARY KEY ("idTicket")
);

DROP TABLE IF EXISTS "customer-service"."TicketType";

CREATE TABLE IF NOT EXISTS "customer-service"."TicketType"
(
    "idTicketType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text NOT NULL,
    PRIMARY KEY ("idTicketType")
);

DROP TABLE IF EXISTS "customer-service"."StateType";

CREATE TABLE IF NOT EXISTS "customer-service"."StateType"
(
    "idStateType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text NOT NULL,
    PRIMARY KEY ("idStateType")
);

DROP TABLE IF EXISTS "customer-service"."OperationType";

CREATE TABLE IF NOT EXISTS "customer-service"."OperationType"
(
    "idOperationType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text NOT NULL,
    PRIMARY KEY ("idOperationType")
);

DROP TABLE IF EXISTS "customer-service"."Responses";

CREATE TABLE IF NOT EXISTS "customer-service"."Responses"
(
    "idResponse" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "idOrder" integer NOT NULL,
    "idEmployee" integer NOT NULL,
    date date NOT NULL,
    response text NOT NULL,
    "idTicket" integer NOT NULL,
    PRIMARY KEY ("idResponse")
);

ALTER TABLE IF EXISTS "customer-service"."Calls"
    ADD FOREIGN KEY ("idCallType")
    REFERENCES "customer-service"."CallType" ("idCallType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Calls"
    ADD FOREIGN KEY ("idStateType")
    REFERENCES "customer-service"."StateType" ("idStateType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Calls"
    ADD FOREIGN KEY ("idTicket")
    REFERENCES "customer-service"."Tickets" ("idTicket") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."TicketLog"
    ADD FOREIGN KEY ("idTicket")
    REFERENCES "customer-service"."Tickets" ("idTicket") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."TicketLog"
    ADD FOREIGN KEY ("idOperationType")
    REFERENCES "customer-service"."OperationType" ("idOperationType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Tickets"
    ADD FOREIGN KEY ("idTicketType")
    REFERENCES "customer-service"."TicketType" ("idTicketType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Responses"
    ADD FOREIGN KEY ("idTicket")
    REFERENCES "customer-service"."Tickets" ("idTicket") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

-- End transaction
END;

-- Start transaction
BEGIN;

-- Creation of tables and constraints for 'sales' schema

-- DROP and CREATE TABLE statements for 'sales' schema

DROP TABLE IF EXISTS sales."Orders";

CREATE TABLE IF NOT EXISTS sales."Orders"
(
    "idOrder" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "idClient" integer NOT NULL,
    date date NOT NULL,
    total money NOT NULL,
    status integer NOT NULL,
    "idEmployee" integer NOT NULL,
    "idOrderStatus" integer NOT NULL,
    "idShipping" integer NOT NULL,
    enabled integer NOT NULL DEFAULT 1,
    "invoiceNumber" text NOT NULL,
    "idPayStatus" integer NOT NULL,
    "idPayType" integer NOT NULL,
    PRIMARY KEY ("idOrder")
);

DROP TABLE IF EXISTS sales."Clients";

CREATE TABLE IF NOT EXISTS sales."Clients"
(
    "idClient" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    email text NOT NULL,
    username text NOT NULL,
    name text NOT NULL,
    "lastName" text NOT NULL,
    "idAddress" integer NOT NULL,
    "idContact" integer NOT NULL,
    password text NOT NULL,
    enabled integer NOT NULL DEFAULT 1,
    PRIMARY KEY ("idClient")
);

DROP TABLE IF EXISTS sales."OrderStatus";

CREATE TABLE IF NOT EXISTS sales."OrderStatus"
(
    "idOrderStatus" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    PRIMARY KEY ("idOrderStatus")
);

DROP TABLE IF EXISTS sales."Cards";

CREATE TABLE IF NOT EXISTS sales."Cards"
(
    "idCard" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "number" integer NOT NULL,
    expiration text NOT NULL,
    cvv integer NOT NULL,
    "idCardType" integer NOT NULL,
    "idClient" integer NOT NULL,
    enabled integer NOT NULL DEFAULT 1,
    PRIMARY KEY ("idCard")
);

DROP TABLE IF EXISTS sales."TransactionLog";

CREATE TABLE IF NOT EXISTS sales."TransactionLog"
(
    "idTransactionLog" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "idClient" integer NOT NULL,
    "idOrder" integer NOT NULL,
    posttime timestamp with time zone NOT NULL,
    "idOperationType" integer NOT NULL,
    amount integer NOT NULL,
    description text NOT NULL,
    checksum text NOT NULL,
    PRIMARY KEY ("idTransactionLog")
);

DROP TABLE IF EXISTS sales."OrderDetails";

CREATE TABLE IF NOT EXISTS sales."OrderDetails"
(
    "idOrderDetails" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "idOrder" integer NOT NULL,
    "idProduct" integer NOT NULL,
    quantity integer NOT NULL,
    "priceUnit" money NOT NULL,
    discount money NOT NULL,
    "lineTotal" money NOT NULL,
    date date NOT NULL,
    PRIMARY KEY ("idOrderDetails")
);

DROP TABLE IF EXISTS sales."CardType";

CREATE TABLE IF NOT EXISTS sales."CardType"
(
    "idCardType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    PRIMARY KEY ("idCardType")
);

DROP TABLE IF EXISTS sales."PayStatus";

CREATE TABLE IF NOT EXISTS sales."PayStatus"
(
    "idPayStatus" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    PRIMARY KEY ("idPayStatus")
);

DROP TABLE IF EXISTS sales."PayType";

CREATE TABLE IF NOT EXISTS sales."PayType"
(
    "idPayType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    PRIMARY KEY ("idPayType")
);

DROP TABLE IF EXISTS sales."OperationType";

CREATE TABLE IF NOT EXISTS sales."OperationType"
(
    "idOperationType" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    PRIMARY KEY ("idOperationType")
);

DROP TABLE IF EXISTS sales."Shipping";

CREATE TABLE IF NOT EXISTS sales."Shipping"
(
    "idShipping" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    costxkm money NOT NULL,
    kilometers numeric(10, 2) NOT NULL,
    total money NOT NULL,
    PRIMARY KEY ("idShipping")
);

ALTER TABLE IF EXISTS sales."Orders"
    ADD FOREIGN KEY ("idOrderStatus")
    REFERENCES sales."OrderStatus" ("idOrderStatus") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD FOREIGN KEY ("idShipping")
    REFERENCES sales."Shipping" ("idShipping") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD FOREIGN KEY ("idPayStatus")
    REFERENCES sales."PayStatus" ("idPayStatus") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD FOREIGN KEY ("idPayType")
    REFERENCES sales."PayType" ("idPayType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Cards"
    ADD FOREIGN KEY ("idCardType")
    REFERENCES sales."CardType" ("idCardType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Cards"
    ADD FOREIGN KEY ("idClient")
    REFERENCES sales."Clients" ("idClient") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."TransactionLog"
    ADD FOREIGN KEY ("idClient")
    REFERENCES sales."Clients" ("idClient") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."TransactionLog"
    ADD FOREIGN KEY ("idOrder")
    REFERENCES sales."Orders" ("idOrder") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."TransactionLog"
    ADD FOREIGN KEY ("idOperationType")
    REFERENCES sales."OperationType" ("idOperationType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."OrderDetails"
    ADD FOREIGN KEY ("idOrder")
    REFERENCES sales."Orders" ("idOrder") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
-- End transaction
END;
