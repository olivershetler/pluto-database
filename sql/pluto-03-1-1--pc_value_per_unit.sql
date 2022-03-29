-- 1. creates a table the percent change

DROP CASCADE TABLE pc_vpu;

CREATE TABLE pc_vpu (
      bbl        NUMERIC   NOT NULL
      ,block     VARCHAR   NOT NULL
      ,zipcode   VARCHAR   NOT NULL
      ,year      INTEGER   NOT NULL
      ,pcvpu     NUMERIC
      ,PRIMARY KEY (bbl, year)
);

---- make others reflect changes to this one
INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(pluto2021.bbl, 0)
      ,pluto2020.block
      ,pluto2020.zipcode
      ,2020
      ,(CASE WHEN pluto2021.UnitsTotal > 0 AND pluto2021.assesstot > 0 AND pluto2020.UnitsTotal > 0 AND pluto2020.assesstot > 0 THEN 
       ROUND(((pluto2021.assesstot/pluto2021.UnitsTotal) - (pluto2020.assesstot/pluto2020.UnitsTotal))/(pluto2020.assesstot/pluto2020.UnitsTotal), 6)
       ELSE NULL END)
FROM pluto2021 INNER JOIN pluto2020
ON pluto2021.bbl=pluto2020.bbl
WHERE (pluto2020.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (pluto2020.bldgclass LIKE 'S9' AND pluto2020.UnitsRes >= 3) )
      AND pluto2020.zipcode IS NOT NULL 
      AND pluto2020.block IS NOT NULL 
      AND pluto2021.bbl IS NOT NULL
ORDER BY pluto2021.bbl ASC;
----


INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2020.bbl, 0)
      ,p2019.block
      ,p2019.zipcode
      ,2019
      ,(CASE WHEN p2020.UnitsTotal > 0 AND p2020.assesstot > 0 AND p2019.UnitsTotal > 0 AND p2019.assesstot > 0 THEN 
       ROUND(((p2020.assesstot/p2020.UnitsTotal) - (p2019.assesstot/p2019.UnitsTotal))/(p2019.assesstot/p2019.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2020 ON p2021.id = pluto2020.bbl) as p2020
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2019 ON p2021.id = pluto2019.bbl) as p2019
ON p2020.bbl=p2019.bbl
WHERE (p2019.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2019.bldgclass LIKE 'S9' AND p2019.UnitsRes >= 3) )
      AND p2019.zipcode IS NOT NULL 
      AND p2019.block IS NOT NULL 
      AND p2020.bbl IS NOT NULL
ORDER BY p2020.bbl ASC;


INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2019.bbl, 0)
      ,p2018.block
      ,p2018.zipcode
      ,2018
      ,(CASE WHEN p2019.UnitsTotal > 0 AND p2019.assesstot > 0 AND p2018.UnitsTotal > 0 AND p2018.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2019.assesstot/p2019.UnitsTotal) - (p2018.assesstot*(1/0.45)/p2018.UnitsTotal))/(p2018.assesstot*(1/0.45)/p2018.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2019 ON p2021.id = pluto2019.bbl) as p2019
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2018 ON p2021.id = pluto2018.bbl) as p2018
ON p2019.bbl=p2018.bbl
WHERE (p2018.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2018.bldgclass LIKE 'S9' AND p2018.UnitsRes >= 3) )
      AND p2018.zipcode IS NOT NULL 
      AND p2018.block IS NOT NULL 
      AND p2019.bbl IS NOT NULL
ORDER BY p2019.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2018.bbl, 0)
      ,p2017.block
      ,p2017.zipcode
      ,2017
      ,(CASE WHEN p2018.UnitsTotal > 0 AND p2018.assesstot*(1/0.45) > 0 AND p2017.UnitsTotal > 0 AND p2017.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2018.assesstot*(1/0.45)/p2018.UnitsTotal) - (p2017.assesstot*(1/0.45)/p2017.UnitsTotal))/(p2017.assesstot*(1/0.45)/p2017.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2018 ON p2021.id = pluto2018.bbl) as p2018
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2017 ON p2021.id = pluto2017.bbl) as p2017
ON p2018.bbl=p2017.bbl
WHERE (p2017.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2017.bldgclass LIKE 'S9' AND p2017.UnitsRes >= 3) )
      AND p2017.zipcode IS NOT NULL 
      AND p2017.block IS NOT NULL 
      AND p2018.bbl IS NOT NULL
