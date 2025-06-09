#!/bin/sh

: ${SERVER_URL:="https://notes-staging.prgms-fullcycle.com"}
: ${DB_HOST:="notes-staging.prgms-fullcycle.com"}
: ${DB_USER:="prgms"}
: ${DB_PASSWD:="prgms"}

mysql -h ${DB_HOST} -u${DB_USER} -p${DB_PASSWD} < ../database/init-test-db.sql || exit 1

python -m pytest
