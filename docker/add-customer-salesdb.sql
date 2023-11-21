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


CREATE TABLE IF NOT EXISTS "customer-service"."CallType"
(
    "idCallType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "CallType_pkey" PRIMARY KEY ("idCallType")
);

CREATE TABLE IF NOT EXISTS "customer-service"."Calls"
(
    "idCall" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    date date NOT NULL,
    "idEmployee" integer NOT NULL,
    "idCallType" integer NOT NULL,
    "idStateType" integer NOT NULL,
    "idTicket" integer NOT NULL,
    CONSTRAINT "Calls_pkey" PRIMARY KEY ("idCall")
);

CREATE TABLE IF NOT EXISTS "customer-service"."OperationType"
(
    "idOperationType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "OperationType_pkey" PRIMARY KEY ("idOperationType")
);

CREATE TABLE IF NOT EXISTS "customer-service"."Responses"
(
    "idResponse" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "idOrder" integer NOT NULL,
    "idEmployee" integer NOT NULL,
    date date NOT NULL,
    response text COLLATE pg_catalog."default" NOT NULL,
    "idTicket" integer NOT NULL,
    CONSTRAINT "Responses_pkey" PRIMARY KEY ("idResponse")
);

CREATE TABLE IF NOT EXISTS "customer-service"."StateType"
(
    "idStateType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "StateType_pkey" PRIMARY KEY ("idStateType")
);

CREATE TABLE IF NOT EXISTS "customer-service"."TicketLog"
(
    "idTicketLog" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "idTicket" integer NOT NULL,
    posttime timestamp with time zone NOT NULL,
    "idOperationType" integer NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    checksum text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "TicketLog_pkey" PRIMARY KEY ("idTicketLog")
);

CREATE TABLE IF NOT EXISTS "customer-service"."TicketType"
(
    "idTicketType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "TicketType_pkey" PRIMARY KEY ("idTicketType")
);

CREATE TABLE IF NOT EXISTS "customer-service"."Tickets"
(
    "idTicket" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    description text COLLATE pg_catalog."default" NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "idTicketType" integer NOT NULL,
    "idOrder" integer NOT NULL,
    "idClient" integer NOT NULL,
    CONSTRAINT "Tickets_pkey" PRIMARY KEY ("idTicket")
);

CREATE TABLE IF NOT EXISTS sales."BranchOffice"
(
    "idBranchOffice" integer NOT NULL,
    "idCountry" integer NOT NULL,
    "branchName" text COLLATE pg_catalog."default" NOT NULL,
    "locationBranch" text NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    opens text COLLATE pg_catalog."default" NOT NULL,
    closes text COLLATE pg_catalog."default" NOT NULL,
    "idCurrency" integer NOT NULL,
    "idManager" integer NOT NULL,
    CONSTRAINT "BranchOffice_pkey" PRIMARY KEY ("idBranchOffice")
);

CREATE TABLE IF NOT EXISTS sales."CardType"
(
    "idCardType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "CardType_pkey" PRIMARY KEY ("idCardType")
);

CREATE TABLE IF NOT EXISTS sales."Cards"
(
    "idCard" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "number" integer NOT NULL,
    expiration text COLLATE pg_catalog."default" NOT NULL,
    cvv integer NOT NULL,
    "idCardType" integer NOT NULL,
    "idClient" integer NOT NULL,
    enabled integer NOT NULL DEFAULT 1,
    CONSTRAINT "Cards_pkey" PRIMARY KEY ("idCard")
);

CREATE TABLE IF NOT EXISTS sales."Clients"
(
    "idClient" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    email text COLLATE pg_catalog."default" NOT NULL,
    username text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    "lastName" text COLLATE pg_catalog."default" NOT NULL,
    "idAddress" integer NOT NULL,
    "idContact" integer NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    enabled integer NOT NULL DEFAULT 1,
    CONSTRAINT "Clients_pkey" PRIMARY KEY ("idClient")
);

CREATE TABLE IF NOT EXISTS sales."OperationType"
(
    "idOperationType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "OperationType_pkey" PRIMARY KEY ("idOperationType")
);

CREATE TABLE IF NOT EXISTS sales."OrderDetails"
(
    "idOrderDetails" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "idOrder" integer NOT NULL,
    "idProduct" integer NOT NULL,
    quantity integer NOT NULL,
    "priceUnit" money NOT NULL,
    discount money NOT NULL,
    "lineTotal" money NOT NULL,
    date date NOT NULL,
    CONSTRAINT "OrderDetails_pkey" PRIMARY KEY ("idOrderDetails")
);

CREATE TABLE IF NOT EXISTS sales."OrderStatus"
(
    "idOrderStatus" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "OrderStatus_pkey" PRIMARY KEY ("idOrderStatus")
);

