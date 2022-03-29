-- 1. creates a table with all the potentially
--    time-varying (slow changing) building features
-- 2. computes the features for each year from the
--    original imported data and appends the result
--    to the table
-- 3. provides some documentation for steps that 
--    informed feature choices


DROP TABLE building_features_temp;

CREATE TABLE building_features_temp (
    bbl                         NUMERIC
    ,block                      VARCHAR
    ,zipcode                    VARCHAR
    ,year                       NUMERIC
    -- age and alteration
    ,yearbuilt                  NUMERIC -- tree variable
    ,age                        NUMERIC
    ,build_alter_gap            NUMERIC -- the difference between the year built and the most recent alteration
    ,alterage                   NUMERIC
    ,alterage_squared           NUMERIC
    ,alterage_cubed             NUMERIC          
    -- building class features
    ,elevator                   NUMERIC
    ,commercial                 NUMERIC -- presence of stores, offices or other commercial units
    ,garage                     NUMERIC
    ,storage                    NUMERIC
    ,basement                   NUMERIC
    --
    ,waterfront                 NUMERIC
    ,frontage                   NUMERIC
    ,block_assmeblage           NUMERIC
    --
    ,cooperative                NUMERIC
    ,conv_loft_wh               NUMERIC
    --- walk-up building features
    ,tenament                   NUMERIC
    ,garden                     NUMERIC
    --- elevator building features
    ,semi_fireproof             NUMERIC
    ,fireproof                  NUMERIC
    ,luxury                     NUMERIC
    ,artist_res                 NUMERIC
    --- how many units per building on average
    ,"3_units"                  NUMERIC       
    ,"4_units"                  NUMERIC 
    ,"5_6_units"                NUMERIC 
    ,"7_10_units"               NUMERIC 
    ,"11_25_units"              NUMERIC 
    ,"26_50_units"              NUMERIC 
    ,"50plus_units"             NUMERIC
    ,units_per_building         NUMERIC
    ,floors                     NUMERIC
    ,floors_squared             NUMERIC
    ,PRIMARY KEY (bbl, year)
);

--- add building features for 2020

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2020
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;


--2019

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2019
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;


--2018

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2018
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;


--2017

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2017
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;



--2016

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2016
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;



--2015

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2015
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2014

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2014
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2013

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2013
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2012

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2012
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2011

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2011
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes::NUMERIC >= 3 )
          )
    AND UnitsTotal::NUMERIC > 0
    AND numbldgs::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    ;



--2010

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2010
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2009

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2009
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2008

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2008
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2007

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2007
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2006

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2006
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--2005

INSERT INTO building_features_temp
SELECT
    bbl
    ,block
    ,zipcode
    ,year
    --- age and alteration related variables
    , yearbuilt
    ,(year - yearbuilt)::NUMERIC as age -- age (redundant)
    ,(GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC - yearbuilt::NUMERIC)::NUMERIC as build_alter_gap -- gap between year built and most recent year altered
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)::NUMERIC as alterage -- alter-age
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^2::NUMERIC as alterage_squared -- alter-age squared
    ,(year - GREATEST(yearbuilt, yearalter1, yearalter2)::NUMERIC)^3::NUMERIC as alterage_cubed -- alter-age cubed
    --- building amenities
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator -- elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C7','S3','S4','S5','S9','D6','D7'])
            OR ComArea::NUMERIC > 0 
            OR RetailArea::NUMERIC > 0 
            OR OfficeArea::NUMERIC > 0 
            OR UnitsTotal::NUMERIC > UnitsRes::NUMERIC
            THEN 1 ELSE 0 END) as commercial --commercial
    ,(CASE WHEN GarageArea::NUMERIC > 0 THEN 1 ELSE 0 END) as garage -- garage
    ,(CASE WHEN StrgeArea::NUMERIC > 0 THEN 1 ELSE 0 END) as storage -- storage
    ,(CASE WHEN BsmtCode LIKE ANY(ARRAY['1','2','3','4']) THEN 1 ELSE 0 END) as basement -- basement
    --- features from lot type / location
    ,(CASE WHEN LotType LIKE '2' THEN 1 ELSE 0 END) as waterfront --waterfront
    ,(CASE WHEN LotType LIKE ANY(ARRAY['1','3','4','5']) THEN 1 ELSE 0 END) as frontage --lot that has exposure to at least one street
    ,(CASE WHEN LotType LIKE '1'THEN 1 ELSE 0 END) as block_assmeblage -- a lot that encompasses the entire block
    --- 
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6','C8','D0','D4']) THEN 1 ELSE 0 END) as cooperative -- cooperative
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8','D0','D2']) THEN 1 ELSE 0 END) as converted_loft_wh -- converted loft or warehouse
    --- walk-up-sepecific features
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament -- tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden -- garden
    --- elevator-building-specific features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1','D7']) THEN 1 ELSE 0 END) as semi_fireproof -- semi-fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3','D6']) THEN 1 ELSE 0 END) as fireproof -- fireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury -- luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res -- artist in residence
    --- size and height related variables
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,(CASE WHEN ( UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) ) OR bldgclass LIKE ANY(ARRAY['C3','S4']) THEN 1 ELSE 0 END) as "4_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5_6_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7_10_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11_25_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26_50_units"
    ,(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50plus_units"
    ,UnitsTotal::NUMERIC/numbldgs::NUMERIC as units_per_building
    ,numfloors::NUMERIC as floors
    ,numfloors::NUMERIC^2 as floors_squared
FROM pluto2005
    WHERE (
        ( bldgclass LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) )
            OR 
        ( bldgclass LIKE 'S9' AND UnitsRes >= 3 )
          )
    AND UnitsTotal > 0
    AND numbldgs > 0
    AND yearbuilt > 0
    ;




