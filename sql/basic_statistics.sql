SELECT
    COUNT(*) AS total_properties,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    AVG(price) AS average_price,
    ROUND(STDDEV(price), 2) AS price_std_deviation

FROM data;