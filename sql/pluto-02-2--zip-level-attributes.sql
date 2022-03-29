--- city level attributes

--- zipcode level attributes
DROP TABLE zip_level_attributes;
CREATE TABLE zip_level_attributes (
    --Keys  
    year                    NUMERIC NOT NULL
    ,zipcode                VARCHAR NOT NULL
    --Mutually Inclusive Continuous Features
    ,zip_avg_age                    NUMERIC
    ,zip_avg_alterage               NUMERIC
    ,zip_avg_res_units_pb           NUMERIC
    ,zip_avg_total_units_pb         NUMERIC
    ,zip_avg_num_buildings          NUMERIC
    ,zip_avg_development            NUMERIC
    --Population Vector 
    --(proportions of building types)
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
    ,PRIMARY KEY (zipcode, year)
);


INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2020
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;



--2019
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2019
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2018
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2018
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2017
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2017
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2016
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2016
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2015
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2015
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2014
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2014
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2013
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2013
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2012
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2012
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2011
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs::NUMERIC)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2011
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2010
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs::NUMERIC)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2010
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2009
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs::NUMERIC)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2009
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;


--2008
INSERT INTO zip_level_attributes
SELECT 
    --- keys
    year
    ,zipcode
    ---
    ,AVG(2021-yearbuilt)::NUMERIC as zip_avg_age
    ,AVG(2021-GREATEST(yearbuilt,yearalter1,yearalter2))::NUMERIC as zip_avg_alterage
    ,AVG(unitsres::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_res_units
    ,AVG(unitstotal::NUMERIC/numbldgs::NUMERIC)::NUMERIC as zip_avg_total_units
    ,AVG(numbldgs::NUMERIC)::NUMERIC as zip_avg_num_buildings
    ,AVG(builtfar::NUMERIC)::NUMERIC as avg_development
    --- building population vector; to be dimensionally reduced
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['A%', 'B%', 'S1','S2']) THEN 1 ELSE 0 END) as zip_small_residential
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['C%', 'S3','S4','S5']) THEN 1 ELSE 0 END)::NUMERIC as zip_rental_walk_up
    ,AVG(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END)::NUMERIC as zip_rental_elevator
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['R1', 'R2', 'R3', 'R4', 'R5', 'R6']) THEN 1 ELSE 0 END)::NUMERIC as zip_condominiums
    ,AVG(CASE WHEN bldgclass LIKE 'O%' THEN 1 ELSE 0 END)::NUMERIC as zip_offices
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['E%', 'F%', 'U%']) THEN 1 ELSE 0 END)::NUMERIC as zip_industrial_utility
    ,AVG(CASE WHEN bldgclass LIKE 'Y%' THEN 1 ELSE 0 END)::NUMERIC as zip_government
    ,AVG(CASE WHEN bldgclass LIKE 'L%' THEN 1 ELSE 0 END)::NUMERIC as zip_loft
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G1','G6','G7','RG','RP','Z2']) THEN 1 ELSE 0 END)::NUMERIC as zip_parking
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['G2', 'G3', 'G4', 'G5', 'G8', 'GU', 'GW']) THEN 1 ELSE 0 END)::NUMERIC as zip_cars
    ,AVG(CASE WHEN bldgclass LIKE 'H%' THEN 1 ELSE 0 END)::NUMERIC as zip_hotel
    ,AVG(CASE WHEN bldgclass LIKE 'J%' THEN 1 ELSE 0 END)::NUMERIC as zip_theater
    ,AVG(CASE WHEN bldgclass LIKE ANY(ARRAY['K%', 'R7', 'R8']) THEN 1 ELSE 0 END)::NUMERIC as zip_retail
    ,AVG(CASE WHEN bldgclass LIKE 'I%' THEN 1 ELSE 0 END)::NUMERIC as zip_healthcare
    ,AVG(CASE WHEN bldgclass LIKE 'N%' THEN 1 ELSE 0 END)::NUMERIC as zip_asylum
    ,AVG(CASE WHEN bldgclass LIKE 'M%' THEN 1 ELSE 0 END)::NUMERIC as zip_church
    ,AVG(CASE WHEN bldgclass LIKE 'W%' THEN 1 ELSE 0 END)::NUMERIC as zip_education
    ,AVG(CASE WHEN bldgclass LIKE 'P%' THEN 1 ELSE 0 END)::NUMERIC as zip_public
    ,AVG(CASE WHEN bldgclass LIKE 'Q%' THEN 1 ELSE 0 END)::NUMERIC as zip_outdoor
    ,AVG(CASE WHEN bldgclass LIKE 'T%' THEN 1 ELSE 0 END)::NUMERIC as zip_transport
FROM pluto2008
WHERE numbldgs::NUMERIC > 0
    AND unitstotal::NUMERIC > 0
    AND yearbuilt::NUMERIC > 0
    AND zipcode IS NOT NULL
    AND year IS NOT NULL
GROUP BY year, zipcode
ORDER BY year, zipcode;

















































































































































SELECT
    REGR_SLOPE(year, avg_total_value)
FROM 
WHERE year <=2017



