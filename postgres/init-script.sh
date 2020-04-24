#!/bin/bash
set -e

POSTGRES="psql --username ${POSTGRES_USER} -v ON_ERROR_STOP=1"

$POSTGRES --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE orders;
EOSQL

$POSTGRES --dbname "orders" <<-EOSQL
    CREATE TABLE PRODUCTS(
        id SERIAL PRIMARY KEY,
        name VARCHAR NOT NULL,
        description VARCHAR NOT NULL,
        base_price DECIMAL NOT NULL,
        tax_rate DECIMAL NOT NULL,
        status VARCHAR NOT NULL,
        inventory_quantity INT NOT NULL
    );
    CREATE COLLATION case_insensitive (provider = icu, locale = 'und-u-ks-level2', deterministic = false);

    create table users
    (
        username varchar(50) collate case_insensitive not null primary key,
        password varchar(500)           not null,
        enabled  boolean                not null
    );

    create table authorities
    (
        username  varchar(50) collate case_insensitive not null,
        authority varchar(50) not null,
        constraint fk_authorities_users foreign key (username) references users (username)
    );

    create unique index ix_auth_username on authorities(username, authority);
EOSQL