-- gives only lagged pcvpu values for each block and block neighbors
-- uses un-truncated pc_vpu table (NOT pc_vpu_trunc) because outliers
-- encode construction signals

CREATE VIEW lagged_nearest_block_neighbors_avg_pcvpu
AS
SELECT 
    year
    ,block
    ,avg_block_pcvpu_L1
    ,avg_block_pcvpu_L2
    ,avg_block_pcvpu_L3
    ,avg_neighbor1_pcvpu_L1
    ,avg_neighbor1_pcvpu_L2
    ,avg_neighbor1_pcvpu_L3
    ,avg_neighbor2_pcvpu_L1
    ,avg_neighbor2_pcvpu_L2
    ,avg_neighbor2_pcvpu_L3
    ,avg_neighbor3_pcvpu_L1
    ,avg_neighbor3_pcvpu_L2
    ,avg_neighbor3_pcvpu_L3
    ,avg_neighbor4_pcvpu_L1
    ,avg_neighbor4_pcvpu_L2
    ,avg_neighbor4_pcvpu_L3
FROM 
(
        (
            (SELECT block
                   ,year
            FROM
            nearest_block_neighbors_avg_pcvpu) as nn_t
            INNER JOIN
            (SELECT block as block_L1
                    ,year as year_L1
                    ,avg_block_pcvpu as avg_block_pcvpu_L1
                    ,avg_neighbor1_pcvpu as avg_neighbor1_pcvpu_L1
                    ,avg_neighbor2_pcvpu as avg_neighbor2_pcvpu_L1
                    ,avg_neighbor3_pcvpu as avg_neighbor3_pcvpu_L1
                    ,avg_neighbor4_pcvpu as avg_neighbor4_pcvpu_L1
            FROM
            nearest_block_neighbors_avg_pcvpu) as nn_L1
            ON block = block_L1 AND year = year_L1 + 1
        )
    INNER JOIN
    (SELECT block as block_L2
            ,year as year_L2
            ,avg_block_pcvpu as avg_block_pcvpu_L2
            ,avg_neighbor1_pcvpu as avg_neighbor1_pcvpu_L2
            ,avg_neighbor2_pcvpu as avg_neighbor2_pcvpu_L2
            ,avg_neighbor3_pcvpu as avg_neighbor3_pcvpu_L2
            ,avg_neighbor4_pcvpu as avg_neighbor4_pcvpu_L2
    FROM
    nearest_block_neighbors_avg_pcvpu) as nn_L2
    ON block = block_L2 AND year = year_L2 + 2
)
INNER JOIN
(SELECT block as block_L3
        ,year as year_L3
        ,avg_block_pcvpu as avg_block_pcvpu_L3
        ,avg_neighbor1_pcvpu as avg_neighbor1_pcvpu_L3
        ,avg_neighbor2_pcvpu as avg_neighbor2_pcvpu_L3
        ,avg_neighbor3_pcvpu as avg_neighbor3_pcvpu_L3
        ,avg_neighbor4_pcvpu as avg_neighbor4_pcvpu_L3
FROM
nearest_block_neighbors_avg_pcvpu) as nn_L3
ON block = block_L3 AND year = year_L3 + 3
ORDER BY block, year;


SELECT COUNT(*), MAX(vpu.year), MIN(vpu.year) FROM
pc_vpu_lagged vpu JOIN lagged_nearest_block_neighbors_avg_pcvpu n
ON vpu.block = n.block AND vpu.year = n.year
ORDER BY vpu.bbl, vpu.year;

