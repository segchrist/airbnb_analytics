USE WAREHOUSE COMPUTE_WH;
USE DATABASE AIRBNB;
USE SCHEMA RAW;    
    
create or replace api integration integration_jeu_de_donnees_github
api_provider = git_https_api
api_allowed_prefixes = ('https://github.com/QuantikDataStudio')
enabled = true;

create or replace git repository jeu_de_donnees_airbnb
api_integration = integration_jeu_de_donnees_github
origin = 'https://github.com/QuantikDataStudio/dbt.git';

create or replace file format format_jeu_de_donnees
type = csv
skip_header = 1
field_optionally_enclosed_by = '"';

CREATE TABLE AIRBNB.RAW.HOSTS
(
    host_id                STRING,
    host_name              STRING,
    host_since             DATE,
    host_location          STRING,
    host_response_time     STRING,
    host_response_rate     STRING,
    host_is_superhost      STRING,
    host_neighbourhood     STRING,
    host_identity_verified STRING
);


insert INTO AIRBNB.RAW.HOSTS (SELECT $1 as host_id,
                                     $2 as host_name,
                                     $3 as host_since,
                                     $4 as host_location,
                                     $5 as host_response_time,
                                     $6 as host_response_rate,
                                     $7 as host_is_superhost,
                                     $8 as host_neighbourhood,
                                     $9 as host_identity_verified
                              from @jeu_de_donnees_airbnb/branches/main/dataset/hosts.csv
                          (FILE_FORMAT => 'format_jeu_de_donnees'));

CREATE TABLE AIRBNB.RAW.LISTINGS
(
    id                     STRING,
    listing_url            STRING,
    name                   STRING,
    description            STRING,
    neighbourhood_overview STRING,
    host_id                STRING,
    latitude               STRING,
    longitude              STRING,
    property_type          STRING,
    room_type              STRING,
    accommodates           integer,
    bathrooms              FLOAT,
    bedrooms               FLOAT,
    beds                   FLOAT,
    amenities              STRING,
    price                  STRING,
    minimum_nights         INTEGER,
    maximum_nights         INTEGER
);

INSERT INTO AIRBNB.RAW.LISTINGS (SELECT $1  AS id,
                                        $2  AS listing_url,
                                        $3  AS name,
                                        $4  AS description,
                                        $5  AS neighbourhood_overview,
                                        $6  AS host_id,
                                        $7  AS latitude,
                                        $8  AS longitude,
                                        $9  AS property_type,
                                        $10 AS room_type,
                                        $11 AS accommodates,
                                        $12 AS bathrooms,
                                        $13 AS bedrooms,
                                        $14 AS beds,
                                        $15 AS amenities,
                                        $16 AS price,
                                        $17 AS minimum_nights,
                                        $18 AS maximum_nights
                                 from @jeu_de_donnees_airbnb/branches/main/dataset/listings.csv
                          (FILE_FORMAT => 'format_jeu_de_donnees'));


CREATE TABLE AIRBNB.RAW.REVIEWS
(
    listing_id  STRING,
    date        DATE
);

INSERT INTO AIRBNB.RAW.REVIEWS (SELECT $1 as listing_id,
                                       $2 as date
                                from @jeu_de_donnees_airbnb/branches/main/dataset/reviews.csv
                                    (FILE_FORMAT => 'format_jeu_de_donnees'));



select * from AIRBNB.RAW.LISTINGS