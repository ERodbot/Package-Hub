#!/bin/bash

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Function to wait for SQL Server to start and accept connections
wait_for_sql() {
    until /opt/mssql-tools/bin/sqlcmd -U SA -P "12e@5678" -Q "SELECT 1" &>/dev/null; do
        echo "Waiting for SQL Server to start..."
        sleep 5
    done
}

# Wait for SQL Server to start
wait_for_sql

# Run the SQL setup script
# This assumes that the add-servers.sql script is in the same directory as this script.
# You might need to adjust the path depending on where you place the script.
/opt/mssql-tools/bin/sqlcmd -U SA -P "12e@5678" -i /opt/mssql-tools/bin/sqlcmd -U SA -P "12e@5678" -i /usr/src/app/add-inventorydb.sql

# Keep the container running by waiting on the main process
wait
