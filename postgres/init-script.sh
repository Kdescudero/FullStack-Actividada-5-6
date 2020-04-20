#!/bin/bash
set -e

POSTGRES="psql --username ${POSTGRES_USER} -v ON_ERROR_STOP=1"

$POSTGRES --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE orders;
EOSQL

$POSTGRES --dbname "orders" <<-EOSQL
    CREATE TABLE USERS(
        ID SERIAL PRIMARY KEY,
        USERNAME VARCHAR NOT NULL,
        PASSWORD VARCHAR NOT NULL
    );

    CREATE TABLE PRODUCTS(
        id SERIAL PRIMARY KEY,
        name VARCHAR NOT NULL,
        description VARCHAR NOT NULL,
        base_price DECIMAL NOT NULL,
        tax_rate DECIMAL NOT NULL,
        status VARCHAR NOT NULL,
        inventory_quantity INT NOT NULL
    );
EOSQL