USE sales_analysis;

WITH ranked_prices AS (
    SELECT
        price,
        ROW_NUMBER() OVER (ORDER BY price) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM data
    WHERE price IS NOT NULL
),

price_quartiles AS (
    SELECT
        MAX(CASE
            WHEN row_num = CEIL(total_rows * 0.25)
            THEN price
        END) AS Q1,

        MAX(CASE
            WHEN row_num = CEIL(total_rows * 0.75)
            THEN price
        END) AS Q3

    FROM ranked_prices
),

price_bounds AS (
    SELECT
        Q1,
        Q3,
        Q3 - Q1 AS IQR,
        Q1 - (1.5 * (Q3 - Q1)) AS lower_bound,
        Q3 + (1.5 * (Q3 - Q1)) AS upper_bound

    FROM price_quartiles
)
SELECT
    COUNT(*) AS outlier_count

FROM data s
CROSS JOIN price_bounds b

WHERE s.price < b.lower_bound
   OR s.price > b.upper_bound;
