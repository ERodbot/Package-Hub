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


-- OrderStatus
INSERT INTO sales."OrderStatus" (name) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered');

-- CardType
INSERT INTO sales."CardType" (name) VALUES
('Credit Card'),
('Debit Card');

-- PayStatus
INSERT INTO sales."PayStatus" (name) VALUES
('Pending'),
('Paid'),
('Refunded');

-- PayType
INSERT INTO sales."PayType" (name) VALUES
('Credit Card'),
('Cash On Delivery');

-- OperationType
INSERT INTO sales."OperationType" (name) VALUES
('Create Order'),
('Update Order'),
('Cancel Order');

-- Shipping Data
INSERT INTO sales."Shipping" (costxkm, kilometers, total) VALUES
(0.5, 100, 50),
(0.7, 150, 75),
(0.9, 200, 90);



-- Client Data
INSERT INTO sales."Clients" (email, username, name, "lastName", "idAddress", "idContact", password, enabled) VALUES
('client1@example.com', 'client1', 'John', 'Doe', 1, 1, 'password1', 1),
('client2@example.com', 'client2', 'Jane', 'Smith', 2, 2, 'password2', 1),
('client3@example.com', 'client3', 'Bob', 'Johnson', 3, 3, 'password3', 1);

-- Order Data
INSERT INTO sales."Orders" ("idClient", date, total, status, "idEmployee", "idOrderStatus", "idShipping", enabled, "invoiceNumber", "idPayStatus", "idPayType") VALUES
(1, '2023-11-14', 100.50, 1, 1, 1, 1, 1, '123e4567-e89b-12d3-a456-426614174001', 1, 1),
(2, '2023-11-15', 150.75, 2, 2, 2, 2, 1, '987e6547-e89b-12d3-a456-426614174002', 2, 2),
(3, '2023-11-16', 200.90, 3, 3, 3, 3, 1, '654e3217-e89b-12d3-a456-426614174003', 3, 1);


-- Card Data
INSERT INTO sales."Cards" ("number", expiration, cvv, "idCardType", "idClient", enabled) VALUES
(1234567, '12/25', 123, 1, 1, 1),
(9876540, '06/23', 456, 2, 2, 1),
(6543217, '09/24', 789, 1, 3, 1);



-- TransactionLog Data
INSERT INTO sales."TransactionLog" ("idClient", "idOrder", posttime, "idOperationType", amount, description, checksum) VALUES
(1, 1, '2023-11-14', 1, 100.50, 'Order created', 'c31a01'),
(2, 2, '2023-11-15', 2, 150.75, 'Order updated', '10fg19'),
(3, 3, '2023-11-16', 3, 200.90, 'Order canceled', '4rg06a');

-- OrderDetails Data
INSERT INTO sales."OrderDetails" ("idOrder", "idProduct", quantity, "priceUnit", discount, "lineTotal", date) VALUES
(1, 1, 2, 25.25, 0.50, 49.50, '2023-11-14'),
(2, 2, 3, 30.00, 1.25, 89.25, '2023-11-15'),
(3, 3, 1, 40.00, 2.00, 38.00, '2023-11-16'),
(1, 1, 2, 25.25, 0.50, 49.50, '2023-11-14'),
(1, 2, 12, 30.00, 1.25, 89.25, '2023-11-15'),
(3, 3, 4, 40.00, 2.00, 38.00, '2023-11-16');




-- OrderDetails Data
INSERT INTO sales."OrderDetails" ("idOrder", "idProduct", quantity, "priceUnit", discount, "lineTotal", date) VALUES
(1, 1, 2, 25.25, 0.50, 49.50, '2023-11-14'),
(2, 2, 3, 30.00, 1.25, 89.25, '2023-11-15'),
(3, 3, 1, 40.00, 2.00, 38.00, '2023-11-16');

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