CREATE TABLE IF NOT EXISTS sales."Orders"
(
    "idOrder" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "idClient" integer NOT NULL,
    date date NOT NULL,
    total money NOT NULL,
    status integer NOT NULL,
    "idEmployee" integer NOT NULL,
    "idOrderStatus" integer NOT NULL,
    "idShipping" integer NOT NULL,
    enabled integer NOT NULL DEFAULT 1,
    "invoiceNumber" text COLLATE pg_catalog."default" NOT NULL,
    "idPayStatus" integer NOT NULL,
    "idPayType" integer NOT NULL,
    CONSTRAINT "Orders_pkey" PRIMARY KEY ("idOrder")
);

CREATE TABLE IF NOT EXISTS sales."PayStatus"
(
    "idPayStatus" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PayStatus_pkey" PRIMARY KEY ("idPayStatus")
);

CREATE TABLE IF NOT EXISTS sales."PayType"
(
    "idPayType" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PayType_pkey" PRIMARY KEY ("idPayType")
);

CREATE TABLE IF NOT EXISTS sales."Shipping"
(
    "idShipping" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    costxkm money NOT NULL,
    kilometers numeric(10, 2) NOT NULL,
    total money NOT NULL,
    CONSTRAINT "Shipping_pkey" PRIMARY KEY ("idShipping")
);

CREATE TABLE IF NOT EXISTS sales."TransactionLog"
(
    "idTransactionLog" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "idClient" integer NOT NULL,
    "idOrder" integer NOT NULL,
    posttime timestamp with time zone NOT NULL,
    "idOperationType" integer NOT NULL,
    amount integer NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    checksum text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "TransactionLog_pkey" PRIMARY KEY ("idTransactionLog")
);

ALTER TABLE IF EXISTS "customer-service"."Calls"
    ADD CONSTRAINT "Calls_idCallType_fkey" FOREIGN KEY ("idCallType")
    REFERENCES "customer-service"."CallType" ("idCallType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Calls"
    ADD CONSTRAINT "Calls_idStateType_fkey" FOREIGN KEY ("idStateType")
    REFERENCES "customer-service"."StateType" ("idStateType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Calls"
    ADD CONSTRAINT "Calls_idTicket_fkey" FOREIGN KEY ("idTicket")
    REFERENCES "customer-service"."Tickets" ("idTicket") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Responses"
    ADD CONSTRAINT "Responses_idTicket_fkey" FOREIGN KEY ("idTicket")
    REFERENCES "customer-service"."Tickets" ("idTicket") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."TicketLog"
    ADD CONSTRAINT "TicketLog_idOperationType_fkey" FOREIGN KEY ("idOperationType")
    REFERENCES "customer-service"."OperationType" ("idOperationType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."TicketLog"
    ADD CONSTRAINT "TicketLog_idTicket_fkey" FOREIGN KEY ("idTicket")
    REFERENCES "customer-service"."Tickets" ("idTicket") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "customer-service"."Tickets"
    ADD CONSTRAINT "Tickets_idTicketType_fkey" FOREIGN KEY ("idTicketType")
    REFERENCES "customer-service"."TicketType" ("idTicketType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Cards"
    ADD CONSTRAINT "Cards_idCardType_fkey" FOREIGN KEY ("idCardType")
    REFERENCES sales."CardType" ("idCardType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Cards"
    ADD CONSTRAINT "Cards_idClient_fkey" FOREIGN KEY ("idClient")
    REFERENCES sales."Clients" ("idClient") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."OrderDetails"
    ADD CONSTRAINT "OrderDetails_idOrder_fkey" FOREIGN KEY ("idOrder")
    REFERENCES sales."Orders" ("idOrder") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD CONSTRAINT "Orders_idOrderStatus_fkey" FOREIGN KEY ("idOrderStatus")
    REFERENCES sales."OrderStatus" ("idOrderStatus") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD CONSTRAINT "Orders_idPayStatus_fkey" FOREIGN KEY ("idPayStatus")
    REFERENCES sales."PayStatus" ("idPayStatus") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD CONSTRAINT "Orders_idPayType_fkey" FOREIGN KEY ("idPayType")
    REFERENCES sales."PayType" ("idPayType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."Orders"
    ADD CONSTRAINT "Orders_idShipping_fkey" FOREIGN KEY ("idShipping")
    REFERENCES sales."Shipping" ("idShipping") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."TransactionLog"
    ADD CONSTRAINT "TransactionLog_idClient_fkey" FOREIGN KEY ("idClient")
    REFERENCES sales."Clients" ("idClient") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."TransactionLog"
    ADD CONSTRAINT "TransactionLog_idOperationType_fkey" FOREIGN KEY ("idOperationType")
    REFERENCES sales."OperationType" ("idOperationType") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS sales."TransactionLog"
    ADD CONSTRAINT "TransactionLog_idOrder_fkey" FOREIGN KEY ("idOrder")
    REFERENCES sales."Orders" ("idOrder") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;