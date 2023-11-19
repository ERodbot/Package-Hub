USE `human-resources`
-- Llenado de datos dummy para la tabla `Departments`

INSERT INTO Departments (`idDepartments`, `name`, `description`, `enabled`) VALUES
(1, 'Recursos Humanos', 'Gestión de personal y recursos humanos', 1),
(2, 'Ventas', 'Equipo de ventas y marketing', 1),
(3, 'Servicio al Cliente', 'Atención al cliente y soporte técnico', 1),
(4, 'Inventario', 'Gestión de inventario y logística', 1);



-- Inserts adicionales para la tabla `Role`
INSERT INTO Role (`idRole`, `name`, `description`, `idDepartments`, `enabled`) VALUES
(1, 'Gerente', 'Supervisión general del departamento', 1, 1),
(2, 'Representante de Ventas', 'Ventas y atención al cliente', 2, 1),
(3, 'Soporte Técnico', 'Asistencia técnica y resolución de problemas', 3, 1),
(4, 'Almacenero', 'Gestión de inventario y control de almacén', 4, 1),
(5, 'Supervisor de Ventas', 'Supervisión del equipo de ventas', 2, 1),
(6, 'Asistente de Soporte', 'Asistencia básica en soporte técnico', 3, 1),
(7, 'Encargado de Almacén', 'Gestión de inventario y logística', 4, 1);

-- Llenado de datos dummy para la tabla `ContactType`
INSERT INTO ContactType (`idContactType`, `name`) VALUES
(1, 'Teléfono'),
(2, 'Correo Electrónico');

-- Llenado de datos dummy para la tabla ContactInfo
INSERT INTO ContactInfo (idContactInfo, phone, email, idContactType, enabled) VALUES
(1, '123456789', 'usuario1@empresa.com', 1, 1),
(2, '987654321', 'usuario2@empresa.com', 2, 1),
(3, '555123456', 'usuario3@empresa.com', 1, 1),
(4, 'user4@empresa.com', 'usuario4@empresa.com', 2, 1);

-- Llenado de datos dummy para la tabla PayHourPerEmployee
INSERT INTO PayHourPerEmployee (idPayHourPerEmployee, amount, createdAt, updatedAt, checksum) VALUES
(1, 18.50, NOW(), NOW(), 'checksum1'),
(2, 22.00, NOW(), NOW(), 'checksum2'),
(3, 20.00, NOW(), NOW(), 'checksum3'),
(4, 25.00, NOW(), NOW(), 'checksum4');

-- Llenado de datos dummy para la tabla AddressType
INSERT INTO AddressType (idAddressType, name) VALUES
(1, 'Domicilio Principal'),
(2, 'Domicilio Secundario'),
(3, 'Sucursal'),
(4, 'Oficina Remota');

-- Llenado de datos dummy para la tabla Currency
INSERT INTO Currency (idCurrency, name, symbol) VALUES
(1, 'Dólar Estadounidense', '$'),
(2, 'Euro', '€'),
(3, 'Libra Esterlina', '£'),
(4, 'Yen Japonés', '¥');

-- Llenado de datos dummy para la tabla Country
INSERT INTO Country (idCountry, name, idCurrency) VALUES
(1, 'Estados Unidos', 1),
(2, 'España', 2),
(3, 'Reino Unido', 3),
(4, 'Japón', 4);

-- Llenado de datos dummy para la tabla State
INSERT INTO State (idState, name, idCountry) VALUES
(1, 'California', 1),
(2, 'Madrid', 2),
(3, 'Londres', 3),
(4, 'Tokio', 4);

-- Llenado de datos dummy para la tabla City
INSERT INTO City (idCity, name, idState) VALUES
(1, 'Los Angeles', 1),
(2, 'Madrid', 2),
(3, 'Manchester', 3),
(4, 'Osaka', 4);

-- Llenado de datos dummy para la tabla Address
INSERT INTO Address (idAddress, street, postalCode, idAddressType, idCity, enabled, idGeoposition) VALUES
(1, '123 Calle Principal', 90001, 1, 1, 1, 1),
(2, '456 Calle Secundaria', 28001, 2, 2, 1, 2),
(3, '789 Calle Sucursal', 28001, 3, 3, 1, 1),
(4, '012 Calle Remota', 100-0001, 4, 4, 1, 2);