--- add xcoord, ycoord from pluto2021 to all years with (left join?)

DROP TABLE building_features;
CREATE TABLE building_features (
    bbl                         NUMERIC
    ,block                      VARCHAR
    ,zipcode                    VARCHAR
    ,year                       NUMERIC
    ,xcoord                     NUMERIC
    ,ycoord                     NUMERIC
    -- age and alteration
    ,yearbuilt                  NUMERIC -- tree variable
    ,age                        NUMERIC
    ,build_alter_gap            NUMERIC -- the difference between the year built and the most recent alteration
    ,alterage                   NUMERIC
    ,alterage_squared           NUMERIC
    ,alterage_cubed             NUMERIC          
    -- building class features
    ,elevator                   NUMERIC
    ,commercial                 NUMERIC -- presence of stores, offices or other commercial units
    ,garage                     NUMERIC
    ,storage                    NUMERIC
    ,basement                   NUMERIC
    --
    ,waterfront                 NUMERIC
    ,frontage                   NUMERIC
    ,block_assmeblage           NUMERIC
    --
    ,cooperative                NUMERIC
    ,conv_loft_wh               NUMERIC
    --- walk-up building features
    ,tenament                   NUMERIC
    ,garden                     NUMERIC
    --- elevator building features
    ,semi_fireproof             NUMERIC
    ,fireproof                  NUMERIC
    ,luxury                     NUMERIC
    ,artist_res                 NUMERIC
    --- how many units per building on average
    ,"3_units"                  NUMERIC       
    ,"4_units"                  NUMERIC 
    ,"5_6_units"                NUMERIC 
    ,"7_10_units"               NUMERIC 
    ,"11_25_units"              NUMERIC 
    ,"26_50_units"              NUMERIC 
    ,"50plus_units"             NUMERIC
    ,units_per_building         NUMERIC
    ,floors                     NUMERIC
    ,floors_squared             NUMERIC
    ,PRIMARY KEY (bbl, year)
);


INSERT INTO building_features
SELECT  bf.bbl
        ,bf.block
        ,bf.zipcode
        ,bf.year
        ,p.xcoord::NUMERIC
        ,p.ycoord::NUMERIC
        -- age and alteration
        ,bf.yearbuilt
        ,bf.age
        ,bf.build_alter_gap
        ,bf.alterage
        ,bf.alterage_squared
        ,bf.alterage_cubed       
        -- building class features
        ,bf.elevator
        ,bf.commercial
        ,bf.garage
        ,bf.storage
        ,bf.basement
        --
        ,bf.waterfront
        ,bf.frontage
        ,bf.block_assmeblage
        --
        ,bf.cooperative
        ,bf.conv_loft_wh
        --- walk-up building features
        ,bf.tenament
        ,bf.garden
        --- elevator building features
        ,bf.semi_fireproof
        ,bf.fireproof
        ,bf.luxury
        ,bf.artist_res
        --- how many units per building on average
        ,bf."3_units"   
        ,bf."4_units"
        ,bf."5_6_units"
        ,bf."7_10_units"
        ,bf."11_25_units"
        ,bf."26_50_units"
        ,bf."50plus_units"
        ,bf.units_per_building
        ,bf.floors
        ,bf.floors_squared
FROM
building_features_temp bf JOIN pluto2021 p
ON bf.bbl = p.bbl
ORDER BY bbl, year;





--- use inner join to add historical data for percent change in value per unit for the trimmed data set
---------prior to above, compute regression slopes and mean values for all the cutoffs
-------- prior to above, use sequence of joins to make 3 lags available plus the target and a second target (t and t+1)











--######################  APENDIX  ######################

-------------selecting cuts for number of units per building

SELECT
    SUM(CASE WHEN bldgclass LIKE ANY(ARRAY['C0','S3']) OR UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 3 OR bldgclass LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "3_units"
    ,SUM(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 3 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 4 AND bldgclass NOT LIKE ANY(ARRAY['C0','S3']) THEN 1 ELSE 0 END) as "4_units"
    ,SUM(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 4 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 6 THEN 1 ELSE 0 END) as "5-6"
    ,SUM(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 6 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 10 THEN 1 ELSE 0 END) as "7-10"
    ,SUM(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 10 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 25 THEN 1 ELSE 0 END) as "11-25"
    ,SUM(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 25 AND UnitsTotal::NUMERIC/numbldgs::NUMERIC <= 50 THEN 1 ELSE 0 END) as "26-50"
    ,SUM(CASE WHEN UnitsTotal::NUMERIC/numbldgs::NUMERIC > 50 THEN 1 ELSE 0 END) as "50+"
FROM pluto2020
    WHERE bldgclass
        LIKE ANY(ARRAY['D%','C%','S3','S4','S5']) 
    AND UnitsTotal>0 
    AND numbldgs>0;

-- In 2020 building sizes are as follows
-- 3_units | 4_units |  5-6  | 7-10  | 11-25 | 26-50 | 50+  
-----------+---------+-------+-------+-------+-------+------
--   80833 |   17477 | 17510 | 14394 | 14380 |  8105 | 8452
















