# Use the official Microsoft SQL Server image as the base image
FROM mcr.microsoft.com/mssql/server:2022-latest

# Switch to root to install the additional drivers
USER root

# Copy script to configure linked servers
COPY configure-inventorydb.sh /usr/src/app/
COPY add-inventorydb.sql /usr/src/app/

# Make the script executable
RUN chmod +x /usr/src/app/configure-inventorydb.sh

# Set entrypoint to script
ENTRYPOINT ["/usr/src/app/configure-inventorydb.sh"]

# Switch back to the non-root user to run the SQL Server process
USER mssql
