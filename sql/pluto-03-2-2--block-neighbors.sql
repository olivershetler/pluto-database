CREATE TABLE block_neighbors1 (
    block           VARCHAR PRIMARY KEY
    ,neighbor1      VARCHAR
);

INSERT INTO block_neighbors1 (block, neighbor1)
SELECT bd.block1, bd.block2
FROM block_distance bd INNER JOIN 
(SELECT 
    block1
    ,(array_agg(distance ORDER BY distance ASC))[2] as dist
FROM block_distance GROUP BY block1) as near
ON bd.block1 = near.block1 AND bd.distance = near.dist
ORDER BY bd.block1;

SELECT * FROM block_neighbors1 LIMIT 10;




CREATE TABLE block_neighbors2 (
    block           VARCHAR PRIMARY KEY
    ,neighbor2      VARCHAR
);

INSERT INTO block_neighbors2 (block, neighbor2)
SELECT bd.block1, bd.block2
FROM block_distance bd INNER JOIN 
(SELECT 
    block1
    ,(array_agg(distance ORDER BY distance ASC))[3] as dist
FROM block_distance GROUP BY block1) as near
ON bd.block1 = near.block1 AND bd.distance = near.dist
ORDER BY bd.block1;


SELECT * FROM block_neighbors2 LIMIT 10;



CREATE TABLE block_neighbors3 (
    block           VARCHAR PRIMARY KEY
    ,neighbor3      VARCHAR
);

INSERT INTO block_neighbors3 (block, neighbor3)
SELECT bd.block1, bd.block2
FROM block_distance bd INNER JOIN 
(SELECT 
    block1
    ,(array_agg(distance ORDER BY distance ASC))[4] as dist
FROM block_distance GROUP BY block1) as near
ON bd.block1 = near.block1 AND bd.distance = near.dist
ORDER BY bd.block1;


SELECT * FROM block_neighbors3 LIMIT 10;



CREATE TABLE block_neighbors4 (
    block           VARCHAR PRIMARY KEY
    ,neighbor4      VARCHAR
);

INSERT INTO block_neighbors4 (block, neighbor4)
SELECT bd.block1, bd.block2
FROM block_distance bd INNER JOIN 
(SELECT 
    block1
    ,(array_agg(distance ORDER BY distance ASC))[5] as dist
FROM block_distance GROUP BY block1) as near
ON bd.block1 = near.block1 AND bd.distance = near.dist
ORDER BY bd.block1;


SELECT * FROM block_neighbors4 LIMIT 10;




CREATE TABLE block_neighbors (
    block       NUMERIC PRIMARY KEY
    ,neighbor1  NUMERIC
    ,neighbor2  NUMERIC
    ,neighbor3  NUMERIC
    ,neighbor4  NUMERIC
)

SELECT n1.block, neighbor1::NUMERIC, neighbor2::NUMERIC, neighbor3::NUMERIC, neighbor4::NUMERIC
FROM
block_neighbors1 n1
JOIN
block_neighbors2 n2
ON n1.block = n2.block
JOIN
block_neighbors3 n3
ON n1.block = n3.block
JOIN
block_neighbors4 n4
ON n1.block = n4.block;



SELECT 
    block1
    ,MIN(distance)
    ,(array_agg(distance ORDER BY distance ASC))[2] as d2
    ,(array_agg(distance ORDER BY distance ASC))[3] as d3
    ,(array_agg(distance ORDER BY distance ASC))[4] as d3
FROM block_distance GROUP BY block1;


