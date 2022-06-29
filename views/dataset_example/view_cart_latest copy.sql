CREATE OR REPLACE VIEW `<project_id>.id_test_build.view_cart_latest_w`
OPTIONS(
description="the latest representation of each cart"
)
AS
SELECT * EXCEPT(row_number)
  FROM (
   SELECT
     *,
     ROW_NUMBER() OVER(PARTITION BY Id ORDER BY PartitionTimestamp DESC) row_number
   FROM(
    SELECT * FROM `<project_id>.id_test_build.cart_timeseries`
      UNION ALL
    SELECT * FROM `<project_id>.id_test_build.cart_staging` WHERE _PARTITIONDATE >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
   )
  ) 
  WHERE row_number = 1