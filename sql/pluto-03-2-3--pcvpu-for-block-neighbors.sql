


CREATE OR REPLACE VIEW avg_pc_vpu_block
AS
SELECT  block::NUMERIC, year, AVG(pcvpu) as avg_pcvpu 
FROM pc_vpu -- we use the un-truncated pcvpu because we want the construction signal at the block level
GROUP BY block, year
ORDER BY block, year;


CREATE OR REPLACE VIEW block_neighbors
AS
SELECT n1.block::NUMERIC, neighbor1::NUMERIC, neighbor2::NUMERIC, neighbor3::NUMERIC, neighbor4::NUMERIC
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


CREATE TABLE nearest_block_neighbors_avg_pcvpu (
    year                    NUMERIC NOT NULL
    ,block                  NUMERIC NOT NULL
    ,avg_block_pcvpu        NUMERIC
    ,neighbor1              NUMERIC
    ,avg_neighbor1_pcvpu    NUMERIC
    ,neighbor2              NUMERIC
    ,avg_neighbor2_pcvpu    NUMERIC
    ,neighbor3              NUMERIC
    ,avg_neighbor3_pcvpu    NUMERIC
    ,neighbor4              NUMERIC
    ,avg_neighbor4_pcvpu    NUMERIC
    ,PRIMARY KEY (year,block)
);


INSERT INTO nearest_block_neighbors_avg_pcvpu
    (
    year
    ,block
    ,avg_block_pcvpu
    ,neighbor1
    ,avg_neighbor1_pcvpu
    ,neighbor2
    ,avg_neighbor2_pcvpu
    ,neighbor3
    ,avg_neighbor3_pcvpu
    ,neighbor4
    ,avg_neighbor4_pcvpu
    )

SELECT  bn4.year::NUMERIC
        ,bn4.block::NUMERIC
        ,avg_pcvpu0::NUMERIC
        ,neighbor1::NUMERIC
        ,avg_pcvpu1::NUMERIC
        ,neighbor2::NUMERIC
        ,avg_pcvpu2::NUMERIC
        ,neighbor3::NUMERIC
        ,avg_pcvpu3::NUMERIC
        ,neighbor4::NUMERIC
        ,vpu4.avg_pcvpu::NUMERIC as avg_pcvpu4
FROM
( SELECT bn3.year, year1, year2, vpu3.year as year3, bn3.block, neighbor1, neighbor2, neighbor3, neighbor4, avg_pcvpu0, vpu1_block, avg_pcvpu1, vpu2_block, avg_pcvpu2,
    vpu3.block as vpu3_block, vpu3.avg_pcvpu as avg_pcvpu3
    FROM
( SELECT bn2.year, year1, vpu2.year as year2, bn2.block, neighbor1, neighbor2, neighbor3, neighbor4, avg_pcvpu0, vpu1_block, avg_pcvpu1,
    vpu2.block as vpu2_block, vpu2.avg_pcvpu as avg_pcvpu2
    FROM
( SELECT bn1.year, vpu1.year as year1, bn1.block, neighbor1, neighbor2, neighbor3, neighbor4, avg_pcvpu0, vpu1.block as vpu1_block, vpu1.avg_pcvpu as avg_pcvpu1
    FROM
( SELECT vpu0.year, bn.block, neighbor1, neighbor2, neighbor3, neighbor4, vpu0.avg_pcvpu as avg_pcvpu0
    FROM
block_neighbors bn 
JOIN avg_pc_vpu_block vpu0
ON bn.block::NUMERIC = vpu0.block::NUMERIC
) bn1
JOIN avg_pc_vpu_block vpu1
ON bn1.neighbor1::NUMERIC = vpu1.block::NUMERIC AND bn1.year = vpu1.year
) bn2
JOIN avg_pc_vpu_block vpu2
ON bn2.neighbor2::NUMERIC = vpu2.block::NUMERIC AND bn2.year = vpu2.year
) bn3
JOIN avg_pc_vpu_block vpu3
ON bn3.neighbor3::NUMERIC = vpu3.block::NUMERIC AND bn3.year = vpu3.year
) bn4
JOIN avg_pc_vpu_block vpu4
ON bn4.neighbor4::NUMERIC = vpu4.block::NUMERIC AND bn4.year = vpu4.year
ORDER BY bn4.block, bn4.year;




--- test version for verifying everything lines up

SELECT bn4.year, year1, year2, year3, vpu4.year as year4, bn4.block, neighbor1, neighbor2, neighbor3, neighbor4, ROUND(avg_pcvpu0,2), 
    vpu1_block, ROUND(avg_pcvpu1,2), vpu2_block, ROUND(avg_pcvpu2,2),
    vpu3_block, ROUND(avg_pcvpu3,2), vpu4.block as vpu4_block, ROUND(vpu4.avg_pcvpu,2) as avg_pcvpu4
FROM
( SELECT bn3.year, year1, year2, vpu3.year as year3, bn3.block, neighbor1, neighbor2, neighbor3, neighbor4, avg_pcvpu0, vpu1_block, avg_pcvpu1, vpu2_block, avg_pcvpu2,
    vpu3.block as vpu3_block, vpu3.avg_pcvpu as avg_pcvpu3
    FROM
( SELECT bn2.year, year1, vpu2.year as year2, bn2.block, neighbor1, neighbor2, neighbor3, neighbor4, avg_pcvpu0, vpu1_block, avg_pcvpu1,
    vpu2.block as vpu2_block, vpu2.avg_pcvpu as avg_pcvpu2
    FROM
( SELECT bn1.year, vpu1.year as year1, bn1.block, neighbor1, neighbor2, neighbor3, neighbor4, avg_pcvpu0, vpu1.block as vpu1_block, vpu1.avg_pcvpu as avg_pcvpu1
    FROM
( SELECT vpu0.year, bn.block, neighbor1, neighbor2, neighbor3, neighbor4, vpu0.avg_pcvpu as avg_pcvpu0
    FROM
block_neighbors bn 
JOIN avg_pc_vpu_block vpu0
ON bn.block::NUMERIC = vpu0.block::NUMERIC
) bn1
JOIN avg_pc_vpu_block vpu1
ON bn1.neighbor1::NUMERIC = vpu1.block::NUMERIC AND bn1.year = vpu1.year
) bn2
JOIN avg_pc_vpu_block vpu2
ON bn2.neighbor2::NUMERIC = vpu2.block::NUMERIC AND bn2.year = vpu2.year
) bn3
JOIN avg_pc_vpu_block vpu3
ON bn3.neighbor3::NUMERIC = vpu3.block::NUMERIC AND bn3.year = vpu3.year
) bn4
JOIN avg_pc_vpu_block vpu4
ON bn4.neighbor4::NUMERIC = vpu4.block::NUMERIC AND bn4.year = vpu4.year
ORDER BY bn4.block, bn4.year;