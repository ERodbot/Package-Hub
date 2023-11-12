-- Add servers using SQL Server (Inventory)

EXEC sp_addlinkedserver 
   @server='na-inventory', 
   @srvproduct='', 
   @provider='SQLNCLI', 
   @datasrc='localhost,1434';

EXEC sp_addlinkedsrvlogin 
   'na-inventory', 
   'false', 
   NULL, 
   'sa', 
   '12e@5678';


EXEC sp_addlinkedserver 
   @server='sa-inventory', 
   @srvproduct='', 
   @provider='SQLNCLI', 
   @datasrc='localhost,1435';

EXEC sp_addlinkedsrvlogin 
   'sa-inventory', 
   'false', 
   NULL, 
   'sa', 
   '12e@5678';


EXEC sp_addlinkedserver 
   @server='caribbean-inventory', 
   @srvproduct='', 
   @provider='SQLNCLI', 
   @datasrc='localhost,1436';

EXEC sp_addlinkedsrvlogin 
   'caribbean-inventory', 
   'false', 
   NULL, 
   'sa', 
   '12e@5678';


-- Add server using MySQL (HR)

EXEC sp_addlinkedserver 
   @server='hr', 
   @srvproduct='MySQL', 
   @provider='MSDASQL', 
   @datasrc='Docker Instance';

-- datasrc='Docker Instance', this is the name of the configured DSN in the ODBC Data Source Administrator for connecting to the MySQL instance.


EXEC sp_addlinkedsrvlogin 
   'hr', 
   'false', 
   NULL, 
   'root', 
   '12345';


-- Add server using Postgres (Sales and Support)

EXEC sp_addlinkedserver 
   @server='support-sales', 
   @srvproduct='PostgreSQL', 
   @provider='MSDASQL', 
   @datasrc='PostgreSQL35W';

-- datasrc='PostgreSQL35W', this is the name of the configured DSN in the ODBC Data Source Administrator for connecting to the PostgreSQL instance.

EXEC sp_addlinkedsrvlogin 
   'support-sales', 
   'false', 
   NULL, 
   'postgres', 
   '12345';