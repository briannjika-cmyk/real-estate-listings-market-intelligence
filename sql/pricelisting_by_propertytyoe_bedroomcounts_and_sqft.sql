
USE sales_analysis;

-- I want to understand how bedroom count relates to listing prices.
-- I'm grouping properties by their living area to make the
-- comparisons between bedroom counts fairer.

SELECT
    bedrooms,
    CASE
        WHEN sqft_living < 1000 THEN 'Under 1,000 sqft'
        WHEN sqft_living < 2000 THEN '1,000 - 1,999 sqft'
        WHEN sqft_living < 3000 THEN '2,000 - 2,999 sqft'
        WHEN sqft_living < 4000 THEN '3,000 - 3,999 sqft'
        ELSE '4,000+ sqft'
    END AS property_size,

    COUNT(*) AS total_properties,
    ROUND(AVG(price), 2) AS average_listing_price,
    ROUND(AVG(price / sqft_living), 2) AS average_price_per_sqft

FROM data
WHERE price > 0
  AND sqft_living > 0
  AND bedrooms IS NOT NULL

GROUP BY
    bedrooms,
    property_size

ORDER BY
    bedrooms,
    MIN(sqft_living);