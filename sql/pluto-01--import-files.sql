-- 1. creates the database
-- 2. creates tables for each year
--    with columns that conform to each
--    data set's unique list of variables
-- 3. imports the csv files into each table
-- 4. adds a 'year' colunm with the correct
--    year for each data set because
--    (bbl, year) serves as the long key for
--    the the long-form panel data sets

-------------------------------------------------------------------------------
-- NOTE: you must use find and replace to change the data directory for all the
-- COPY commands. The base directory is currently set to that of my computer,
-- as 'olver/data/pluto/' , which you will need to change to match the folder
-- you are storing the data in.
-------------------------------------------------------------------------------

CREATE DATABASE pluto;

-- create 


CREATE TABLE pluto2021 (
    borough                     VARCHAR
    ,block                      VARCHAR
    ,lot                        VARCHAR
    ,cd                         VARCHAR
    ,ct2010                     VARCHAR
    ,cb2010                     VARCHAR
    ,schooldist                 VARCHAR
    ,council                    VARCHAR
    ,zipcode                    INTEGER
    ,firecomp                   VARCHAR
    ,policeprct                 VARCHAR
    ,healthcenterdistrict       VARCHAR
    ,healtharea                 VARCHAR
    ,sanitboro                  VARCHAR
    ,sanitdistrict              VARCHAR
    ,sanitsub                   VARCHAR
    ,address                    VARCHAR
    ,zonedist1                  VARCHAR
    ,zonedist2                  VARCHAR
    ,zonedist3                  VARCHAR
    ,zonedist4                  VARCHAR
    ,overlay1                   VARCHAR
    ,overlay2                   VARCHAR
    ,spdist1                    VARCHAR
    ,spdist2                    VARCHAR
    ,spdist3                    VARCHAR
    ,ltdheight                  VARCHAR
    ,splitzone                  VARCHAR
    ,bldgclass                  VARCHAR
    ,landuse                    VARCHAR
    ,easements                  NUMERIC
    ,ownertype                  VARCHAR
    ,ownername                  VARCHAR
    ,lotarea                    NUMERIC
    ,bldgarea                   NUMERIC
    ,comarea                    NUMERIC
    ,resarea                    NUMERIC
    ,officearea                 NUMERIC
    ,retailarea                 NUMERIC
    ,garagearea                 NUMERIC
    ,strgearea                  NUMERIC
    ,factryarea                 NUMERIC
    ,otherarea                  NUMERIC
    ,areasource                 VARCHAR
    ,numbldgs                   NUMERIC
    ,numfloors                  NUMERIC
    ,unitsres                   NUMERIC
    ,unitstotal                 NUMERIC
    ,lotfront                   NUMERIC
    ,lotdepth                   NUMERIC
    ,bldgfront                  NUMERIC
    ,bldgdepth                  NUMERIC
    ,ext                        VARCHAR
    ,proxcode                   VARCHAR
    ,irrlotcode                 VARCHAR
    ,lottype                    VARCHAR
    ,bsmtcode                   VARCHAR
    ,assessland                 NUMERIC
    ,assesstot                  NUMERIC
    ,exempttot                  NUMERIC
    ,yearbuilt                  INTEGER --empty lots have yearbuilt=0
    ,yearalter1                 INTEGER
    ,yearalter2                 INTEGER
    ,histdist                   VARCHAR
    ,landmark                   VARCHAR
    ,builtfar                   NUMERIC
    ,residfar                   NUMERIC
    ,commfar                    NUMERIC
    ,facilfar                   NUMERIC
    ,borocode                   VARCHAR
    ,bbl                        NUMERIC     PRIMARY KEY
    ,condono                    VARCHAR
    ,tract2010                  VARCHAR
    ,xcoord                     NUMERIC
    ,ycoord                     NUMERIC
    ,zonemap                    VARCHAR
    ,zmcode                     VARCHAR
    ,sanborn                    VARCHAR
    ,taxmap                     VARCHAR
    ,edesignum                  VARCHAR
    ,appbbl                     VARCHAR
    ,appdate                    VARCHAR
    ,plutomapid                 VARCHAR
    ,firm07_flag                VARCHAR
    ,pfirm15_flag               VARCHAR
    ,version                    VARCHAR
    ,dcpedited                  VARCHAR
    ,latitude                   NUMERIC
    ,longitude                  NUMERIC
    ,notes                      VARCHAR
);

--

COPY pluto2021 FROM '/home/oliver/data/pluto/pluto_21v1.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE pluto2021
ADD COLUMN year NUMERIC;

UPDATE pluto2021
SET year=2021;


-- 

CREATE TABLE pluto2020 (
    borough                     VARCHAR
    ,block                      VARCHAR
    ,lot                        VARCHAR
    ,cd                         VARCHAR
    ,ct2010                     VARCHAR
    ,cb2010                     VARCHAR
    ,schooldist                 VARCHAR
    ,council                    VARCHAR
    ,zipcode                    INTEGER
    ,firecomp                   VARCHAR
    ,policeprct                 VARCHAR
    ,healthcenterdistrict       VARCHAR
    ,healtharea                 VARCHAR
    ,sanitboro                  VARCHAR
    ,sanitdistrict              VARCHAR
    ,sanitsub                   VARCHAR
    ,address                    VARCHAR
    ,zonedist1                  VARCHAR
    ,zonedist2                  VARCHAR
    ,zonedist3                  VARCHAR
    ,zonedist4                  VARCHAR
    ,overlay1                   VARCHAR
    ,overlay2                   VARCHAR
    ,spdist1                    VARCHAR
    ,spdist2                    VARCHAR
    ,spdist3                    VARCHAR
    ,ltdheight                  VARCHAR
    ,splitzone                  VARCHAR
    ,bldgclass                  VARCHAR
    ,landuse                    VARCHAR
    ,easements                  NUMERIC
    ,ownertype                  VARCHAR
    ,ownername                  VARCHAR
    ,lotarea                    NUMERIC
    ,bldgarea                   NUMERIC
    ,comarea                    NUMERIC
    ,resarea                    NUMERIC
    ,officearea                 NUMERIC
    ,retailarea                 NUMERIC
    ,garagearea                 NUMERIC
    ,strgearea                  NUMERIC
    ,factryarea                 NUMERIC
    ,otherarea                  NUMERIC
    ,areasource                 VARCHAR
    ,numbldgs                   NUMERIC
    ,numfloors                  NUMERIC
    ,unitsres                   NUMERIC
    ,unitstotal                 NUMERIC
    ,lotfront                   NUMERIC
    ,lotdepth                   NUMERIC
    ,bldgfront                  NUMERIC
    ,bldgdepth                  NUMERIC
    ,ext                        VARCHAR
    ,proxcode                   VARCHAR
    ,irrlotcode                 VARCHAR
    ,lottype                    VARCHAR
    ,bsmtcode                   VARCHAR
    ,assessland                 NUMERIC
    ,assesstot                  NUMERIC
    ,exempttot                  NUMERIC
    ,yearbuilt                  INTEGER --empty lots have yearbuilt=0
    ,yearalter1                 INTEGER
    ,yearalter2                 INTEGER
    ,histdist                   VARCHAR
    ,landmark                   VARCHAR
    ,builtfar                   NUMERIC
    ,residfar                   NUMERIC
    ,commfar                    NUMERIC
    ,facilfar                   NUMERIC
    ,borocode                   VARCHAR
    ,bbl                        NUMERIC     PRIMARY KEY
    ,condono                    VARCHAR
    ,tract2010                  VARCHAR
    ,xcoord                     NUMERIC
    ,ycoord                     NUMERIC
    ,zonemap                    VARCHAR
    ,zmcode                     VARCHAR
    ,sanborn                    VARCHAR
    ,taxmap                     VARCHAR
    ,edesignum                  VARCHAR
    ,appbbl                     VARCHAR
    ,appdate                    VARCHAR
    ,plutomapid                 VARCHAR
    ,firm07_flag                VARCHAR
    ,pfirm15_flag               VARCHAR
    ,version                    VARCHAR
    ,dcpedited                  VARCHAR
    ,latitude                   NUMERIC
    ,longitude                  NUMERIC
    ,notes                      VARCHAR
);

--

COPY pluto2020 FROM '/home/oliver/data/pluto/pluto_20v8.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE pluto2020
ADD COLUMN year NUMERIC;

UPDATE pluto2020
SET year=2020;

-- 

