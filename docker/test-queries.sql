-- Example queries for SQL Server linked servers
SELECT * FROM [na-inventory].master.sys.servers;
-- Format is: [linked-server-name].[database].[schema].[table]
SELECT * FROM [sa-inventory].master.sys.servers;
SELECT * FROM [caribbean-inventory].master.sys.servers;


-- Example query for MySQL linked server
SELECT * FROM hr.humanr..test;
-- Format is: [linked-server-name].[database].[schema].[table]
-- Since there is no schema, just type another period after database


-- Example query for Postgres linked server
SELECT * FROM [support-sales].salessup.[public].test;
-- Format is: [linked-server-name].[database].[schema].[table]
-- Public should be in [] since it is a reserved word in SQL Server
-- linked-server-name should also be in [] because of the name including a "-".