ORDER BY p2018.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2017.bbl, 0)
      ,p2016.block
      ,p2016.zipcode
      ,2016
      ,(CASE WHEN p2017.UnitsTotal > 0 AND p2017.assesstot*(1/0.45) > 0 AND p2016.UnitsTotal > 0 AND p2016.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2017.assesstot*(1/0.45)/p2017.UnitsTotal) - (p2016.assesstot*(1/0.45)/p2016.UnitsTotal))/(p2016.assesstot*(1/0.45)/p2016.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2017 ON p2021.id = pluto2017.bbl) as p2017
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2016 ON p2021.id = pluto2016.bbl) as p2016
ON p2017.bbl=p2016.bbl
WHERE (p2016.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2016.bldgclass LIKE 'S9' AND p2016.UnitsRes >= 3) )
      AND p2016.zipcode IS NOT NULL 
      AND p2016.block IS NOT NULL 
      AND p2017.bbl IS NOT NULL
ORDER BY p2017.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2016.bbl, 0)
      ,p2015.block
      ,p2015.zipcode
      ,2015
      ,(CASE WHEN p2016.UnitsTotal > 0 AND p2016.assesstot*(1/0.45) > 0 AND p2015.UnitsTotal > 0 AND p2015.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2016.assesstot*(1/0.45)/p2016.UnitsTotal) - (p2015.assesstot*(1/0.45)/p2015.UnitsTotal))/(p2015.assesstot*(1/0.45)/p2015.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2016 ON p2021.id = pluto2016.bbl) as p2016
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2015 ON p2021.id = pluto2015.bbl) as p2015
ON p2016.bbl=p2015.bbl
WHERE (p2015.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2015.bldgclass LIKE 'S9' AND p2015.UnitsRes >= 3) )
      AND p2015.zipcode IS NOT NULL 
      AND p2015.block IS NOT NULL 
      AND p2016.bbl IS NOT NULL
ORDER BY p2016.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2015.bbl, 0)
      ,p2014.block
      ,p2014.zipcode
      ,2014
      ,(CASE WHEN p2015.UnitsTotal > 0 AND p2015.assesstot*(1/0.45) > 0 AND p2014.UnitsTotal > 0 AND p2014.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2015.assesstot*(1/0.45)/p2015.UnitsTotal) - (p2014.assesstot*(1/0.45)/p2014.UnitsTotal))/(p2014.assesstot*(1/0.45)/p2014.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2015 ON p2021.id = pluto2015.bbl) as p2015
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2014 ON p2021.id = pluto2014.bbl) as p2014
ON p2015.bbl=p2014.bbl
WHERE (p2014.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2014.bldgclass LIKE 'S9' AND p2014.UnitsRes >= 3) )
      AND p2014.zipcode IS NOT NULL 
      AND p2014.block IS NOT NULL 
      AND p2015.bbl IS NOT NULL
ORDER BY p2015.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2014.bbl, 0)
      ,p2013.block
      ,p2013.zipcode
      ,2013
      ,(CASE WHEN p2014.UnitsTotal > 0 AND p2014.assesstot*(1/0.45) > 0 AND p2013.UnitsTotal > 0 AND p2013.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2014.assesstot*(1/0.45)/p2014.UnitsTotal) - (p2013.assesstot*(1/0.45)/p2013.UnitsTotal))/(p2013.assesstot*(1/0.45)/p2013.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2014 ON p2021.id = pluto2014.bbl) as p2014
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2013 ON p2021.id = pluto2013.bbl) as p2013
ON p2014.bbl=p2013.bbl
WHERE (p2013.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2013.bldgclass LIKE 'S9' AND p2013.UnitsRes >= 3) )
      AND p2013.zipcode IS NOT NULL 
      AND p2013.block IS NOT NULL 
      AND p2014.bbl IS NOT NULL
ORDER BY p2014.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2013.bbl, 0)
      ,p2012.block
      ,p2012.zipcode
      ,2012
      ,(CASE WHEN p2013.UnitsTotal > 0 AND p2013.assesstot*(1/0.45) > 0 AND p2012.UnitsTotal > 0 AND p2012.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2013.assesstot*(1/0.45)/p2013.UnitsTotal) - (p2012.assesstot*(1/0.45)/p2012.UnitsTotal))/(p2012.assesstot*(1/0.45)/p2012.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2013 ON p2021.id = pluto2013.bbl) as p2013
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2012 ON p2021.id = pluto2012.bbl) as p2012
ON p2013.bbl=p2012.bbl
WHERE (p2012.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2012.bldgclass LIKE 'S9' AND p2012.UnitsRes >= 3) )
      AND p2012.zipcode IS NOT NULL 
      AND p2012.block IS NOT NULL 
      AND p2013.bbl IS NOT NULL
