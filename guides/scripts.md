# Script Guide

There are 15 SQL files. Below each file name, there is a brief explanation of what the script does. Refer to the script files themselves for more details.

Note that 
- "pc" stands for "percent change"
- "vpu" stands for "value per unit"
- "pcvpu" stands for "percent change in value per unit"

## `pluto-01--import-files.sql`

This file contains a script for importing each of the PLUTO CSV files. Some of the files required cleaning before import. Non-UTF characters prevented some files from being imported, so regular expressions were used to find and replace the unrecognizable characters in the vim text editor. The cleaned files up to 2022 are hosted in a public pcloud folder here:

> [add web address]

The script uses COPY commands of the form

```sql
COPY pluto2021 FROM '/home/oliver/data/pluto/<FILE_NAME>.csv' DELIMITER ',' CSV HEADER;
```

If you want to reproduce the data set from the beginning, use find and replace to substitute `/home/oliver/data/pluto/` for the path to your raw data.

## `pluto-02-1--building-features.sql`

This file contains a script for creating the features for the building dataset. You can find more information on how the variables were re-coded in the associated article.

## `pluto-02-2--zip-level-attributes.sql`

This script creates a table whose primary key is the conjunction of zipcode and year. There are two kinds of zipcode level attributes associated with each record. First, there are mutually inclusive continuous features, such as the average age of buildings in the zipcode, etc. Second, there are proportions of different building types in the zipcode.

## `pluto-02-3--bbl-and-zip-level-features.sql`

This script merges the zip-level features  with the BBL level features computed in the previous two scripts. The table this script generates has the primary key of BBL + zipcode + year. It assigns each BBL + year pair the zip-level attributes associated with the zipcode in which it is located. This table can provide information 

## `pluto-03-1-1--pc_value_per_unit.sql`

This script produces a table whose primary key is the BBL + year. It contains the percent change in value per unit for each building in the dataset. **Note that these values are only computed for residential buildings.** This is because annual property values are not closely monitored or annually re-computed for other kinds of properties.

## `pluto-03-1-2--truncated_pc_vpu.sql`

This script produces a table whose primary key is the BBL + year. It contains the percent change in value per unit for each building in the dataset, truncated so that annual percent changes exceeding 300% or below -75% (3x changes) were dropped from the data set. Values exceeding the 3x change criterion are from new construction. They are dropped so that models predicting changes the values of existing properties can be trained.

## `pluto-03-2-1--block-distances.sql`

This script produces a table that computes the euclidean distances between apartment blocks. Its result feeds into the next script. The primary key is block pairs.

## `pluto-03-2-2--block-neighbors.sql`

This script produces a table with block IDs as the primary key, and the IDs of the four nearest neighbor blocks as the values. It is used to allow for geo-spatial modeling.


## `pluto-03-2-3--pcvpu-for-block-neighbors`

This script computes the average percent change in value per unit for each residential block, and then assigns the corresponding average percent change to the four nearest neighbor blocks for each block. The primary key is block ID.

## `pluto-03-2-4--lagged-pcvpu-for-block-neighbors.sql`

This script produces a view with 3 years of lagged percent change in value per unit for each residential block, and for each of the four nearest neighbors. It feeds into `pluto-03-4--lagged-pcvpu-for-block-neighbors.sql`.

## `pluto-03-3--lagged-zipcode-pcvpu.sql`

This script computes the average percent change in value per unit for each zipcode per year and then concatinates three years of lagged data. The primary key is zipcode + year.

## `pluto-03-4--lagged-bbl-zip-and-block-pcvpu.sql`

This script computes lagged percent change in value per unit for each BBL, and then merges it with the lagged percent change in value per unit for each zipcode and each, each block (and the 4 nearest neighbors). The primary key is BBL + year + block + zipcode.

## `pluto-04-1--panel-data-pc_vpu.sql`

This script generates a table that joins all the BBL attributes, zipcode level attributes, and percent change in value per unit (pcvpu) attributes. The primary key is BBL + year.

## `pluto-04-2--panel-data-symmetrized.sql`

This script generates a version of the previous table, except all the percent change in value per unit (pcvpu) attributes are symmetrized so that, for example, -50% becomes -200%. which is equivalent in magnitute to +200%.

## `pluto-04-3--discrete-panel-data.sql`

This script generates a version of the previous table, except all the pcvpu attributes are replaced with discrete values as follows:
- values less than or equal to 0 are replaced with 0
- values between 0% and 5% are replaced with 1
- values between 5% and 10% are replaced with 2
- values greater than 10% are replaced with 3
