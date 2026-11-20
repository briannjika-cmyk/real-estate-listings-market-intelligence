USE sales_analysis;

-- I want to find out which cities have the biggest differences
-- between their cheapest and most expensive property listings.
-- I'm also checking the average price and number of listings
-- to understand the differences between locations.

SELECT
    city,
    COUNT(*) AS total_properties,
    ROUND(MIN(price), 2) AS lowest_listing_price,
    ROUND(MAX(price), 2) AS highest_listing_price,
    ROUND(MAX(price) - MIN(price), 2) AS price_range,
    ROUND(AVG(price), 2) AS average_listing_price

FROM data
WHERE price > 0
  AND city IS NOT NULL

GROUP BY city
HAVING COUNT(*) >= 10
ORDER BY price_range DESC;