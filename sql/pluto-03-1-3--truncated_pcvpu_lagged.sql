DROP TABLE pc_vpu_lagged;
CREATE TABLE pc_vpu_lagged (
    year            NUMERIC NOT NULL
    ,bbl            NUMERIC NOT NULL
    ,block          NUMERIC NOT NULL
    ,zipcode        VARCHAR
    ,pcvpu_target   NUMERIC
    ,pcvpu_L1       NUMERIC
    ,pcvpu_L2       NUMERIC
    ,pcvpu_L3       NUMERIC
    ,PRIMARY KEY (bbl, year)
);


INSERT INTO pc_vpu_lagged (year, bbl, block, zipcode, pcvpu_target, pcvpu_L1, pcvpu_L2, pcvpu_L3)
SELECT 
    year::NUMERIC
    ,bbl::NUMERIC
    ,block
    ,zipcode
    ,pcvpu_target::NUMERIC
    ,pcvpu_L1
    ,pcvpu_L2
    ,pcvpu_L3
FROM 
(
        (
            (SELECT bbl
                   ,block
                   ,zipcode
                   ,year
                   ,pcvpu as pcvpu_target
            FROM
            pc_vpu_trunc) as vpu_t
            INNER JOIN
            (SELECT bbl as bbl_L1
                    ,year as year_L1
                    ,pcvpu as pcvpu_L1
            FROM
            pc_vpu_trunc) as vpu_L1
            ON bbl = bbl_L1 AND year = year_L1 + 1
        )
    INNER JOIN
    (SELECT bbl as bbl_L2
            ,year as year_L2
            ,pcvpu as pcvpu_L2
    FROM
    pc_vpu_trunc) as vpu_L2
    ON bbl = bbl_L2 AND year = year_L2 + 2
)
INNER JOIN
(SELECT bbl as bbl_L3
        ,year as year_L3
        ,pcvpu as pcvpu_L3
FROM
pc_vpu_trunc) as vpu_L3
ON bbl = bbl_L3 AND year = year_L3 + 3
ORDER BY bbl, year;