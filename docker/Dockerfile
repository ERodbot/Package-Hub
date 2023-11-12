# Use the official Microsoft SQL Server image as the base image
FROM mcr.microsoft.com/mssql/server:2022-latest

# Switch to root to install the additional drivers
USER root

# Install the necessary tools and libraries for ODBC drivers
RUN apt-get update && \
    apt-get install -y curl unixodbc unixodbc-dev gnupg

# Install MySQL ODBC Driver
RUN curl -fSL -o mysql-apt-config.deb https://dev.mysql.com/get/mysql-apt-config_0.8.28-1_all.deb && \
    dpkg -i mysql-apt-config.deb && \
    apt-get update && \
    apt-get install -y mysql-server && \
    rm -f mysql-apt-config.deb


# Install PostgreSQL ODBC Driver
RUN apt-get install -y odbc-postgresql

# Copy script to configure linked servers
COPY configure-linked-server.sh /usr/src/app/
COPY add-servers.sql /usr/src/app/

# Make the script executable
RUN chmod +x /usr/src/app/configure-linked-server.sh

# Set entrypoint to script
ENTRYPOINT ["/usr/src/app/configure-linked-server.sh"]

# Switch back to the non-root user to run the SQL Server process
USER mssql
