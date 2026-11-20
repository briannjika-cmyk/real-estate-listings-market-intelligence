USE sales_analysis;

-- I'm calculating the price per square foot for each property.
-- This will help me compare property values regardless of size.
-- I'm using sqft_living because it represents the property's
-- actual living area.
SELECT
    street,
    city,
    price,
    sqft_living,

    -- Divide the property price by its living area
    ROUND(price / NULLIF(sqft_living, 0), 2) AS price_per_sqft

FROM data

-- Exclude records with missing or invalid living area
WHERE sqft_living IS NOT NULL
AND sqft_living > 0

ORDER BY price_per_sqft DESC;