--- general table pivot function
SELECT 'SELECT *
FROM   crosstab(
       ''SELECT unnest(''' || quote_literal(array_agg(attname))
                           || '''::text[]) AS col
             , row_number() OVER ()
             , unnest(ARRAY[' || string_agg(quote_ident(attname)
                              || '::text', ',') || ']) AS val
        FROM   ' || attrelid::regclass || '
        ORDER  BY generate_series(1,' || count(*) || '), 2''
   ) t (col text, '
     || (SELECT string_agg('r'|| rn ||' text', ',')
         FROM (SELECT row_number() OVER () AS rn FROM [TABLE_NAME]) t) -- substitute table name here
     || ')' AS sql
FROM   pg_attribute
WHERE  attrelid = '[TABLE_NAME]'::regclass -- and here
AND    attnum > 0
AND    NOT attisdropped
GROUP  BY attrelid;




-- need bash command
psql pluto -c 'create extension hstore;'
-- or more generally
psql [target_database] -c 'create extension hstore;'

SELECT (x).key, (x).value
FROM
  ( SELECT EACH(hstore(t)) as x
    FROM   assessed_total_value as t
    WHERE bbl=3003560014.00000000
  ) q;



------ compute regression of value per unit against year for every zipcode with a year cutoff of 2017
SELECT zipcode, regr_slope(year::INTEGER, vpu::NUMERIC)
FROM
(SELECT zipcode, (x).key as year, (x).value as vpu
FROM
  ( SELECT pluto.zipcode, EACH(hstore(vpu)) as x
    FROM   value_per_unit as vpu
    JOIN pluto2021 as pluto
    ON pluto.bbl = vpu.bbl
  ) q) v
  WHERE year != 'bbl'
  AND year::INTEGER <= 2017 -- change cutoff as needed
  AND vpu IS NOT NULL
  AND vpu::NUMERIC > 0
  GROUP BY zipcode;


SELECT bbl, (x).key, (x).value
FROM
  ( SELECT zipcode, EACH(hstore(t)) as x
    FROM   
    (SELECT
    AVG()
    )
  ) q;












CREATE TABLE rental_attributes_2021 (
    --Keys
    bbl                     NUMERIC     PRIMARY KEY
    zipcode                 INTEGER
    --Mutually Inclusive Continuous Features
    ,xcoord                 NUMERIC
    ,ycoord                 NUMERIC
    ,yearbuilt              NUMERIC
    ,easements              NUMERIC
    ,unitsres               NUMERIC
    ,unitstotal             NUMERIC
    ,numbldgs               NUMERIC
    ,builtfar               NUMERIC
    --Mutually Inclusive Categorical Features
    ,elevator               INTEGER -- (binary) all D% are yes all C% are no
    ,stores                 INTEGER -- (binary) all S% and some C% & D% are yes
    ,converted_lw           INTEGER -- (binary) some C% and D%
    ,cooperative            INTEGER -- (binary) some C% and D%
    ,garage                 INTEGER -- (binary) yes if garagearea > 0
    ---Elevator Building Features
    ,fireproof              INTEGER -- (binary) some D% only
    ,semifireproof          INTEGER -- (binary) some D% only
    ,luxury                 INTEGER -- (binary) some D% only
    ,artist_res             INTEGER -- (binary) some D% only
    ,conv_elev              INTEGER -- (binary) some D% only
    ---Walk-Up Building Features
    ,conv_house             INTEGER -- (binary) some S% only
    ,tenament               INTEGER -- (binary) some S% only
    ,garden                 INTEGER -- (binary) some S% only
)


SELECT 
    --- keys
    bbl
    ,zipcode
    ---
    ,xcoord
    ,ycoord
    ,yearbuilt
    ,easements
    ,unitsres -- or LOG(unitsres)?
    ,unitstotal
    ,numbldgs
    ,builtfar
    ---
    ,(CASE WHEN bldgclass LIKE 'D%' THEN 1 ELSE 0 END) as elevator
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['S%', 'D6', 'D7']) THEN 1 ELSE 0 END) as stores
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C8', 'D0']) THEN 1 ELSE 0 END) as converted_lw
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['C6', 'C8', 'D0', 'D4']) THEN 1 ELSE 0 END) as cooperative
    ,(CASE WHEN garagearea > 0 THEN 1 ELSE 0)
    --- elevator residential features
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D3', 'D6']) THEN 1 ELSE 0 END) as fireproof
    ,(CASE WHEN bldgclass LIKE ANY(ARRAY['D1', 'D7']) THEN 1 ELSE 0 END) as semifireproof
    ,(CASE WHEN bldgclass LIKE 'D8' THEN 1 ELSE 0 END) as luxury
    ,(CASE WHEN bldgclass LIKE 'D2' THEN 1 ELSE 0 END) as artist_res
    ,(CASE WHEN bldgclass LIKE 'D5' THEN 1 ELSE 0 END) as conv_elev
    --- walk-up features
    ,(CASE WHEN bldgclass LIKE 'C5' THEN 1 ELSE 0 END) as conv_house
    ,(CASE WHEN bldgclass LIKE 'C4' THEN 1 ELSE 0 END) as tenament
    ,(CASE WHEN bldgclass LIKE 'C9' THEN 1 ELSE 0 END) as garden
    --- 
FROM pluto2021


------












SELECT zipcode, AVG(bbl_count) 
FROM (SELECT
zipcode
,block
,COUNT(bbl) as bbl_count
FROM
pluto2021
GROUP BY zipcode, block
ORDER BY zipcode, block
) block_counts
GROUP BY zipcode
ORDER BY zipcode;