-- Insert dummy data for 'customer-service' schema
SELECT * FROM "customer-service"."CallType" 
-- CallType
INSERT INTO "customer-service"."CallType" (name, description) VALUES
('Inquiry', 'General Inquiry'),
('Complaint', 'Customer Complaint'),
('Support', 'Technical Support');


-- StateType
INSERT INTO "customer-service"."StateType" (name, description) VALUES
('Open', 'Open Ticket'),
('Closed', 'Closed Ticket'),
('Pending', 'Pending');


-- OperationType
INSERT INTO "customer-service"."OperationType" (name, description) VALUES
('Create', 'Create Ticket'),
('Update', 'Update Ticket'),
('Delete', 'Delete Ticket');


-- TicketType
INSERT INTO "customer-service"."TicketType" (name, description) VALUES
('Query', 'Query Ticket'),
('Problem', 'Problem Ticket'),
('Request', 'Request Ticket');

-- Ticket Data
INSERT INTO "customer-service"."Tickets" (description, "createdAt", "updatedAt", "idTicketType", "idOrder", "idClient") VALUES
('Query about product availability', '2023-11-14', '2023-11-14', 4, 1, 1),
('Complaint about late delivery', '2023-11-15', '2023-11-15', 5, 2, 2),
('Technical support for software issue', '2023-11-16', '2023-11-16', 6, 3, 3);

SELECT * FROM "customer-service"."Tickets"
-- Employee Data
INSERT INTO "customer-service"."Calls" (date, "idEmployee", "idTicket") VALUES
('2023-11-14', 1, 7),
('2023-11-15', 2, 8),
('2023-11-16', 3, 9);

-- Responses Data
INSERT INTO "customer-service"."Responses" ("idOrder", "idEmployee", date, response, "idTicket") VALUES
(1, 1, '2023-11-14', 'Product is available in stock', 7),
(2, 2, '2023-11-15', 'Apologies for the delay, investigating', 8),
(3, 3, '2023-11-16', 'Please provide more details about the issue', 9);

SELECT * FROM "customer-service"."StateType"

-- Insert into CallDetails table
INSERT INTO "customer-service"."CallDetails"( description, "idResponse", "idCallType", "idStateType")
VALUES 
    ('General inquiry', 4, 4, 4),
    ('Technical support', 5, 4, 5),
    ('Billing issue', 5, 5, 4),
    ('Product feedback', 4, 6, 4),
    ('Appointment scheduling', 6, 6, 6);

-- Insert into CallDetails_Emergency table
INSERT INTO "customer-service"."CallDetails_Emergency"(description, "idResponse", "idCallType", "idStateType")
VALUES 
	('Medical emergency', 201, 1, 1),
    ('Fire emergency', 202, 2, 1),
    ('Natural disaster', 203, 3, 1),
    ('Security threat', 204, 1, 2),
    ('Urgent assistance needed', 205, 2, 3);


-- Insert into CallDetails_Inquiries table
INSERT INTO "customer-service"."CallDetails_Inquiries"(description, "idResponse", "idCallType", "idStateType")
VALUES 
    ('Product inquiry', 301, 3, 2),
    ('Service inquiry', 302, 2, 3),
    ('Policy information', 303, 1, 1),
    ('Membership details', 304, 3, 2),
    ('Shipping status', 305, 2, 1);
