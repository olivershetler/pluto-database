
DROP TABLE zip_pc_vpu;
CREATE TABLE zip_pc_vpu
(    year           NUMERIC NOT NULL
    ,zipcode        VARCHAR NOT NULL
    ,avg_pcvpu      NUMERIC NOT NULL
    ,PRIMARY KEY (zipcode, year));

INSERT INTO zip_pc_vpu (year, zipcode, avg_pcvpu)
SELECT year, zipcode, AVG(pcvpu)
FROM pc_vpu
WHERE zipcode IS NOT NULL
GROUP BY zipcode, year;


DROP TABLE zip_pc_vpu_lagged;
CREATE TABLE zip_pc_vpu_lagged (
    year                    NUMERIC NOT NULL
    ,zipcode                VARCHAR NOT NULL
    ,avg_zip_pcvpu_L1       NUMERIC
    ,avg_zip_pcvpu_L2       NUMERIC
    ,avg_zip_pcvpu_L3       NUMERIC
    ,PRIMARY KEY (zipcode, year)
);


INSERT INTO zip_pc_vpu_lagged (year, zipcode, avg_zip_pcvpu_L1, avg_zip_pcvpu_L2, avg_zip_pcvpu_L3)
SELECT 
    year::NUMERIC
    ,zipcode
    ,avg_zip_pcvpu_L1
    ,avg_zip_pcvpu_L2
    ,avg_zip_pcvpu_L3
FROM 
(
        (
            (SELECT zipcode
                   ,year
            FROM
            zip_pc_vpu) as zip_vpu_t
            INNER JOIN
            (SELECT zipcode as zipcode_L1
                    ,year as year_L1
                    ,avg_pcvpu as avg_zip_pcvpu_L1
            FROM
            zip_pc_vpu) as vpu_L1
            ON zipcode = zipcode_L1 AND year = year_L1 + 1
        )
    INNER JOIN
    (SELECT zipcode as zipcode_L2
            ,year as year_L2
            ,avg_pcvpu as avg_zip_pcvpu_L2
    FROM
    zip_pc_vpu) as vpu_L2
    ON zipcode = zipcode_L2 AND year = year_L2 + 2
)
INNER JOIN
(SELECT zipcode as zipcode_L3
        ,year as year_L3
        ,avg_pcvpu as avg_zip_pcvpu_L3
FROM
zip_pc_vpu) as vpu_L3
ON zipcode = zipcode_L3 AND year = year_L3 + 3
ORDER BY zipcode, year;