CREATE TABLE pluto2019 (
    borough                     VARCHAR
    ,block                      VARCHAR
    ,lot                        VARCHAR
    ,cd                         VARCHAR
    ,ct2010                     VARCHAR
    ,cb2010                     VARCHAR
    ,schooldist                 VARCHAR
    ,council                    VARCHAR
    ,zipcode                    INTEGER
    ,firecomp                   VARCHAR
    ,policeprct                 VARCHAR
    ,healtharea                 VARCHAR
    ,sanitboro                  VARCHAR
    ,sanitsub                   VARCHAR
    ,address                    VARCHAR
    ,zonedist1                  VARCHAR
    ,zonedist2                  VARCHAR
    ,zonedist3                  VARCHAR
    ,zonedist4                  VARCHAR
    ,overlay1                   VARCHAR
    ,overlay2                   VARCHAR
    ,spdist1                    VARCHAR
    ,spdist2                    VARCHAR
    ,spdist3                    VARCHAR
    ,ltdheight                  VARCHAR
    ,splitzone                  VARCHAR
    ,bldgclass                  VARCHAR
    ,landuse                    VARCHAR
    ,easements                  NUMERIC
    ,ownertype                  VARCHAR
    ,ownername                  VARCHAR
    ,lotarea                    NUMERIC
    ,bldgarea                   NUMERIC
    ,comarea                    NUMERIC
    ,resarea                    NUMERIC
    ,officearea                 NUMERIC
    ,retailarea                 NUMERIC
    ,garagearea                 NUMERIC
    ,strgearea                  NUMERIC
    ,factryarea                 NUMERIC
    ,otherarea                  NUMERIC
    ,areasource                 VARCHAR
    ,numbldgs                   NUMERIC
    ,numfloors                  NUMERIC
    ,unitsres                   NUMERIC
    ,unitstotal                 NUMERIC
    ,lotfront                   NUMERIC
    ,lotdepth                   NUMERIC
    ,bldgfront                  NUMERIC
    ,bldgdepth                  NUMERIC
    ,ext                        VARCHAR
    ,proxcode                   VARCHAR
    ,irrlotcode                 VARCHAR
    ,lottype                    VARCHAR
    ,bsmtcode                   VARCHAR
    ,assessland                 NUMERIC
    ,assesstot                  NUMERIC
    ,exempttot                  NUMERIC
    ,yearbuilt                  INTEGER
    ,yearalter1                 INTEGER
    ,yearalter2                 INTEGER
    ,histdist                   VARCHAR
    ,landmark                   VARCHAR
    ,builtfar                   NUMERIC
    ,residfar                   NUMERIC
    ,commfar                    NUMERIC
    ,facilfar                   NUMERIC
    ,borocode                   VARCHAR
    ,bbl                        NUMERIC     PRIMARY KEY
    ,condono                    VARCHAR
    ,tract2010                  VARCHAR
    ,xcoord                     NUMERIC
    ,ycoord                     NUMERIC
    ,zonemap                    VARCHAR
    ,zmcode                     VARCHAR
    ,sanborn                    VARCHAR
    ,taxmap                     VARCHAR
    ,edesignum                  VARCHAR
    ,appbbl                     VARCHAR
    ,appdate                    VARCHAR
    ,mappluto_f                 VARCHAR
    ,plutomapid                 VARCHAR
    ,version                    VARCHAR
    ,sanitdistrict              VARCHAR
    ,healthcenterdistrict       VARCHAR
    ,firm07_flag                VARCHAR
    ,pfirm15_flag               VARCHAR
    ,rpaddate                   VARCHAR
    ,dcasdate                   VARCHAR
    ,zoningdate                 VARCHAR
    ,landmkdate                 VARCHAR
    ,basempdate                 VARCHAR
    ,masdate                    VARCHAR
    ,polidate                   VARCHAR
    ,edesigdate                 VARCHAR
    ,geom                       VARCHAR
    ,dcpedited                  VARCHAR
);

--

COPY pluto2019 FROM '/home/oliver/data/pluto/pluto_19v2.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE pluto2019
ADD COLUMN year NUMERIC;

UPDATE pluto2019
SET year=2019;

-- 

CREATE TABLE pluto2018 (
    borough                     VARCHAR
    ,block                      VARCHAR
    ,lot                        VARCHAR
    ,cd                         VARCHAR
    ,ct2010                     VARCHAR
    ,cb2010                     VARCHAR
    ,schooldist                 VARCHAR
    ,council                    VARCHAR
    ,zipcode                    INTEGER
    ,firecomp                   VARCHAR
    ,policeprct                 VARCHAR
    ,healtharea                 VARCHAR
    ,sanitboro                  VARCHAR
    ,sanitsub                   VARCHAR
    ,address                    VARCHAR
    ,zonedist1                  VARCHAR
    ,zonedist2                  VARCHAR
    ,zonedist3                  VARCHAR
    ,zonedist4                  VARCHAR
    ,overlay1                   VARCHAR
    ,overlay2                   VARCHAR
    ,spdist1                    VARCHAR
    ,spdist2                    VARCHAR
    ,spdist3                    VARCHAR
    ,ltdheight                  VARCHAR
    ,splitzone                  VARCHAR
    ,bldgclass                  VARCHAR
    ,landuse                    VARCHAR
    ,easements                  NUMERIC
    ,ownertype                  VARCHAR
    ,ownername                  VARCHAR
    ,lotarea                    NUMERIC
    ,bldgarea                   NUMERIC
    ,comarea                    NUMERIC
    ,resarea                    NUMERIC
    ,officearea                 NUMERIC
    ,retailarea                 NUMERIC
    ,garagearea                 NUMERIC
    ,strgearea                  NUMERIC
    ,factryarea                 NUMERIC
    ,otherarea                  NUMERIC
    ,areasource                 VARCHAR
    ,numbldgs                   NUMERIC
    ,numfloors                  NUMERIC
    ,unitsres                   NUMERIC
    ,unitstotal                 NUMERIC
    ,lotfront                   NUMERIC
    ,lotdepth                   NUMERIC
    ,bldgfront                  NUMERIC
    ,bldgdepth                  NUMERIC
    ,ext                        VARCHAR
    ,proxcode                   VARCHAR
    ,irrlotcode                 VARCHAR
    ,lottype                    VARCHAR
    ,bsmtcode                   VARCHAR
    ,assessland                 NUMERIC
    ,assesstot                  NUMERIC
    ,exemptland                 NUMERIC
    ,exempttot                  NUMERIC
    ,yearbuilt                  INTEGER
    ,yearalter1                 INTEGER
    ,yearalter2                 INTEGER
    ,histdist                   VARCHAR
    ,landmark                   VARCHAR
    ,builtfar                   NUMERIC
    ,residfar                   NUMERIC
    ,commfar                    NUMERIC
    ,facilfar                   NUMERIC
    ,borocode                   VARCHAR
    ,bbl                        NUMERIC     PRIMARY KEY
    ,condono                    VARCHAR
    ,tract2010                  VARCHAR
    ,xcoord                     NUMERIC
    ,ycoord                     NUMERIC
    ,zonemap                    VARCHAR
    ,zmcode                     VARCHAR
    ,sanborn                    VARCHAR
    ,taxmap                     VARCHAR
    ,edesignum                  VARCHAR
    ,appbbl                     VARCHAR
    ,appdate                    VARCHAR
    ,mappluto_f                 VARCHAR
    ,plutomapid                 VARCHAR
    ,version                    VARCHAR
    ,sanitdistrict              VARCHAR
    ,healthcenterdistrict       VARCHAR
    ,firm07_flag                VARCHAR
    ,pfirm15_flag               VARCHAR
    ,rpaddate                   VARCHAR
    ,dcasdate                   VARCHAR
    ,zoningdate                 VARCHAR
    ,landmkdate                 VARCHAR
    ,basempdate                 VARCHAR
    ,masdate                    VARCHAR
    ,polidate                   VARCHAR
    ,edesigdate                 VARCHAR
    ,geom                       VARCHAR
);

--

COPY pluto2018 FROM '/home/oliver/data/pluto/pluto_18v2.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE pluto2018
ADD COLUMN year NUMERIC;

UPDATE pluto2018
SET year=2018;

-- 

CREATE TABLE pluto2017 (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthCenterDistrict       VARCHAR
    ,HealthArea                 VARCHAR
    ,SanitBoro                  VARCHAR
    ,SanitDistrict              VARCHAR
    ,SanitSub                   VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,SPDist3                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,FIRM07_FLAG                VARCHAR
    ,PFIRM15_FLAG               VARCHAR
    ,Version                    VARCHAR
);


CREATE TABLE pluto2017_temp (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthCenterDistrict       VARCHAR
    ,HealthArea                 VARCHAR
    ,SanitBoro                  VARCHAR
    ,SanitDistrict              VARCHAR
    ,SanitSub                   VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,SPDist3                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,FIRM07_FLAG                VARCHAR
    ,PFIRM15_FLAG               VARCHAR
    ,Version                    VARCHAR
);

-- import and append each borough file

-- brooklyn

COPY pluto2017_temp FROM '/home/oliver/data/pluto/nyc_pluto_17v1_1/BK2017V11.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2017 
SELECT * FROM pluto2017_temp;

TRUNCATE TABLE pluto2017_temp;

-- bronx

COPY pluto2017_temp FROM '/home/oliver/data/pluto/nyc_pluto_17v1_1/BX2017V11.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2017 
SELECT * FROM pluto2017_temp;

TRUNCATE TABLE pluto2017_temp;

-- manhattan

