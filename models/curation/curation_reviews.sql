WITH reviews_raw AS (
SELECT
  listing_id,
  date as review_date
FROM {{ source("raw_airbnb_data", "reviews") }})
SELECT 
   listing_id,
   review_date,
   count(*) as number_review
FROM reviews_raw
GROUP BY 1,2