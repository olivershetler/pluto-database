DROP TABLE pluto;
CREATE TABLE pluto (
    -- keys
    year                        NUMERIC
    ,bbl                        NUMERIC
    ,block                      NUMERIC
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
    -- ZIPCODE LEVEL FEATURES------------------------------------
    ,zip_avg_age                NUMERIC
    ,zip_avg_alterage           NUMERIC
    ,zip_avg_res_units_pb       NUMERIC
    ,zip_avg_total_units_pb     NUMERIC
    ,zip_avg_num_buildings      NUMERIC
    ,zip_avg_development        NUMERIC
    --Population Vector
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
    -- PCVPU FOR BBL, BLOCK AND ZIPCODE LEVEL WITH LAG ------------
    ,pcvpu_L1                       NUMERIC
    ,pcvpu_L2                       NUMERIC
    ,pcvpu_L3                       NUMERIC
    ,avg_block_pcvpu_L1             NUMERIC
    ,avg_block_pcvpu_L2             NUMERIC
    ,avg_block_pcvpu_L3             NUMERIC
    ,avg_neighbor1_pcvpu_L1         NUMERIC
    ,avg_neighbor1_pcvpu_L2         NUMERIC
    ,avg_neighbor1_pcvpu_L3         NUMERIC
    ,avg_neighbor2_pcvpu_L1         NUMERIC
    ,avg_neighbor2_pcvpu_L2         NUMERIC
    ,avg_neighbor2_pcvpu_L3         NUMERIC
    ,avg_neighbor3_pcvpu_L1         NUMERIC
    ,avg_neighbor3_pcvpu_L2         NUMERIC
    ,avg_neighbor3_pcvpu_L3         NUMERIC
    ,avg_neighbor4_pcvpu_L1         NUMERIC
    ,avg_neighbor4_pcvpu_L2         NUMERIC
    ,avg_neighbor4_pcvpu_L3         NUMERIC
    ,avg_zip_pcvpu_L1               NUMERIC
    ,avg_zip_pcvpu_L2               NUMERIC
    ,avg_zip_pcvpu_L3               NUMERIC
    -- the target
    ,pcvpu_target                   NUMERIC NOT NULL
);

INSERT INTO pluto
SELECT
    vpu.year::NUMERIC   
    ,vpu.bbl::NUMERIC
    ,vpu.block::NUMERIC
    ,vpu.zipcode
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
    -- pcvpu with lags
    ,pcvpu_L1
    ,pcvpu_L2
    ,pcvpu_L3
    ,avg_block_pcvpu_L1
    ,avg_block_pcvpu_L2
    ,avg_block_pcvpu_L3
    ,avg_neighbor1_pcvpu_L1
    ,avg_neighbor1_pcvpu_L2
    ,avg_neighbor1_pcvpu_L3
    ,avg_neighbor2_pcvpu_L1
    ,avg_neighbor2_pcvpu_L2
    ,avg_neighbor2_pcvpu_L3
    ,avg_neighbor3_pcvpu_L1
    ,avg_neighbor3_pcvpu_L2
    ,avg_neighbor3_pcvpu_L3
    ,avg_neighbor4_pcvpu_L1
    ,avg_neighbor4_pcvpu_L2
    ,avg_neighbor4_pcvpu_L3
    ,avg_zip_pcvpu_L1
    ,avg_zip_pcvpu_L2
    ,avg_zip_pcvpu_L3
    -- target
    ,pcvpu_target
FROM
pc_vpu_all vpu INNER JOIN features_all f
ON vpu.bbl = f.bbl AND f.block::NUMERIC = vpu.block::NUMERIC AND vpu.zipcode = f.zipcode AND vpu.year = f.year
ORDER BY vpu.bbl, vpu.year;


\copy pluto TO '/home/oliver/data/pluto/pluto.csv' CSV HEADER;