-- Llenado de datos dummy para la tabla Employee
INSERT INTO Employee (idEmployee, name, lastName, username, password, idRole, idContactInfo, idPayHourPerEmployee, enabled, idAddress, email) VALUES
(1, 'John', 'Doe', 'john.doe', 'contraseña1', 1, 1, 1, 1, 1, 'emailexample1.com'),
(2, 'Maria', 'García', 'maria.garcia', 'contraseña2', 2, 2, 2, 1, 2, 'emailexample2.com'),
(3, 'Michael', 'Smith', 'michael.smith', 'contraseña3', 5, 3, 3, 1, 3, 'emailexample3.com'),
(4, 'Sakura', 'Tanaka', 'sakura.tanaka', 'contraseña4', 6, 4, 4, 1, 4,'emailexample4.com');

-- Llenado de datos dummy para la tabla Payroll
INSERT INTO Payroll (idPayroll, hours, date, idEmployee) VALUES
(1, 40, '2023-11-13', 1),
(2, 35, '2023-11-13', 2),
(3, 45, '2023-11-14', 3),
(4, 30, '2023-11-14', 4);

-- Llenado de datos dummy para la tabla Reduction
INSERT INTO Reduction (idReduction, name, description) VALUES
(1, 'Descuento por Seguro Médico', 'Descuento mensual por seguro médico'),
(2, 'Bono de Productividad', 'Bono mensual por alto rendimiento'),
(3, 'Descuento por Gimnasio', 'Descuento mensual por membresía de gimnasio'),
(4, 'Bono de Innovación', 'Bono trimestral por ideas innovadoras');

-- Llenado de datos dummy para la tabla ReductionbyCountry
INSERT INTO ReductionbyCountry (idReductionbyCountry, percentage, idReduction, idCountry) VALUES
(1, 2.5, 1, 1),
(2, 5.0, 2, 2),
(3, 3.0, 3, 3),
(4, 7.5, 4, 4);

-- Llenado de datos dummy para la tabla PayByEmployee
INSERT INTO PayByEmployee (payid, startDate, endDate, grossSalary, netSalary, idEmployee, createdAt, checksum) VALUES
(1, '2023-11-01', '2023-11-30', 800.00, 780.00, 1, NOW(), 'checksum3'),
(2, '2023-11-01', '2023-11-30', 1000.00, 950.00, 2, NOW(), 'checksum4'),
(3, '2023-11-01', '2023-11-30', 900.00, 870.00, 3, NOW(), 'checksum5'),
(4, '2023-11-01', '2023-11-30', 1200.00, 1110.00, 4, NOW(), 'checksum6');

-- Llenado de datos dummy para la tabla PerformanceMetrics
INSERT INTO PerformanceMetrics (idPerformanceMetrics, name, description) VALUES
(1, 'Ventas Mensuales', 'Número total de ventas realizadas mensualmente'),
(2, 'Tiempo de Respuesta', 'Tiempo promedio de respuesta al cliente'),
(3, 'Eficiencia del Equipo', 'Índice de eficiencia del equipo de ventas'),
(4, 'Calidad del Soporte', 'Calificación de calidad en el soporte técnico');

-- Llenado de datos dummy para la tabla PerfomanceByEmployee
INSERT INTO PerfomanceByEmployee (idPerfomanceByEmployee, startDate, endDate, rating, idEmpleado, idPerformanceMetrics) VALUES
(1, '2023-11-01', '2023-11-30', 4.8, 1, 1),
(2, '2023-11-01', '2023-11-30', 4.5, 2, 2),
(3, '2023-11-01', '2023-11-30', 4.2, 3, 3),
(4, '2023-11-01', '2023-11-30', 4.7, 4, 4);

-- Llenado de datos dummy para la tabla Training
INSERT INTO Training (idTraining, startDate, endDate, trainer, trainee, observations) VALUES
(1, '2023-12-01', '2023-12-05', 1, 2, 'Entrenamiento en ventas y atención al cliente'),
(2, '2023-12-10', '2023-12-15', 2, 1, 'Entrenamiento en soporte técnico y resolución de problemas'),
(3, '2023-12-20', '2023-12-25', 1, 4, 'Entrenamiento avanzado en ventas'),
(4, '2023-12-05', '2023-12-10', 2, 3, 'Entrenamiento en resolución de problemas avanzada');

-- Llenado de datos dummy para la tabla PaymentLog
INSERT INTO PaymentLog (idPaymentLog, posttime, description, checksum, paymentid) VALUES
(1, NOW(), 'Pago de salario a John Doe', 'checksum5', 1),
(2, NOW(), 'Pago de salario a Maria García', 'checksum6', 2),
(3, NOW(), 'Pago de salario a Michael Smith', 'checksum7', 3),
(4, NOW(), 'Pago de salario a Sakura Tanaka', 'checksum8', 4);



