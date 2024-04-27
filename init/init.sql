\set password `echo $FLYWAY_PASSWORD`

CREATE USER flyway WITH PASSWORD :'password';
GRANT ALL PRIVILEGES ON DATABASE devtask_db TO flyway;