ORDER BY p2013.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2012.bbl, 0)
      ,p2011.block
      ,p2011.zipcode
      ,2011
      ,(CASE WHEN p2012.UnitsTotal > 0 AND p2012.assesstot*(1/0.45) > 0 AND p2011.UnitsTotal::NUMERIC > 0 AND p2011.assesstot*(1/0.45)::NUMERIC > 0 THEN 
       ROUND(((p2012.assesstot*(1/0.45)/p2012.UnitsTotal) - (p2011.assesstot*(1/0.45)::NUMERIC/p2011.UnitsTotal::NUMERIC))/(p2011.assesstot*(1/0.45)::NUMERIC/p2011.UnitsTotal::NUMERIC*(1/0.45)), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2012 ON p2021.id = pluto2012.bbl) as p2012
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2011 ON p2021.id = pluto2011.bbl) as p2011
ON p2012.bbl=p2011.bbl
WHERE (p2011.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2011.bldgclass LIKE 'S9' AND p2011.UnitsRes::NUMERIC >= 3) )
      AND p2011.zipcode IS NOT NULL 
      AND p2011.block IS NOT NULL 
      AND p2012.bbl IS NOT NULL
ORDER BY p2012.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2011.bbl, 0)
      ,p2010.block
      ,p2010.zipcode
      ,2010
      ,(CASE WHEN p2011.UnitsTotal::NUMERIC > 0 AND p2011.assesstot*(1/0.45)::NUMERIC > 0 AND p2010.UnitsTotal > 0 AND p2010.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2011.assesstot*(1/0.45)::NUMERIC/p2011.UnitsTotal::NUMERIC) - (p2010.assesstot*(1/0.45)/p2010.UnitsTotal))/(p2010.assesstot*(1/0.45)/p2010.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2011 ON p2021.id = pluto2011.bbl) as p2011
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2010 ON p2021.id = pluto2010.bbl) as p2010
ON p2011.bbl=p2010.bbl
WHERE (p2010.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2010.bldgclass LIKE 'S9' AND p2010.UnitsRes >= 3) )
      AND p2010.zipcode IS NOT NULL 
      AND p2010.block IS NOT NULL 
      AND p2011.bbl IS NOT NULL
ORDER BY p2011.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2010.bbl, 0)
      ,p2009.block
      ,p2009.zipcode
      ,2009
      ,(CASE WHEN p2010.UnitsTotal > 0 AND p2010.assesstot*(1/0.45) > 0 AND p2009.UnitsTotal > 0 AND p2009.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2010.assesstot*(1/0.45)/p2010.UnitsTotal) - (p2009.assesstot*(1/0.45)/p2009.UnitsTotal))/(p2009.assesstot*(1/0.45)/p2009.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2010 ON p2021.id = pluto2010.bbl) as p2010
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2009 ON p2021.id = pluto2009.bbl) as p2009
ON p2010.bbl=p2009.bbl
WHERE (p2009.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2009.bldgclass LIKE 'S9' AND p2009.UnitsRes >= 3) )
      AND p2009.zipcode IS NOT NULL 
      AND p2009.block IS NOT NULL 
      AND p2010.bbl IS NOT NULL
ORDER BY p2010.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2009.bbl, 0)
      ,p2008.block
      ,p2008.zipcode
      ,2008
      ,(CASE WHEN p2009.UnitsTotal > 0 AND p2009.assesstot*(1/0.45) > 0 AND p2008.UnitsTotal > 0 AND p2008.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2009.assesstot*(1/0.45)/p2009.UnitsTotal) - (p2008.assesstot*(1/0.45)/p2008.UnitsTotal))/(p2008.assesstot*(1/0.45)/p2008.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2009 ON p2021.id = pluto2009.bbl) as p2009
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2008 ON p2021.id = pluto2008.bbl) as p2008
ON p2009.bbl=p2008.bbl
WHERE (p2008.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2008.bldgclass LIKE 'S9' AND p2008.UnitsRes >= 3) )
      AND p2008.zipcode IS NOT NULL 
      AND p2008.block IS NOT NULL 
      AND p2009.bbl IS NOT NULL
