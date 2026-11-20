SELECT
    SUM(TRIM(street) = '') AS empty_street,
    SUM(TRIM(city) = '') AS empty_city,
    SUM(TRIM(statezip) = '') AS empty_statezip,
    SUM(TRIM(country) = '') AS empty_country

FROM data;
