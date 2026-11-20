SELECT
    COUNT(*) AS total_records,

    SUM(date IS NULL) AS missing_date,
    SUM(price IS NULL) AS missing_price,
    SUM(bedrooms IS NULL) AS missing_bedrooms,
    SUM(bathrooms IS NULL) AS missing_bathrooms,
    SUM(sqft_living IS NULL) AS missing_sqft_living,
    SUM(sqft_lot IS NULL) AS missing_sqft_lot,
    SUM(floors IS NULL) AS missing_floors,
    SUM(waterfront IS NULL) AS missing_waterfront,
    SUM(view IS NULL) AS missing_view,
    SUM(conditions IS NULL) AS missing_condition,
    SUM(sqft_above IS NULL) AS missing_sqft_above,
    SUM(sqft_basement IS NULL) AS missing_sqft_basement,
    SUM(yr_built IS NULL) AS missing_yr_built,
    SUM(yr_renovated IS NULL) AS missing_yr_renovated,
    SUM(street IS NULL) AS missing_street,
    SUM(city IS NULL) AS missing_city,
    SUM(statezip IS NULL) AS missing_statezip,
    SUM(country IS NULL) AS missing_country

FROM data;