COPY pluto2017_temp FROM '/home/oliver/data/pluto/nyc_pluto_17v1_1/MN2017V11.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2017 
SELECT * FROM pluto2017_temp;

TRUNCATE TABLE pluto2017_temp;

-- queens

COPY pluto2017_temp FROM '/home/oliver/data/pluto/nyc_pluto_17v1_1/QN2017V11.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2017 
SELECT * FROM pluto2017_temp;

TRUNCATE TABLE pluto2017_temp;

-- staten island

COPY pluto2017_temp FROM '/home/oliver/data/pluto/nyc_pluto_17v1_1/SI2017V11.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2017 
SELECT * FROM pluto2017_temp;

DROP TABLE pluto2017_temp;


ALTER TABLE pluto2017
ADD COLUMN year NUMERIC;

UPDATE pluto2017
SET year=2017;


-- create a table for pluto 2016

CREATE TABLE pluto2016 (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthArea                 VARCHAR
    ,SanitBoro                  VARCHAR
    ,SanitDistrict              VARCHAR
    ,SanitSub                   VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,SPDist3                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   VARCHAR
    ,ResidFAR                   VARCHAR
    ,CommFAR                    VARCHAR
    ,FacilFAR                   VARCHAR
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);


CREATE TABLE pluto2016_temp (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthArea                 VARCHAR
    ,SanitBoro                  VARCHAR
    ,SanitDistrict              VARCHAR
    ,SanitSub                   VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,SPDist3                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   VARCHAR
    ,ResidFAR                   VARCHAR
    ,CommFAR                    VARCHAR
    ,FacilFAR                   VARCHAR
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
    );

-- import and append each borough file

-- brooklyn

COPY pluto2016_temp FROM '/home/oliver/data/pluto/nyc_pluto_16v2/BK.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2016 
SELECT * FROM pluto2016_temp;

TRUNCATE TABLE pluto2016_temp;

-- bronx

COPY pluto2016_temp FROM '/home/oliver/data/pluto/nyc_pluto_16v2/BX.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2016 
SELECT * FROM pluto2016_temp;

TRUNCATE TABLE pluto2016_temp;

-- manhattan

COPY pluto2016_temp FROM '/home/oliver/data/pluto/nyc_pluto_16v2/MN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2016 
SELECT * FROM pluto2016_temp;

TRUNCATE TABLE pluto2016_temp;

-- queens

COPY pluto2016_temp FROM '/home/oliver/data/pluto/nyc_pluto_16v2/QN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2016
SELECT * FROM pluto2016_temp;

TRUNCATE TABLE pluto2016_temp;

-- staten island

COPY pluto2016_temp FROM '/home/oliver/data/pluto/nyc_pluto_16v2/SI.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2016 
SELECT * FROM pluto2016_temp;

DROP TABLE pluto2016_temp;


ALTER TABLE pluto2016
ADD COLUMN year NUMERIC;

UPDATE pluto2016
SET year=2016;


-- create a table for pluto 2015

CREATE TABLE pluto2015 (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    VARCHAR
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthArea                 VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,AllZoning1                 VARCHAR
    ,AllZoning2                 VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  VARCHAR
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,BuiltCode                  VARCHAR
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     VARCHAR -- ran into formatting issue with coordinates 
    ,YCoord                     VARCHAR -- so changed both to varchar
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);


CREATE TABLE pluto2015_temp (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    VARCHAR
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthArea                 VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,AllZoning1                 VARCHAR
    ,AllZoning2                 VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  VARCHAR
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,BuiltCode                  VARCHAR
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     VARCHAR -- ran into formatting issue with coordinates 
    ,YCoord                     VARCHAR -- so changed both to varchar
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);

-- import and append each borough file

-- brooklyn

COPY pluto2015_temp FROM '/home/oliver/data/pluto/nyc_pluto_15v1/BK.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2015 
SELECT * FROM pluto2015_temp;

TRUNCATE TABLE pluto2015_temp;

-- bronx

COPY pluto2015_temp FROM '/home/oliver/data/pluto/nyc_pluto_15v1/BX.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2015 
SELECT * FROM pluto2015_temp;

TRUNCATE TABLE pluto2015_temp;

-- manhattan

COPY pluto2015_temp FROM '/home/oliver/data/pluto/nyc_pluto_15v1/MN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2015
SELECT * FROM pluto2015_temp;

TRUNCATE TABLE pluto2015_temp;

-- queens

COPY pluto2015_temp FROM '/home/oliver/data/pluto/nyc_pluto_15v1/QN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2015
SELECT * FROM pluto2015_temp;

TRUNCATE TABLE pluto2015_temp;

-- staten island

COPY pluto2015_temp FROM '/home/oliver/data/pluto/nyc_pluto_15v1/SI.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2015
SELECT * FROM pluto2015_temp;

DROP TABLE pluto2015_temp;


ALTER TABLE pluto2015
ADD COLUMN year NUMERIC;

UPDATE pluto2015
SET year=2015;



-- create a table for pluto 2014

CREATE TABLE pluto2014 (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthArea                 VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,AllZoning1                 VARCHAR
    ,AllZoning2                 VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 NUMERIC
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,BuiltCode                  VARCHAR
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);


CREATE TABLE pluto2014_temp (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,HealthArea                 VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,AllZoning1                 VARCHAR
    ,AllZoning2                 VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 NUMERIC
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,BuiltCode                  VARCHAR
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);

-- import and append each borough file

-- brooklyn

COPY pluto2014_temp FROM '/home/oliver/data/pluto/nyc_pluto_14v2/BK.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2014
SELECT * FROM pluto2014_temp;

TRUNCATE TABLE pluto2014_temp;

-- bronx

COPY pluto2014_temp FROM '/home/oliver/data/pluto/nyc_pluto_14v2/BX.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2014
SELECT * FROM pluto2014_temp;

TRUNCATE TABLE pluto2014_temp;

-- manhattan

COPY pluto2014_temp FROM '/home/oliver/data/pluto/nyc_pluto_14v2/MN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2014
SELECT * FROM pluto2014_temp;

TRUNCATE TABLE pluto2014_temp;

-- queens

COPY pluto2014_temp FROM '/home/oliver/data/pluto/nyc_pluto_14v2/QN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2014
SELECT * FROM pluto2014_temp;

TRUNCATE TABLE pluto2014_temp;

-- staten island

COPY pluto2014_temp FROM '/home/oliver/data/pluto/nyc_pluto_14v2/SI.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2014
SELECT * FROM pluto2014_temp;

DROP TABLE pluto2014_temp;



ALTER TABLE pluto2014
ADD COLUMN year NUMERIC;

UPDATE pluto2014
SET year=2014;




-- create a table for pluto 2013

CREATE TABLE pluto2013 (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,AllZoning1                 VARCHAR
    ,AllZoning2                 VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,BuiltCode                  VARCHAR
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);


