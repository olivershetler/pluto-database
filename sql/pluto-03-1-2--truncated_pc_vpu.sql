

---  99.87% of cases are inside the boundaries as given

SELECT SUM(CASE WHEN pcvpu < 3 OR pcvpu > -0.75 THEN 1 ELSE 0 END)/COUNT(*)::NUMERIC alpha_percent FROM pc_vpu;


--- 81% of the values in the alpha region are unique, showing that most—if not all of these are likely due to construction
SELECT COUNT(DISTINCT(BBL))/COUNT(*)::NUMERIC as percent_unique  FROM pc_vpu_sym_long WHERE pcvpu > .662 OR pcvpu < -0.662;

--- we use 

DROP TABLE pc_vpu_trunc;
CREATE TABLE pc_vpu_trunc (
    bbl        NUMERIC   NOT NULL
    ,block     NUMERIC   NOT NULL
    ,zipcode   VARCHAR   NOT NULL
    ,year      NUMERIC   NOT NULL
    ,pcvpu     NUMERIC
    ,PRIMARY KEY (bbl, year)
);

INSERT INTO pc_vpu_trunc (bbl, block, zipcode, year, pcvpu)
SELECT bbl::NUMERIC, block::NUMERIC, zipcode, year::NUMERIC, pcvpu::NUMERIC
FROM pc_vpu
WHERE pcvpu < 3 AND pcvpu > -0.75;

\copy pc_vpu_trunc TO '/home/oliver/data/pluto/pc_vpu_trunc.csv' CSV HEADER;





