CREATE DATABASE kiva;

CREATE TABLE activities (
    activity_id integer PRIMARY KEY,
    activity_name varchar NOT NULL
);

CREATE TABLE sectors (
    sector_id integer PRIMARY KEY,
    sector_name varchar NOT NULL
);

CREATE TABLE demographics (
    borrower_id integer PRIMARY KEY,
    borrowed_amount numeric,
    is_primary boolean,
    gender varchar
);

CREATE TABLE countries (
    country_id serial PRIMARY KEY,
    country_name varchar,
    iso_code varchar,
    region varchar,
    ppp money,
    num_loans_fundraising integer,
    funds_lent_in_country integer
);

CREATE TABLE geocode (
    geo_id serial PRIMARY KEY,
    city varchar ,
    state varchar,
    iso_code varchar,
    postal_code varchar,
    latitude varchar,
    longitude varchar
);

CREATE TABLE currencies (
    currency_id serial PRIMARY KEY,
    currency varchar,
    currency_full_name varchar
);

CREATE TABLE loans (
    loan_id integer PRIMARY KEY,
    activity_id integer REFERENCES activities,
    sector_id integer REFERENCES sectors,
    borrower_id integer,
    borrower_count integer,
    disbursal_date timestamptz,
    disbursal_amount numeric,
    lender_repayment_term integer,
    status varchar,
    loan_amount numeric,
    currency_id integer REFERENCES currencies,
    currency_full_name varchar,
    iso_code varchar,
    geo_id integer REFERENCES geocode,
    city varchar
);

CREATE TABLE utility (
    loan_id integer PRIMARY KEY REFERENCES loans,
    activity_id integer REFERENCES activities ON UPDATE CASCADE,
    sector_id integer REFERENCES sectors ON UPDATE CASCADE,
    tags varchar,
    description_in_original_language varchar
);

CREATE TABLE crowdsourced (
    loan_id integer REFERENCES loans,
    borrower_id integer REFERENCES demographics,
    fundraising_date timestamptz,
    state varchar,
    raised_date timestamptz
);

CREATE TABLE exchange (
    currency_id serial PRIMARY KEY
    currency varchar REFERENCES currencies,
    exchange_rate numeric,
    currency_full_name varchar REFERENCES currencies
);


\copy activities (activity_id,activity_name) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy sectors (sector_id,sector_name) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy demographics (borrower_id,borrowed_amount,is_primary,gender) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy countries (country_name,iso_code,region,ppp,num_loans_fundraising,funds_lent_in_country) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy geocode (city,state,iso_code,postal_code,latitude,longitude) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy currencies (currency,currency_full_name) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy loans (loan_id,activity_id,sector_id,borrower_id,borrower_count,disbursal_date,disbursal_amount,lender_repayment_term,status,loan_amount,currency_full_name,iso_code,city) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy utility (loan_id,activity_id,sector_id,tags,description_in_original_language) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy crowdsourced (loan_id,borrower_id,fundraising_date,state, raised_date) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);

\copy exchange (currency, exchange_rate, currency_full_name) FROM 'YOUR PATH HERE' WITH (FORMAT csv, HEADER);