ORDER BY p2009.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2008.bbl, 0)
      ,p2007.block
      ,p2007.zipcode
      ,2007
      ,(CASE WHEN p2008.UnitsTotal > 0 AND p2008.assesstot*(1/0.45) > 0 AND p2007.UnitsTotal > 0 AND p2007.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2008.assesstot*(1/0.45)/p2008.UnitsTotal) - (p2007.assesstot*(1/0.45)/p2007.UnitsTotal))/(p2007.assesstot*(1/0.45)/p2007.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2008 ON p2021.id = pluto2008.bbl) as p2008
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2007 ON p2021.id = pluto2007.bbl) as p2007
ON p2008.bbl=p2007.bbl
WHERE (p2007.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2007.bldgclass LIKE 'S9' AND p2007.UnitsRes >= 3) )
      AND p2007.zipcode IS NOT NULL 
      AND p2007.block IS NOT NULL 
      AND p2008.bbl IS NOT NULL
ORDER BY p2008.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2007.bbl, 0)
      ,p2006.block
      ,p2006.zipcode
      ,2006
      ,(CASE WHEN p2007.UnitsTotal > 0 AND p2007.assesstot*(1/0.45) > 0 AND p2006.UnitsTotal > 0 AND p2006.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2007.assesstot*(1/0.45)/p2007.UnitsTotal) - (p2006.assesstot*(1/0.45)/p2006.UnitsTotal))/(p2006.assesstot*(1/0.45)/p2006.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2007 ON p2021.id = pluto2007.bbl) as p2007
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2006 ON p2021.id = pluto2006.bbl) as p2006
ON p2007.bbl=p2006.bbl
WHERE (p2006.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2006.bldgclass LIKE 'S9' AND p2006.UnitsRes >= 3) )
      AND p2006.zipcode IS NOT NULL 
      AND p2006.block IS NOT NULL 
      AND p2007.bbl IS NOT NULL
ORDER BY p2007.bbl ASC;



INSERT INTO pc_vpu (bbl, block, zipcode, year, pcvpu)
SELECT ROUND(p2006.bbl, 0)
      ,p2005.block
      ,p2005.zipcode
      ,2005
      ,(CASE WHEN p2006.UnitsTotal > 0 AND p2006.assesstot*(1/0.45) > 0 AND p2005.UnitsTotal > 0 AND p2005.assesstot*(1/0.45) > 0 THEN 
       ROUND(((p2006.assesstot*(1/0.45)/p2006.UnitsTotal) - (p2005.assesstot*(1/0.45)/p2005.UnitsTotal))/(p2005.assesstot*(1/0.45)/p2005.UnitsTotal), 6)
       ELSE NULL END)
FROM
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2006 ON p2021.id = pluto2006.bbl) as p2006
INNER JOIN 
((SELECT bbl as id FROM pluto2021) as p2021 LEFT JOIN pluto2005 ON p2021.id = pluto2005.bbl) as p2005
ON p2006.bbl=p2005.bbl
WHERE (p2005.bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
      OR (p2005.bldgclass LIKE 'S9' AND p2005.UnitsRes >= 3) )
      AND p2005.zipcode IS NOT NULL 
      AND p2005.block IS NOT NULL 
      AND p2006.bbl IS NOT NULL
ORDER BY p2006.bbl ASC;


----


SELECT * FROM pc_vpu LIMIT 10;




----- make lagged data
SELECT bbl, year, L3, L2, L1, y
FROM 
(SELECT bbl, year, pcvpu as y FROM pc_vpu WHERE year=2020)
LEFT JOIN
(SELECT bbl as bbl1, year-1 as LY1, pcvpu as L1)
ON 

---- get regression coefficients up to a given year

SELECT 
      bbl
      ,ROUND(regr_slope(pcvpu, year-2005)::NUMERIC, 6) as slope
      ,ROUND(regr_intercept(pcvpu, year-2005)::NUMERIC, 6) as intercept
      ,ROUND(regr_r2(pcvpu, year-2005)::NUMERIC, 6) as r2
      ,ROUND(avg(pcvpu)::NUMERIC, 6) as avg_pcvpu
FROM pc_vpu
WHERE pcvpu < 3
AND pcvpu > -0.55
GROUP BY bbl
ORDER BY bbl
LIMIT 10;

---- take r2 * slope as summary of trend

SELECT 
      bbl
      ,ROUND(regr_slope(pcvpu, year-2005)::NUMERIC, 6) as slope
      ,ROUND(regr_slope(pcvpu, year-2005)::NUMERIC * regr_r2(pcvpu, year-2005)::NUMERIC * COUNT(bbl)::NUMERIC/(2020-2005) * 100 , 6) as trend
      ,ROUND(avg(pcvpu)::NUMERIC, 6) as avg_pcvpu
      ,ROUND(COUNT(bbl)::NUMERIC/(2020-2005), 2) as completeness
FROM pc_vpu
WHERE pcvpu < 1
AND pcvpu > -0.75
AND year <=2020
GROUP BY bbl
ORDER BY bbl
LIMIT 10;



