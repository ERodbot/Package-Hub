-- Insert dummy data for 'customer-service' schema



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
('Query about product availability', '2023-11-14', '2023-11-14', 1, 1, 1),
('Complaint about late delivery', '2023-11-15', '2023-11-15', 2, 2, 2),
('Technical support for software issue', '2023-11-16', '2023-11-16', 3, 3, 3);

-- Employee Data
INSERT INTO "customer-service"."Calls" (date, "idEmployee", "idCallType", "idStateType", "idTicket") VALUES
('2023-11-14', 1, 1, 1, 1),
('2023-11-15', 2, 2, 2, 2),
('2023-11-16', 3, 3, 1, 3);

-- Responses Data
INSERT INTO "customer-service"."Responses" ("idOrder", "idEmployee", date, response, "idTicket") VALUES
(1, 1, '2023-11-14', 'Product is available in stock', 1),
(2, 2, '2023-11-15', 'Apologies for the delay, investigating', 2),
(3, 3, '2023-11-16', 'Please provide more details about the issue', 3);


-- End transaction
COMMIT;
