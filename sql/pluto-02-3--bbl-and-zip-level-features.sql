
DROP TABLE features_all;
CREATE TABLE features_all (
    -- keys
    year                        NUMERIC
    ,bbl                        NUMERIC
    ,block                      VARCHAR
    ,zipcode                    VARCHAR
    --BUILDING LEVEL FEATURES-------------------------------------
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
    ,elevator                   NUMERIC -- binary presence of elevator
    ,commercial                 NUMERIC -- binary, presence of stores, offices or other commercial units
    ,garage                     NUMERIC -- binary presence of garage
    ,storage                    NUMERIC -- binary presence of storage units
    ,basement                   NUMERIC -- binary presence of basement
    --
    ,waterfront                 NUMERIC -- binary presence of waterfront location
    ,frontage                   NUMERIC -- binary, indicates that a building abutts at least one street
    ,block_assmeblage           NUMERIC -- binary, indicates that a building is in a block assmeblage
    --
    ,cooperative                NUMERIC -- binary, indicates a building is managed as a cooperative
    ,conv_loft_wh               NUMERIC -- binary, indicates a building is a converted loft or warehouse
    --- walk-up building features
    ,tenament                   NUMERIC -- binary, indicates a building is was originally a tenement
    ,garden                     NUMERIC -- binary, indicates a building is in a low-sitting residential building with an inner courtyard or garden
    --- elevator building features
    ,semi_fireproof             NUMERIC -- binary, indicates a building is semi-fireproof
    ,fireproof                  NUMERIC -- binary, indicates a building is fireproof
    ,luxury                     NUMERIC -- binary, indicates a building is a luxury building
    ,artist_res                 NUMERIC -- binary, indicates a building is an artist residency (e.g. a very large studio requiring an artist's license to occupy)
    --- how many units per building on average
    ,"3_units"                  NUMERIC -- binary, indicates a building has 3 units
    ,"4_units"                  NUMERIC -- binary, indicates a building has 4 units
    ,"5_6_units"                NUMERIC -- binary, indicates a building has 5-6 units
    ,"7_10_units"               NUMERIC -- binary, indicates a building has 7-10 units
    ,"11_25_units"              NUMERIC -- binary, indicates a building has 11-25 units
    ,"26_50_units"              NUMERIC -- binary, indicates a building has 26-50 units
    ,"50plus_units"             NUMERIC -- binary, indicates a building has 50+ units
    ,units_per_building         NUMERIC -- the average number of units per building
    ,floors                     NUMERIC -- the number of floors in a building
    ,floors_squared             NUMERIC -- the number of floors squared
    -- ZIPCODE LEVEL FEATURES------------------------------------
    ,zip_avg_age                NUMERIC
    ,zip_avg_alterage           NUMERIC
    ,zip_avg_res_units_pb       NUMERIC
    ,zip_avg_total_units_pb     NUMERIC
    ,zip_avg_num_buildings      NUMERIC
    ,zip_avg_development        NUMERIC
    --Population Vector (aggregated proportions for binary variables)
    ,zip_small_residential      NUMERIC
    ,zip_rental_walk_up         NUMERIC
    ,zip_rental_elevator        NUMERIC
    ,zip_condominiums           NUMERIC
    ,zip_offices                NUMERIC
    ,zip_industrial_utility     NUMERIC
    ,zip_government             NUMERIC
    ,zip_loft                   NUMERIC
    ,zip_parking                NUMERIC
    ,zip_cars                   NUMERIC
    ,zip_hotel                  NUMERIC
    ,zip_theater                NUMERIC
    ,zip_retail                 NUMERIC
    ,zip_healthcare             NUMERIC
    ,zip_asylum                 NUMERIC
    ,zip_church                 NUMERIC
    ,zip_education              NUMERIC
    ,zip_public                 NUMERIC
    ,zip_outdoor                NUMERIC
    ,zip_transport              NUMERIC
    ,PRIMARY KEY (bbl, year)
);

INSERT INTO features_all
SELECT
    -- keys
    bf.year
    ,bf.bbl
    ,bf.block
    ,bf.zipcode
    --BUILDING LEVEL FEATURES-------------------------------------
    ,xcoord
    ,ycoord
    -- age and alteration
    ,yearbuilt
    ,age
    ,build_alter_gap
    ,alterage
    ,alterage_squared
    ,alterage_cubed
    -- building class features
    ,elevator
    ,commercial
    ,garage
    ,storage
    ,basement
    --
    ,waterfront
    ,frontage
    ,block_assmeblage
    --
    ,cooperative
    ,conv_loft_wh
    --- walk-up building features
    ,tenament
    ,garden
    --- elevator building features
    ,semi_fireproof
    ,fireproof
    ,luxury
    ,artist_res
    --- how many units per building on average
    ,"3_units"
    ,"4_units"
    ,"5_6_units"
    ,"7_10_units"
    ,"11_25_units"
    ,"26_50_units"
    ,"50plus_units"
    ,units_per_building
    ,floors
    ,floors_squared
    -- ZIPCODE LEVEL FEATURES------------------------------------
    ,zip_avg_age
    ,zip_avg_alterage
    ,zip_avg_res_units_pb
    ,zip_avg_total_units_pb
    ,zip_avg_num_buildings
    ,zip_avg_development
    --Population Vector
    ,zip_small_residential
    ,zip_rental_walk_up
    ,zip_rental_elevator
    ,zip_condominiums
    ,zip_offices
    ,zip_industrial_utility
    ,zip_government
    ,zip_loft
    ,zip_parking
    ,zip_cars
    ,zip_hotel
    ,zip_theater
    ,zip_retail
    ,zip_healthcare
    ,zip_asylum
    ,zip_church
    ,zip_education
    ,zip_public
    ,zip_outdoor
    ,zip_transport
FROM building_features bf JOIN zip_level_attributes zip
ON bf.zipcode = zip.zipcode AND bf.year = zip.year
ORDER BY bf.year, bbl, block, bf.zipcode;