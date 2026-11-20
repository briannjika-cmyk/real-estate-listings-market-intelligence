USE sales_analysis;

-- I want to compare each listing's price against the median
-- price of properties with the same number of bedrooms.

WITH ranked_properties AS (
    SELECT
        city,
        bedrooms,
        sqft_living,
        price,

        ROW_NUMBER() OVER (
            PARTITION BY bedrooms
            ORDER BY price
        ) AS price_rank,

        COUNT(*) OVER (
            PARTITION BY bedrooms
        ) AS total_properties

    FROM data
    WHERE price > 0
      AND bedrooms IS NOT NULL
      AND sqft_living > 0
),

middle_prices AS (
    SELECT
        bedrooms,
        price,

        AVG(price) OVER (
            PARTITION BY bedrooms
        ) AS median_price

    FROM ranked_properties

    WHERE price_rank IN (
        FLOOR((total_properties + 1) / 2),
        FLOOR((total_properties + 2) / 2)
    )
),

median_by_bedrooms AS (
    SELECT DISTINCT
        bedrooms,
        median_price
    FROM middle_prices
)

SELECT
    rp.city,
    rp.bedrooms,
    rp.sqft_living,

    rp.price AS listing_price,

    ROUND(mb.median_price, 2) AS median_price,

    ROUND(
        rp.price - mb.median_price, 2
    ) AS price_difference,

    ROUND(
        ((rp.price - mb.median_price)
        / mb.median_price) * 100, 2
    ) AS percentage_difference,

    CASE
        WHEN rp.price > mb.median_price THEN 'Above Median'
        WHEN rp.price < mb.median_price THEN 'Below Median'
        ELSE 'At Median'
    END AS price_comparison

FROM ranked_properties rp

JOIN median_by_bedrooms mb
    ON rp.bedrooms = mb.bedrooms

ORDER BY
    rp.bedrooms,
    rp.price DESC;