CREATE TABLE pluto2013_temp (
    Borough                     VARCHAR
    ,Block                      VARCHAR
    ,Lot                        VARCHAR
    ,CD                         VARCHAR
    ,CT2010                     VARCHAR
    ,CB2010                     VARCHAR
    ,SchoolDist                 VARCHAR
    ,Council                    VARCHAR
    ,ZipCode                    INTEGER
    ,FireComp                   VARCHAR
    ,PolicePrct                 VARCHAR
    ,Address                    VARCHAR
    ,ZoneDist1                  VARCHAR
    ,ZoneDist2                  VARCHAR
    ,ZoneDist3                  VARCHAR
    ,ZoneDist4                  VARCHAR
    ,Overlay1                   VARCHAR
    ,Overlay2                   VARCHAR
    ,SPDist1                    VARCHAR
    ,SPDist2                    VARCHAR
    ,LtdHeight                  VARCHAR
    ,AllZoning1                 VARCHAR
    ,AllZoning2                 VARCHAR
    ,SplitZone                  VARCHAR
    ,BldgClass                  VARCHAR
    ,LandUse                    VARCHAR
    ,Easements                  NUMERIC
    ,OwnerType                  VARCHAR
    ,OwnerName                  VARCHAR
    ,LotArea                    NUMERIC
    ,BldgArea                   NUMERIC
    ,ComArea                    NUMERIC
    ,ResArea                    NUMERIC
    ,OfficeArea                 NUMERIC
    ,RetailArea                 NUMERIC
    ,GarageArea                 NUMERIC
    ,StrgeArea                  NUMERIC
    ,FactryArea                 NUMERIC
    ,OtherArea                  NUMERIC
    ,AreaSource                 VARCHAR
    ,NumBldgs                   NUMERIC
    ,NumFloors                  NUMERIC
    ,UnitsRes                   NUMERIC
    ,UnitsTotal                 NUMERIC
    ,LotFront                   NUMERIC
    ,LotDepth                   NUMERIC
    ,BldgFront                  NUMERIC
    ,BldgDepth                  NUMERIC
    ,Ext                        VARCHAR
    ,ProxCode                   VARCHAR
    ,IrrLotCode                 VARCHAR
    ,LotType                    VARCHAR
    ,BsmtCode                   VARCHAR
    ,AssessLand                 NUMERIC
    ,AssessTot                  NUMERIC
    ,ExemptLand                 NUMERIC
    ,ExemptTot                  NUMERIC
    ,YearBuilt                  INTEGER
    ,BuiltCode                  VARCHAR
    ,YearAlter1                 INTEGER
    ,YearAlter2                 INTEGER
    ,HistDist                   VARCHAR
    ,Landmark                   VARCHAR
    ,BuiltFAR                   NUMERIC
    ,ResidFAR                   NUMERIC
    ,CommFAR                    NUMERIC
    ,FacilFAR                   NUMERIC
    ,BoroCode                   VARCHAR
    ,BBL                        NUMERIC     PRIMARY KEY
    ,CondoNo                    VARCHAR
    ,Tract2010                  VARCHAR
    ,XCoord                     NUMERIC
    ,YCoord                     NUMERIC
    ,ZoneMap                    VARCHAR
    ,ZMCode                     VARCHAR
    ,Sanborn                    VARCHAR
    ,TaxMap                     VARCHAR
    ,EDesigNum                  VARCHAR
    ,APPBBL                     VARCHAR
    ,APPDate                    VARCHAR
    ,PLUTOMapID                 VARCHAR
    ,Version                    VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2013_temp FROM '/home/oliver/data/pluto/nyc_pluto_13v2/BK.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2013
SELECT * FROM pluto2013_temp;

TRUNCATE TABLE pluto2013_temp;

-- bronx

COPY pluto2013_temp FROM '/home/oliver/data/pluto/nyc_pluto_13v2/BX.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2013
SELECT * FROM pluto2013_temp;

TRUNCATE TABLE pluto2013_temp;

-- manhattan

COPY pluto2013_temp FROM '/home/oliver/data/pluto/nyc_pluto_13v2/MN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2013
SELECT * FROM pluto2013_temp;

TRUNCATE TABLE pluto2013_temp;

-- queens

COPY pluto2013_temp FROM '/home/oliver/data/pluto/nyc_pluto_13v2/QN.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2013
SELECT * FROM pluto2013_temp;

TRUNCATE TABLE pluto2013_temp;

-- staten island

COPY pluto2013_temp FROM '/home/oliver/data/pluto/nyc_pluto_13v2/SI.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2013
SELECT * FROM pluto2013_temp;

DROP TABLE pluto2013_temp;


ALTER TABLE pluto2013
ADD COLUMN year NUMERIC;

UPDATE pluto2013
SET year=2013;




-- create a table for pluto 2012

CREATE TABLE pluto2012 (
    Borough                   VARCHAR
    ,Block                    VARCHAR
    ,Lot                      VARCHAR
    ,CD                       VARCHAR
    ,CT2010                   VARCHAR
    ,CB2010                   VARCHAR
    ,SchoolDist               VARCHAR
    ,Council                  VARCHAR
    ,ZipCode                  VARCHAR
    ,FireComp                 VARCHAR
    ,PolicePrct               VARCHAR
    ,Address                  VARCHAR
    ,ZoneDist1                VARCHAR
    ,ZoneDist2                VARCHAR
    ,ZoneDist3                VARCHAR
    ,ZoneDist4                VARCHAR
    ,Overlay1                 VARCHAR
    ,Overlay2                 VARCHAR
    ,SPDist1                  VARCHAR
    ,SPDist2                  VARCHAR
    ,LtdHeight                VARCHAR
    ,AllZoning1               VARCHAR
    ,AllZoning2               VARCHAR
    ,SplitZone                VARCHAR
    ,BldgClass                VARCHAR
    ,LandUse                  VARCHAR
    ,Easements                NUMERIC
    ,OwnerType                VARCHAR
    ,OwnerName                VARCHAR
    ,LotArea                  NUMERIC
    ,BldgArea                 NUMERIC
    ,ComArea                  NUMERIC
    ,ResArea                  NUMERIC
    ,OfficeArea               NUMERIC
    ,RetailArea               NUMERIC
    ,GarageArea               NUMERIC
    ,StrgeArea                NUMERIC
    ,FactryArea               NUMERIC
    ,OtherArea                NUMERIC
    ,AreaSource               VARCHAR
    ,NumBldgs                 NUMERIC
    ,NumFloors                NUMERIC
    ,UnitsRes                 NUMERIC
    ,UnitsTotal               NUMERIC
    ,LotFront                 NUMERIC
    ,LotDepth                 NUMERIC
    ,BldgFront                NUMERIC
    ,BldgDepth                NUMERIC
    ,Ext                      VARCHAR
    ,ProxCode                 VARCHAR
    ,IrrLotCode               VARCHAR
    ,LotType                  VARCHAR
    ,BsmtCode                 VARCHAR
    ,AssessLand               NUMERIC
    ,AssessTot                NUMERIC
    ,ExemptLand               NUMERIC
    ,ExemptTot                NUMERIC
    ,YearBuilt                INTEGER
    ,BuiltCode                VARCHAR
    ,YearAlter1               INTEGER
    ,YearAlter2               INTEGER
    ,HistDist                 VARCHAR
    ,Landmark                 VARCHAR
    ,BuiltFAR                 NUMERIC
    ,MaxAllwFAR               NUMERIC
    ,BoroCode                 VARCHAR
    ,BBL                      NUMERIC     PRIMARY KEY
    ,CondoNo                  VARCHAR
    ,Tract2010                VARCHAR
    ,XCoord                   VARCHAR
    ,YCoord                   VARCHAR
    ,ZoneMap                  VARCHAR
    ,ZMCode                   VARCHAR
    ,Sanborn                  VARCHAR
    ,TaxMap                   VARCHAR
    ,EDesigNum                VARCHAR
    ,APPBBL                   VARCHAR
    ,APPDate                  VARCHAR
    ,PLUTOMapID               VARCHAR
    ,Version                  VARCHAR
);


CREATE TABLE pluto2012_temp (
    Borough                   VARCHAR
    ,Block                    VARCHAR
    ,Lot                      VARCHAR
    ,CD                       VARCHAR
    ,CT2010                   VARCHAR
    ,CB2010                   VARCHAR
    ,SchoolDist               VARCHAR
    ,Council                  VARCHAR
    ,ZipCode                  VARCHAR
    ,FireComp                 VARCHAR
    ,PolicePrct               VARCHAR
    ,Address                  VARCHAR
    ,ZoneDist1                VARCHAR
    ,ZoneDist2                VARCHAR
    ,ZoneDist3                VARCHAR
    ,ZoneDist4                VARCHAR
    ,Overlay1                 VARCHAR
    ,Overlay2                 VARCHAR
    ,SPDist1                  VARCHAR
    ,SPDist2                  VARCHAR
    ,LtdHeight                VARCHAR
    ,AllZoning1               VARCHAR
    ,AllZoning2               VARCHAR
    ,SplitZone                VARCHAR
    ,BldgClass                VARCHAR
    ,LandUse                  VARCHAR
    ,Easements                NUMERIC
    ,OwnerType                VARCHAR
    ,OwnerName                VARCHAR
    ,LotArea                  NUMERIC
    ,BldgArea                 NUMERIC
    ,ComArea                  NUMERIC
    ,ResArea                  NUMERIC
    ,OfficeArea               NUMERIC
    ,RetailArea               NUMERIC
    ,GarageArea               NUMERIC
    ,StrgeArea                NUMERIC
    ,FactryArea               NUMERIC
    ,OtherArea                NUMERIC
    ,AreaSource               VARCHAR
    ,NumBldgs                 NUMERIC
    ,NumFloors                NUMERIC
    ,UnitsRes                 NUMERIC
    ,UnitsTotal               NUMERIC
    ,LotFront                 NUMERIC
    ,LotDepth                 NUMERIC
    ,BldgFront                NUMERIC
    ,BldgDepth                NUMERIC
    ,Ext                      VARCHAR
    ,ProxCode                 VARCHAR
    ,IrrLotCode               VARCHAR
    ,LotType                  VARCHAR
    ,BsmtCode                 VARCHAR
    ,AssessLand               NUMERIC
    ,AssessTot                NUMERIC
    ,ExemptLand               NUMERIC
    ,ExemptTot                NUMERIC
    ,YearBuilt                INTEGER
    ,BuiltCode                VARCHAR
    ,YearAlter1               INTEGER
    ,YearAlter2               INTEGER
    ,HistDist                 VARCHAR
    ,Landmark                 VARCHAR
    ,BuiltFAR                 NUMERIC
    ,MaxAllwFAR               NUMERIC
    ,BoroCode                 VARCHAR
    ,BBL                      NUMERIC     PRIMARY KEY
    ,CondoNo                  VARCHAR
    ,Tract2010                VARCHAR
    ,XCoord                   VARCHAR
    ,YCoord                   VARCHAR
    ,ZoneMap                  VARCHAR
    ,ZMCode                   VARCHAR
    ,Sanborn                  VARCHAR
    ,TaxMap                   VARCHAR
    ,EDesigNum                VARCHAR
    ,APPBBL                   VARCHAR
    ,APPDate                  VARCHAR
    ,PLUTOMapID               VARCHAR
    ,Version                  VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2012_temp FROM '/home/oliver/data/pluto/nyc_pluto_12v2/bk12v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2012
SELECT * FROM pluto2012_temp;

TRUNCATE TABLE pluto2012_temp;

-- bronx

COPY pluto2012_temp FROM '/home/oliver/data/pluto/nyc_pluto_12v2/bx12v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2012
SELECT * FROM pluto2012_temp;

TRUNCATE TABLE pluto2012_temp;

-- manhattan

COPY pluto2012_temp FROM '/home/oliver/data/pluto/nyc_pluto_12v2/mn12v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2012
SELECT * FROM pluto2012_temp;

TRUNCATE TABLE pluto2012_temp;

-- queens

COPY pluto2012_temp FROM '/home/oliver/data/pluto/nyc_pluto_12v2/qn12v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2012
SELECT * FROM pluto2012_temp;

TRUNCATE TABLE pluto2012_temp;

-- staten island

COPY pluto2012_temp FROM '/home/oliver/data/pluto/nyc_pluto_12v2/si12v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2012
SELECT * FROM pluto2012_temp;

DROP TABLE pluto2012_temp;


ALTER TABLE pluto2012
ADD COLUMN year NUMERIC;

UPDATE pluto2012
SET year=2012;



-- create a table for pluto 2011

CREATE TABLE pluto2011 (
    Borough                 VARCHAR
    ,Block                  VARCHAR
    ,Lot                    VARCHAR
    ,CD                     VARCHAR
    ,CT2010                 VARCHAR
    ,CB2010                 VARCHAR
    ,SchoolDist             VARCHAR
    ,Council                VARCHAR
    ,ZipCode                VARCHAR
    ,FireComp               VARCHAR
    ,HealthArea             VARCHAR
    ,HealthCtr              VARCHAR
    ,PolicePrct             VARCHAR
    ,Address                VARCHAR
    ,ZoneDist1              VARCHAR
    ,ZoneDist2              VARCHAR
    ,ZoneDist3              VARCHAR
    ,ZoneDist4              VARCHAR
    ,Overlay1               VARCHAR
    ,Overlay2               VARCHAR
    ,SPDist1                VARCHAR
    ,SPDist2                VARCHAR
    ,LtdHeight              VARCHAR
    ,AllZoning1             VARCHAR
    ,AllZoning2             VARCHAR
    ,SplitZone              VARCHAR
    ,BldgClass              VARCHAR
    ,LandUse                VARCHAR
    ,Easements              NUMERIC
    ,OwnerType              VARCHAR
    ,OwnerName              VARCHAR
    ,LotArea                NUMERIC
    ,BldgArea               NUMERIC
    ,ComArea                NUMERIC
    ,ResArea                NUMERIC
    ,OfficeArea             NUMERIC
    ,RetailArea             NUMERIC
    ,GarageArea             NUMERIC
    ,StrgeArea              NUMERIC
    ,FactryArea             NUMERIC
    ,OtherArea              NUMERIC
    ,AreaSource             VARCHAR
    ,NumBldgs               VARCHAR
    ,NumFloors              VARCHAR
    ,UnitsRes               VARCHAR
    ,UnitsTotal             VARCHAR
    ,LotFront               VARCHAR
    ,LotDepth               VARCHAR
    ,BldgFront              VARCHAR
    ,BldgDepth              VARCHAR
    ,Ext                    VARCHAR
    ,ProxCode               VARCHAR
    ,IrrLotCode             VARCHAR
    ,LotType                VARCHAR
    ,BsmtCode               VARCHAR
    ,AssessLand             NUMERIC
    ,AssessTot              NUMERIC
    ,ExemptLand             NUMERIC
    ,ExemptTot              NUMERIC
    ,YearBuilt              INTEGER
    ,BuiltCode              VARCHAR
    ,YearAlter1             INTEGER
    ,YearAlter2             INTEGER
    ,HistDist               VARCHAR
    ,Landmark               VARCHAR
    ,BuiltFAR               NUMERIC
    ,MaxAllwFAR             NUMERIC
    ,BoroCode               VARCHAR
    ,BBL                    NUMERIC     PRIMARY KEY
    ,CondoNo                VARCHAR
    ,Tract2010              VARCHAR
    ,XCoord                 VARCHAR
    ,YCoord                 VARCHAR
    ,ZoneMap                VARCHAR
    ,ZMCode                 VARCHAR
    ,Sanborn                VARCHAR
    ,TaxMap                 VARCHAR
    ,EDesigNum              VARCHAR
    ,APPBBL                 VARCHAR
    ,APPDate                VARCHAR
    ,PLUTOMapID             VARCHAR
    ,Version                VARCHAR
);


CREATE TABLE pluto2011_temp (
    Borough                 VARCHAR
    ,Block                  VARCHAR
    ,Lot                    VARCHAR
    ,CD                     VARCHAR
    ,CT2010                 VARCHAR
    ,CB2010                 VARCHAR
    ,SchoolDist             VARCHAR
    ,Council                VARCHAR
    ,ZipCode                VARCHAR
    ,FireComp               VARCHAR
    ,HealthArea             VARCHAR
    ,HealthCtr              VARCHAR
    ,PolicePrct             VARCHAR
    ,Address                VARCHAR
    ,ZoneDist1              VARCHAR
    ,ZoneDist2              VARCHAR
    ,ZoneDist3              VARCHAR
    ,ZoneDist4              VARCHAR
    ,Overlay1               VARCHAR
    ,Overlay2               VARCHAR
    ,SPDist1                VARCHAR
    ,SPDist2                VARCHAR
    ,LtdHeight              VARCHAR
    ,AllZoning1             VARCHAR
    ,AllZoning2             VARCHAR
    ,SplitZone              VARCHAR
    ,BldgClass              VARCHAR
    ,LandUse                VARCHAR
    ,Easements              NUMERIC
    ,OwnerType              VARCHAR
    ,OwnerName              VARCHAR
    ,LotArea                NUMERIC
    ,BldgArea               NUMERIC
    ,ComArea                NUMERIC
    ,ResArea                NUMERIC
    ,OfficeArea             NUMERIC
    ,RetailArea             NUMERIC
    ,GarageArea             NUMERIC
    ,StrgeArea              NUMERIC
    ,FactryArea             NUMERIC
    ,OtherArea              NUMERIC
    ,AreaSource             VARCHAR
    ,NumBldgs               VARCHAR
    ,NumFloors              VARCHAR
    ,UnitsRes               VARCHAR
    ,UnitsTotal             VARCHAR
    ,LotFront               VARCHAR
    ,LotDepth               VARCHAR
    ,BldgFront              VARCHAR
    ,BldgDepth              VARCHAR
    ,Ext                    VARCHAR
    ,ProxCode               VARCHAR
    ,IrrLotCode             VARCHAR
    ,LotType                VARCHAR
    ,BsmtCode               VARCHAR
    ,AssessLand             NUMERIC
    ,AssessTot              NUMERIC
    ,ExemptLand             NUMERIC
    ,ExemptTot              NUMERIC
    ,YearBuilt              INTEGER
    ,BuiltCode              VARCHAR
    ,YearAlter1             INTEGER
    ,YearAlter2             INTEGER
    ,HistDist               VARCHAR
    ,Landmark               VARCHAR
    ,BuiltFAR               NUMERIC
    ,MaxAllwFAR             NUMERIC
    ,BoroCode               VARCHAR
    ,BBL                    NUMERIC     PRIMARY KEY
    ,CondoNo                VARCHAR
    ,Tract2010              VARCHAR
    ,XCoord                 VARCHAR
    ,YCoord                 VARCHAR
    ,ZoneMap                VARCHAR
    ,ZMCode                 VARCHAR
    ,Sanborn                VARCHAR
    ,TaxMap                 VARCHAR
    ,EDesigNum              VARCHAR
    ,APPBBL                 VARCHAR
    ,APPDate                VARCHAR
    ,PLUTOMapID             VARCHAR
    ,Version                VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2011_temp FROM '/home/oliver/data/pluto/nyc_pluto_11v2/bk11v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2011
SELECT * FROM pluto2011_temp;

TRUNCATE TABLE pluto2011_temp;

-- bronx

COPY pluto2011_temp FROM '/home/oliver/data/pluto/nyc_pluto_11v2/bx11v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2011
SELECT * FROM pluto2011_temp;

TRUNCATE TABLE pluto2011_temp;

-- manhattan

COPY pluto2011_temp FROM '/home/oliver/data/pluto/nyc_pluto_11v2/mn11v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2011
SELECT * FROM pluto2011_temp;

TRUNCATE TABLE pluto2011_temp;

-- queens

COPY pluto2011_temp FROM '/home/oliver/data/pluto/nyc_pluto_11v2/qn11v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2011
SELECT * FROM pluto2011_temp;

TRUNCATE TABLE pluto2011_temp;

-- staten island

COPY pluto2011_temp FROM '/home/oliver/data/pluto/nyc_pluto_11v2/si11v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2011
SELECT * FROM pluto2011_temp;

DROP TABLE pluto2011_temp;



ALTER TABLE pluto2011
ADD COLUMN year NUMERIC;

UPDATE pluto2011
SET year=2011;



-- create a table for pluto 2010

CREATE TABLE pluto2010 (
    Borough         VARCHAR     
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,ZoneDist3      VARCHAR
    ,ZoneDist4      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,LtdHeight      VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,ZMCode         VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,APPBBL         VARCHAR
    ,APPDate        VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,DTMDate        VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,EDesigDate     VARCHAR
    ,PLUTOMapID     VARCHAR
);


CREATE TABLE pluto2010_temp (
    Borough         VARCHAR     
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,ZoneDist3      VARCHAR
    ,ZoneDist4      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,LtdHeight      VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,ZMCode         VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,APPBBL         VARCHAR
    ,APPDate        VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,DTMDate        VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,EDesigDate     VARCHAR
    ,PLUTOMapID     VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2010_temp FROM '/home/oliver/data/pluto/nyc_pluto_10v2/bk10v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2010
SELECT * FROM pluto2010_temp;

TRUNCATE TABLE pluto2010_temp;

-- bronx

COPY pluto2010_temp FROM '/home/oliver/data/pluto/nyc_pluto_10v2/bx10v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2010
SELECT * FROM pluto2010_temp;

TRUNCATE TABLE pluto2010_temp;

-- manhattan

COPY pluto2010_temp FROM '/home/oliver/data/pluto/nyc_pluto_10v2/mn10v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2010
SELECT * FROM pluto2010_temp;

TRUNCATE TABLE pluto2010_temp;

-- queens

COPY pluto2010_temp FROM '/home/oliver/data/pluto/nyc_pluto_10v2/qn10v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2010
SELECT * FROM pluto2010_temp;

TRUNCATE TABLE pluto2010_temp;

-- staten island

COPY pluto2010_temp FROM '/home/oliver/data/pluto/nyc_pluto_10v2/si10v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2010
SELECT * FROM pluto2010_temp;

DROP TABLE pluto2010_temp;


ALTER TABLE pluto2010
ADD COLUMN year NUMERIC;

UPDATE pluto2010
SET year=2010;





-- create a table for pluto 2009

CREATE TABLE pluto2009 (
    Borough         VARCHAR     
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,ZoneDist3      VARCHAR
    ,ZoneDist4      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,ZMCode         VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,APPBBL         VARCHAR
    ,APPDate        VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,DTMDate        VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,EDesigDate     VARCHAR
    ,PLUTOMapID     VARCHAR
);


CREATE TABLE pluto2009_temp (
    Borough         VARCHAR     
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,ZoneDist3      VARCHAR
    ,ZoneDist4      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,ZMCode         VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,APPBBL         VARCHAR
    ,APPDate        VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,DTMDate        VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,EDesigDate     VARCHAR
    ,PLUTOMapID     VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2009_temp FROM '/home/oliver/data/pluto/nyc_pluto_09v2/BK09v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2009
SELECT * FROM pluto2009_temp;

TRUNCATE TABLE pluto2009_temp;

-- bronx

COPY pluto2009_temp FROM '/home/oliver/data/pluto/nyc_pluto_09v2/BX09v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2009
SELECT * FROM pluto2009_temp;

TRUNCATE TABLE pluto2009_temp;

-- manhattan

COPY pluto2009_temp FROM '/home/oliver/data/pluto/nyc_pluto_09v2/MN09v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2009
SELECT * FROM pluto2009_temp;

TRUNCATE TABLE pluto2009_temp;

-- queens

COPY pluto2009_temp FROM '/home/oliver/data/pluto/nyc_pluto_09v2/QN09v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2009
SELECT * FROM pluto2009_temp;

TRUNCATE TABLE pluto2009_temp;

-- staten island

COPY pluto2009_temp FROM '/home/oliver/data/pluto/nyc_pluto_09v2/SI09v2.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2009
SELECT * FROM pluto2009_temp;

DROP TABLE pluto2009_temp;


ALTER TABLE pluto2009
ADD COLUMN year NUMERIC;

UPDATE pluto2009
SET year=2009;






-- create a table for pluto 2008

CREATE TABLE pluto2008 (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        INTEGER
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,ZoneDist3      VARCHAR
    ,ZoneDist4      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         NUMERIC
    ,YCoord         NUMERIC
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,PLUTOMapID     VARCHAR
    ,Version        VARCHAR
    ,Shape_area     NUMERIC
    ,Shape_len      NUMERIC
);


CREATE TABLE pluto2008_temp (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        INTEGER
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,ZoneDist3      VARCHAR
    ,ZoneDist4      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         NUMERIC
    ,YCoord         NUMERIC
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,PLUTOMapID     VARCHAR
    ,Version        VARCHAR
    ,Shape_area     NUMERIC
    ,Shape_len      NUMERIC
);

-- import and append each borough file

-- brooklyn


COPY pluto2008_temp FROM '/home/oliver/data/pluto/nyc_pluto_08b/BK08B.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2008
SELECT * FROM pluto2008_temp;

TRUNCATE TABLE pluto2008_temp;

-- bronx

COPY pluto2008_temp FROM '/home/oliver/data/pluto/nyc_pluto_08b/BX08B.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2008
SELECT * FROM pluto2008_temp;

TRUNCATE TABLE pluto2008_temp;

-- manhattan

COPY pluto2008_temp FROM '/home/oliver/data/pluto/nyc_pluto_08b/MN08B.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2008
SELECT * FROM pluto2008_temp;

TRUNCATE TABLE pluto2008_temp;

-- queens

COPY pluto2008_temp FROM '/home/oliver/data/pluto/nyc_pluto_08b/QN08B.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2008
SELECT * FROM pluto2008_temp;

TRUNCATE TABLE pluto2008_temp;

-- staten island

COPY pluto2008_temp FROM '/home/oliver/data/pluto/nyc_pluto_08b/SI08B.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2008
SELECT * FROM pluto2008_temp;

DROP TABLE pluto2008_temp;



ALTER TABLE pluto2008
ADD COLUMN year NUMERIC;

UPDATE pluto2008
SET year=2008;




-- create a table for pluto 2007

CREATE TABLE pluto2007 (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     NUMERIC
    ,YearAlter2     NUMERIC
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);


CREATE TABLE pluto2007_temp (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     NUMERIC
    ,YearAlter2     NUMERIC
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2007_temp FROM '/home/oliver/data/pluto/nyc_pluto_07c/BK07C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2007
SELECT * FROM pluto2007_temp;

TRUNCATE TABLE pluto2007_temp;

-- bronx

COPY pluto2007_temp FROM '/home/oliver/data/pluto/nyc_pluto_07c/BX07C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2007
SELECT * FROM pluto2007_temp;

TRUNCATE TABLE pluto2007_temp;

-- manhattan

COPY pluto2007_temp FROM '/home/oliver/data/pluto/nyc_pluto_07c/MN07C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2007
SELECT * FROM pluto2007_temp;

TRUNCATE TABLE pluto2007_temp;

-- queens

COPY pluto2007_temp FROM '/home/oliver/data/pluto/nyc_pluto_07c/QN07C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2007
SELECT * FROM pluto2007_temp;

TRUNCATE TABLE pluto2007_temp;

-- staten island

COPY pluto2007_temp FROM '/home/oliver/data/pluto/nyc_pluto_07c/SI07C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2007
SELECT * FROM pluto2007_temp;

DROP TABLE pluto2007_temp;


ALTER TABLE pluto2007
ADD COLUMN year NUMERIC;

UPDATE pluto2007
SET year=2007;







-- create a table for pluto 2006

CREATE TABLE pluto2006 (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,InstRegion     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     NUMERIC
    ,YearAlter2     NUMERIC
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);


CREATE TABLE pluto2006_temp (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,InstRegion     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     NUMERIC
    ,YearAlter2     NUMERIC
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2006_temp FROM '/home/oliver/data/pluto/nyc_pluto_06c/BK06C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2006
SELECT * FROM pluto2006_temp;

TRUNCATE TABLE pluto2006_temp;

-- bronx

COPY pluto2006_temp FROM '/home/oliver/data/pluto/nyc_pluto_06c/BX06C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2006
SELECT * FROM pluto2006_temp;

TRUNCATE TABLE pluto2006_temp;

-- manhattan

COPY pluto2006_temp FROM '/home/oliver/data/pluto/nyc_pluto_06c/MN06C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2006
SELECT * FROM pluto2006_temp;

TRUNCATE TABLE pluto2006_temp;

-- queens

COPY pluto2006_temp FROM '/home/oliver/data/pluto/nyc_pluto_06c/QN06C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2006
SELECT * FROM pluto2006_temp;

TRUNCATE TABLE pluto2006_temp;

-- staten island

COPY pluto2006_temp FROM '/home/oliver/data/pluto/nyc_pluto_06c/SI06C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2006
SELECT * FROM pluto2006_temp;

DROP TABLE pluto2006_temp;


ALTER TABLE pluto2006
ADD COLUMN year NUMERIC;

UPDATE pluto2006
SET year=2006;








-- create a table for pluto 2005

CREATE TABLE pluto2005 (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     NUMERIC
    ,YearAlter2     NUMERIC
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);


CREATE TABLE pluto2005_temp (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      NUMERIC
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTot      NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTot      NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     NUMERIC
    ,YearAlter2     NUMERIC
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            NUMERIC     PRIMARY KEY
    ,CondoNo        VARCHAR
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);

-- import and append each borough file

-- brooklyn


COPY pluto2005_temp FROM '/home/oliver/data/pluto/nyc_pluto_05d/BK05D.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2005
SELECT * FROM pluto2005_temp;

TRUNCATE TABLE pluto2005_temp;

-- bronx

COPY pluto2005_temp FROM '/home/oliver/data/pluto/nyc_pluto_05d/BX05D.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2005
SELECT * FROM pluto2005_temp;

TRUNCATE TABLE pluto2005_temp;

-- manhattan

COPY pluto2005_temp FROM '/home/oliver/data/pluto/nyc_pluto_05d/MN05D.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2005
SELECT * FROM pluto2005_temp;

TRUNCATE TABLE pluto2005_temp;

-- queens

COPY pluto2005_temp FROM '/home/oliver/data/pluto/nyc_pluto_05d/QN05D.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2005
SELECT * FROM pluto2005_temp;

TRUNCATE TABLE pluto2005_temp;

-- staten island

COPY pluto2005_temp FROM '/home/oliver/data/pluto/nyc_pluto_05d/SI05D.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2005
SELECT * FROM pluto2005_temp;

DROP TABLE pluto2005_temp;


ALTER TABLE pluto2005
ADD COLUMN year NUMERIC;

UPDATE pluto2005
SET year=2005;


--#####################################
--#####################################
--#####################################
--#####################################
--#####################################
--#####################################




-- create a table for pluto 2004

DROP TABLE pluto2004;
DROP TABLE pluto2004_temp;

---

CREATE TABLE pluto2004 (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      VARCHAR
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTotal    NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTotal    NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,BBL            VARCHAR     PRIMARY KEY
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR 
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,DOBDate        VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);


CREATE TABLE pluto2004_temp (
    Borough         VARCHAR
    ,Block          VARCHAR
    ,Lot            VARCHAR
    ,CD             VARCHAR
    ,CT2000         VARCHAR
    ,CB2000         VARCHAR
    ,SchoolDist     VARCHAR
    ,Council        VARCHAR
    ,ZipCode        VARCHAR
    ,FireComp       VARCHAR
    ,HealthArea     VARCHAR
    ,HealthCtr      VARCHAR
    ,PolicePrct     VARCHAR
    ,Address        VARCHAR
    ,ZoneDist1      VARCHAR
    ,ZoneDist2      VARCHAR
    ,Overlay1       VARCHAR
    ,Overlay2       VARCHAR
    ,SPDist1        VARCHAR
    ,SPDist2        VARCHAR
    ,AllZoning1     VARCHAR
    ,AllZoning2     VARCHAR
    ,SplitZone      VARCHAR
    ,BldgClass      VARCHAR
    ,LandUse        VARCHAR
    ,Easements      VARCHAR
    ,OwnerType      VARCHAR
    ,OwnerName      VARCHAR
    ,LotArea        NUMERIC
    ,BldgArea       NUMERIC
    ,ComArea        NUMERIC
    ,ResArea        NUMERIC
    ,OfficeArea     NUMERIC
    ,RetailArea     NUMERIC
    ,GarageArea     NUMERIC
    ,StrgeArea      NUMERIC
    ,FactryArea     NUMERIC
    ,OtherArea      NUMERIC
    ,AreaSource     VARCHAR
    ,NumBldgs       NUMERIC
    ,NumFloors      NUMERIC
    ,UnitsRes       NUMERIC
    ,UnitsTotal     NUMERIC
    ,LotFront       NUMERIC
    ,LotDepth       NUMERIC
    ,BldgFront      NUMERIC
    ,BldgDepth      NUMERIC
    ,ProxCode       VARCHAR
    ,IrrLotCode     VARCHAR
    ,LotType        VARCHAR
    ,BsmtCode       VARCHAR
    ,AssessLand     NUMERIC
    ,AssessTotal    NUMERIC
    ,ExemptLand     NUMERIC
    ,ExemptTotal    NUMERIC
    ,YearBuilt      INTEGER
    ,BuiltCode      VARCHAR
    ,YearAlter1     INTEGER
    ,YearAlter2     INTEGER
    ,HistDist       VARCHAR
    ,Landmark       VARCHAR
    ,BuiltFAR       NUMERIC
    ,MaxAllwFAR     NUMERIC
    ,BoroCode       VARCHAR
    ,TBL            VARCHAR     PRIMARY KEY
    ,Tract2000      VARCHAR
    ,XCoord         VARCHAR
    ,YCoord         VARCHAR
    ,ZoneMap        VARCHAR 
    ,Sanborn        VARCHAR
    ,TaxMap         VARCHAR
    ,EDesigNum      VARCHAR
    ,RPADDate       VARCHAR
    ,DCASDate       VARCHAR
    ,DOBDate        VARCHAR
    ,ZoningDate     VARCHAR
    ,MajPrpDate     VARCHAR
    ,LandmkDate     VARCHAR
    ,BaseMpDate     VARCHAR
    ,MASDate        VARCHAR
    ,PoliDate       VARCHAR
    ,PLUTOMapID     VARCHAR
);

-- import and append each borough file

-- brooklyn

-- :%s/\%x00//g
-- search for null characters with   :%s/\%x00   
-- and ctrl g and ctrlt to jump forward and backward

-- use vim command for bronx   :%s/3\%x00\%x00\%x00/3/g


COPY pluto2004_temp FROM '/home/oliver/data/pluto/nyc_pluto_04c/bk04C.csv' DELIMITER ',' CSV HEADER;


--UPDATE pluto2004_temp
--SET Block = bl.Block 
    --FROM (SELECT REPLACE (Block,' ','0') as Block FROM pluto2004_temp) as bl;
--UPDATE pluto2004_temp
    --SET Lot = lo.Lot
    --FROM (SELECT REPLACE (Lot,' ','0') as Lot FROM pluto2004_temp) as lo;

UPDATE pluto2004_temp
SET Block = num.Block FROM 
(SELECT REPLACE (Block,' ','0') as Block FROM pluto2004_temp) as num;

UPDATE pluto2004_temp
SET Lot = num.Lot FROM 
(SELECT REPLACE (Lot,' ','0') as Lot FROM pluto2004_temp) as num;



INSERT INTO pluto2004
SELECT 
    Borough
    ,Block
    ,Lot
    ,CD
    ,CT2000
    ,CB2000
    ,SchoolDist
    ,Council
    ,ZipCode
    ,FireComp
    ,HealthArea
    ,HealthCtr
    ,PolicePrct
    ,Address
    ,ZoneDist1
    ,ZoneDist2
    ,Overlay1
    ,Overlay2
    ,SPDist1
    ,SPDist2
    ,AllZoning1
    ,AllZoning2
    ,SplitZone
    ,BldgClass
    ,LandUse
    ,Easements
    ,OwnerType
    ,OwnerName
    ,LotArea
    ,BldgArea
    ,ComArea
    ,ResArea
    ,OfficeArea
    ,RetailArea
    ,GarageArea
    ,StrgeArea
    ,FactryArea
    ,OtherArea
    ,AreaSource
    ,NumBldgs
    ,NumFloors
    ,UnitsRes
    ,UnitsTotal
    ,LotFront
    ,LotDepth
    ,BldgFront
    ,BldgDepth
    ,ProxCode
    ,IrrLotCode
    ,LotType
    ,BsmtCode
    ,AssessLand
    ,AssessTotal
    ,ExemptLand
    ,ExemptTotal
    ,YearBuilt
    ,BuiltCode
    ,YearAlter1
    ,YearAlter2
    ,HistDist
    ,Landmark
    ,BuiltFAR
    ,MaxAllwFAR
    ,BoroCode
    ,CONCAT(BoroCode, Block, Lot) as BBL
    ,Tract2000
    ,XCoord
    ,YCoord
    ,ZoneMap
    ,Sanborn
    ,TaxMap
    ,EDesigNum
    ,RPADDate
    ,DCASDate
    ,DOBDate
    ,ZoningDate
    ,MajPrpDate
    ,LandmkDate
    ,BaseMpDate
    ,MASDate
    ,PoliDate
    ,PLUTOMapID
FROM pluto2004_temp;

TRUNCATE TABLE pluto2004_temp;

-- bronx

--use vim command     :%s/2\%x00\%x00\%x00\%x00/2/g

COPY pluto2004_temp FROM '/home/oliver/data/pluto/nyc_pluto_04c/bx04C.csv' DELIMITER ',' CSV HEADER;


INSERT INTO pluto2004
SELECT 
    Borough
    ,Block
    ,Lot
    ,CD
    ,CT2000
    ,CB2000
    ,SchoolDist
    ,Council
    ,ZipCode
    ,FireComp
    ,HealthArea
    ,HealthCtr
    ,PolicePrct
    ,Address
    ,ZoneDist1
    ,ZoneDist2
    ,Overlay1
    ,Overlay2
    ,SPDist1
    ,SPDist2
    ,AllZoning1
    ,AllZoning2
    ,SplitZone
    ,BldgClass
    ,LandUse
    ,Easements
    ,OwnerType
    ,OwnerName
    ,LotArea
    ,BldgArea
    ,ComArea
    ,ResArea
    ,OfficeArea
    ,RetailArea
    ,GarageArea
    ,StrgeArea
    ,FactryArea
    ,OtherArea
    ,AreaSource
    ,NumBldgs
    ,NumFloors
    ,UnitsRes
    ,UnitsTotal
    ,LotFront
    ,LotDepth
    ,BldgFront
    ,BldgDepth
    ,ProxCode
    ,IrrLotCode
    ,LotType
    ,BsmtCode
    ,AssessLand
    ,AssessTotal
    ,ExemptLand
    ,ExemptTotal
    ,YearBuilt
    ,BuiltCode
    ,YearAlter1
    ,YearAlter2
    ,HistDist
    ,Landmark
    ,BuiltFAR
    ,MaxAllwFAR
    ,BoroCode
    ,CONCAT(BoroCode, Block, Lot) as BBL
    ,Tract2000
    ,XCoord
    ,YCoord
    ,ZoneMap
    ,Sanborn
    ,TaxMap
    ,EDesigNum
    ,RPADDate
    ,DCASDate
    ,DOBDate
    ,ZoningDate
    ,MajPrpDate
    ,LandmkDate
    ,BaseMpDate
    ,MASDate
    ,PoliDate
    ,PLUTOMapID
FROM pluto2004_temp;

TRUNCATE TABLE pluto2004_temp;

-- manhattan

COPY pluto2004_temp FROM '/home/oliver/data/pluto/nyc_pluto_04c/mn04C.csv' DELIMITER ',' CSV HEADER;


INSERT INTO pluto2004
SELECT 
    Borough
    ,Block
    ,Lot
    ,CD
    ,CT2000
    ,CB2000
    ,SchoolDist
    ,Council
    ,ZipCode
    ,FireComp
    ,HealthArea
    ,HealthCtr
    ,PolicePrct
    ,Address
    ,ZoneDist1
    ,ZoneDist2
    ,Overlay1
    ,Overlay2
    ,SPDist1
    ,SPDist2
    ,AllZoning1
    ,AllZoning2
    ,SplitZone
    ,BldgClass
    ,LandUse
    ,Easements
    ,OwnerType
    ,OwnerName
    ,LotArea
    ,BldgArea
    ,ComArea
    ,ResArea
    ,OfficeArea
    ,RetailArea
    ,GarageArea
    ,StrgeArea
    ,FactryArea
    ,OtherArea
    ,AreaSource
    ,NumBldgs
    ,NumFloors
    ,UnitsRes
    ,UnitsTotal
    ,LotFront
    ,LotDepth
    ,BldgFront
    ,BldgDepth
    ,ProxCode
    ,IrrLotCode
    ,LotType
    ,BsmtCode
    ,AssessLand
    ,AssessTotal
    ,ExemptLand
    ,ExemptTotal
    ,YearBuilt
    ,BuiltCode
    ,YearAlter1
    ,YearAlter2
    ,HistDist
    ,Landmark
    ,BuiltFAR
    ,MaxAllwFAR
    ,BoroCode
    ,CONCAT(BoroCode, Block, Lot) as BBL
    ,Tract2000
    ,XCoord
    ,YCoord
    ,ZoneMap
    ,Sanborn
    ,TaxMap
    ,EDesigNum
    ,RPADDate
    ,DCASDate
    ,DOBDate
    ,ZoningDate
    ,MajPrpDate
    ,LandmkDate
    ,BaseMpDate
    ,MASDate
    ,PoliDate
    ,PLUTOMapID
FROM pluto2004_temp;

TRUNCATE TABLE pluto2004_temp;

-- queens

COPY pluto2004_temp FROM '/home/oliver/data/pluto/nyc_pluto_04c/qn04C.csv' DELIMITER ',' CSV HEADER;

INSERT INTO pluto2004
SELECT 
    Borough
    ,Block
    ,Lot
    ,CD
    ,CT2000
    ,CB2000
    ,SchoolDist
    ,Council
    ,ZipCode
    ,FireComp
    ,HealthArea
    ,HealthCtr
    ,PolicePrct
    ,Address
    ,ZoneDist1
    ,ZoneDist2
    ,Overlay1
    ,Overlay2
    ,SPDist1
    ,SPDist2
    ,AllZoning1
    ,AllZoning2
    ,SplitZone
    ,BldgClass
    ,LandUse
    ,Easements
    ,OwnerType
    ,OwnerName
    ,LotArea
    ,BldgArea
    ,ComArea
    ,ResArea
    ,OfficeArea
    ,RetailArea
    ,GarageArea
    ,StrgeArea
    ,FactryArea
    ,OtherArea
    ,AreaSource
    ,NumBldgs
    ,NumFloors
    ,UnitsRes
    ,UnitsTotal
    ,LotFront
    ,LotDepth
    ,BldgFront
    ,BldgDepth
    ,ProxCode
    ,IrrLotCode
    ,LotType
    ,BsmtCode
    ,AssessLand
    ,AssessTotal
    ,ExemptLand
    ,ExemptTotal
    ,YearBuilt
    ,BuiltCode
    ,YearAlter1
    ,YearAlter2
    ,HistDist
    ,Landmark
    ,BuiltFAR
    ,MaxAllwFAR
    ,BoroCode
    ,CONCAT(BoroCode, Block, Lot) as BBL
    ,Tract2000
    ,XCoord
    ,YCoord
    ,ZoneMap
    ,Sanborn
    ,TaxMap
    ,EDesigNum
    ,RPADDate
    ,DCASDate
    ,DOBDate
    ,ZoningDate
    ,MajPrpDate
    ,LandmkDate
    ,BaseMpDate
    ,MASDate
    ,PoliDate
    ,PLUTOMapID
FROM pluto2004_temp;

TRUNCATE TABLE pluto2004_temp;

-- staten island

COPY pluto2004_temp FROM '/home/oliver/data/pluto/nyc_pluto_04c/si04C.csv' DELIMITER ',' CSV HEADER;


INSERT INTO pluto2004
SELECT 
    Borough
    ,Block
    ,Lot
    ,CD
    ,CT2000
    ,CB2000
    ,SchoolDist
    ,Council
    ,ZipCode
    ,FireComp
    ,HealthArea
    ,HealthCtr
    ,PolicePrct
    ,Address
    ,ZoneDist1
    ,ZoneDist2
    ,Overlay1
    ,Overlay2
    ,SPDist1
    ,SPDist2
    ,AllZoning1
    ,AllZoning2
    ,SplitZone
    ,BldgClass
    ,LandUse
    ,Easements
    ,OwnerType
    ,OwnerName
    ,LotArea
    ,BldgArea
    ,ComArea
    ,ResArea
    ,OfficeArea
    ,RetailArea
    ,GarageArea
    ,StrgeArea
    ,FactryArea
    ,OtherArea
    ,AreaSource
    ,NumBldgs
    ,NumFloors
    ,UnitsRes
    ,UnitsTotal
    ,LotFront
    ,LotDepth
    ,BldgFront
    ,BldgDepth
    ,ProxCode
    ,IrrLotCode
    ,LotType
    ,BsmtCode
    ,AssessLand
    ,AssessTotal
    ,ExemptLand
    ,ExemptTotal
    ,YearBuilt
    ,BuiltCode
    ,YearAlter1
    ,YearAlter2
    ,HistDist
    ,Landmark
    ,BuiltFAR
    ,MaxAllwFAR
    ,BoroCode
    ,CONCAT(BoroCode, Block, Lot) as BBL
    ,Tract2000
    ,XCoord
    ,YCoord
    ,ZoneMap
    ,Sanborn
    ,TaxMap
    ,EDesigNum
    ,RPADDate
    ,DCASDate
    ,DOBDate
    ,ZoningDate
    ,MajPrpDate
    ,LandmkDate
    ,BaseMpDate
    ,MASDate
    ,PoliDate
    ,PLUTOMapID
FROM pluto2004_temp;

DROP TABLE pluto2004_temp;

UPDATE pluto2004
SET BBL = num.BBL FROM 
(SELECT TRANSLATE (BBL,' ','0') as BBL FROM pluto2004) as num;


ALTER TABLE pluto2004
ALTER COLUMN BBL SET DATA TYPE NUMERIC
USING BBL::NUMERIC;

