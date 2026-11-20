USE sales_analysis;

-- I want to see all the cities represented in the dataset
-- and how many properties are recorded in each location.

SELECT
    city,
    COUNT(*) AS property_count

FROM data

GROUP BY city

ORDER BY property_count DESC;