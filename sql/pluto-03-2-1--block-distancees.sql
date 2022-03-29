
CREATE TABLE block_distance (
    block1        NUMERIC
    ,block2       NUMERIC
    ,distance     NUMERIC
    ,PRIMARY KEY (block1, block2)
);

INSERT INTO block_distance (block1, block2, distance)
SELECT 
    p1.block::NUMERIC
    ,p2.block::NUMERIC
    ,sqrt((p1.xcoord-p2.xcoord)^2 + (p1.ycoord - p2.ycoord)^2)::NUMERIC
FROM 
        (SELECT 
            block
            ,AVG(xcoord) as xcoord
            ,AVG(ycoord) as ycoord 
        FROM pluto2021 
        WHERE bldgclass LIKE ANY(ARRAY['C%','D%','S3','S4','S5'])
        GROUP BY block 
        ORDER BY block) p1 
    CROSS JOIN 
        (SELECT 
            block
            ,AVG(xcoord) as xcoord
            ,AVG(ycoord) as ycoord 
        FROM pluto2021 
        WHERE bldgclass 
        LIKE ANY(ARRAY['C%','D%','S3','S4','S5']) 
        GROUP BY block 
        ORDER BY block) p2;



