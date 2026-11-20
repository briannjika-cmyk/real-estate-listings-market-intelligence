-- I'm checking whether the same city appears under different
-- spellings, capitalization or spacing.

SELECT
    UPPER(TRIM(city)) AS standardized_city,

    COUNT(DISTINCT BINARY city) AS naming_variations,

    GROUP_CONCAT(
        DISTINCT city
        ORDER BY city
    ) AS original_names

FROM data

WHERE city IS NOT NULL

GROUP BY UPPER(TRIM(city))

HAVING COUNT(DISTINCT BINARY city) > 1;