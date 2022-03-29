DROP TABLE pc_vpu_all;
CREATE TABLE pc_vpu_all(
         year                           NUMERIC NOT NULL
        ,bbl                            NUMERIC NOT NULL
        ,block                          NUMERIC NOT NULL
        ,zipcode                        VARCHAR NOT NULL
        ,pcvpu_target                   NUMERIC
        ,pcvpu_L1                       NUMERIC
        ,pcvpu_L2                       NUMERIC
        ,pcvpu_L3                       NUMERIC
        ,avg_block_pcvpu_L1             NUMERIC
        ,avg_block_pcvpu_L2             NUMERIC
        ,avg_block_pcvpu_L3             NUMERIC
        ,avg_neighbor1_pcvpu_L1         NUMERIC
        ,avg_neighbor1_pcvpu_L2         NUMERIC
        ,avg_neighbor1_pcvpu_L3         NUMERIC
        ,avg_neighbor2_pcvpu_L1         NUMERIC
        ,avg_neighbor2_pcvpu_L2         NUMERIC
        ,avg_neighbor2_pcvpu_L3         NUMERIC
        ,avg_neighbor3_pcvpu_L1         NUMERIC
        ,avg_neighbor3_pcvpu_L2         NUMERIC
        ,avg_neighbor3_pcvpu_L3         NUMERIC
        ,avg_neighbor4_pcvpu_L1         NUMERIC
        ,avg_neighbor4_pcvpu_L2         NUMERIC
        ,avg_neighbor4_pcvpu_L3         NUMERIC
        ,avg_zip_pcvpu_L1               NUMERIC
        ,avg_zip_pcvpu_L2               NUMERIC
        ,avg_zip_pcvpu_L3               NUMERIC
        ,PRIMARY KEY (year, bbl)
);



INSERT INTO pc_vpu_all
SELECT   vpu.year::NUMERIC
        ,vpu.bbl::NUMERIC
        ,vpu.block::NUMERIC
        ,vpu.zipcode
        ,pcvpu_target
        ,pcvpu_L1
        ,pcvpu_L2
        ,pcvpu_L3
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
        ,avg_zip_pcvpu_L1
        ,avg_zip_pcvpu_L2
        ,avg_zip_pcvpu_L3
FROM
pc_vpu_lagged vpu
JOIN lagged_nearest_block_neighbors_avg_pcvpu n
ON vpu.block = n.block AND vpu.year = n.year
JOIN zip_pc_vpu_lagged zip
ON vpu.zipcode = zip.zipcode AND vpu.year = zip.year
ORDER BY vpu.bbl, vpu.year;

