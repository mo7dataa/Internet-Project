-- =========================================
-- Internet Usage Analysis Project
-- Author: Mohamed Ahmed Saeed
-- =========================================

-- =========================
-- 1. Preview Tables
-- =========================

SELECT TOP 10 * FROM internet_usage_table;
SELECT TOP 10 * FROM countries_table;
SELECT TOP 10 * FROM years_table;

-- =========================
-- 2. Row Counts
-- =========================

SELECT COUNT(*) AS InternetUsageRows
FROM internet_usage_table;

SELECT COUNT(*) AS CountriesRows
FROM countries_table;

SELECT COUNT(*) AS YearsRows
FROM years_table;

-- =========================
-- 3. Missing Values Check
-- =========================

SELECT *
FROM internet_usage_table
WHERE InternetUsersPercent IS NULL;

SELECT *
FROM countries_table
WHERE CountryID IS NULL;

SELECT *
FROM years_table
WHERE YearID IS NULL;

-- =========================
-- 4. Top Countries by Internet Usage (2020)
-- =========================

SELECT TOP 10
    c.Country,
    y.Year,
    i.InternetUsersPercent
FROM internet_usage_table i
JOIN years_table y
    ON y.YearID = i.YearID
JOIN countries_table c
    ON c.CountryID = i.CountryID
WHERE y.Year = 2020
ORDER BY i.InternetUsersPercent DESC;

-- =========================
-- 5. Average Internet Usage by Region
-- =========================

SELECT
    c.Region,
    AVG(i.InternetUsersPercent) AS AverageInternetUsage
FROM internet_usage_table i
JOIN countries_table c
    ON c.CountryID = i.CountryID
GROUP BY c.Region
ORDER BY AverageInternetUsage DESC;

-- =========================
-- 6. Create Analysis View
-- =========================

CREATE VIEW InternetAnalysis AS
SELECT
    c.Country,
    c.Region,
    y.Year,
    i.InternetUsersPercent,
    i.CellularSubscriptions,
    i.BroadbandSubscriptions
FROM internet_usage_table i
JOIN countries_table c
    ON c.CountryID = i.CountryID
JOIN years_table y
    ON y.YearID = i.YearID;

-- =========================
-- 7. Average Internet Usage by Year
-- =========================

SELECT
    Year,
    AVG(InternetUsersPercent) AS AvgInternet
FROM InternetAnalysis
GROUP BY Year
ORDER BY Year;

-- =========================
-- 8. Global Mobile & Internet Averages
-- =========================

SELECT
    AVG(CellularSubscriptions) AS AvgMobileSubscriptions,
    AVG(InternetUsersPercent) AS AvgInternetUsage
FROM InternetAnalysis;

-- =========================
-- 9. Regional Comparison
-- =========================

SELECT
    Region,
    AVG(InternetUsersPercent) AS AvgInternetUsage
FROM InternetAnalysis
GROUP BY Region
ORDER BY AvgInternetUsage DESC;

-- =========================
-- 10. Dashboard View
-- =========================

CREATE VIEW DashboardData AS
SELECT
    Country,
    Region,
    Year,
    InternetUsersPercent,
    CellularSubscriptions,
    BroadbandSubscriptions
FROM InternetAnalysis;
