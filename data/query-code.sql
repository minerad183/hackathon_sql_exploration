-- ACTIVITIES AND SECTORS --
-- Purpose: Query the database to find the TOP 10 activities by number of loans
SELECT a.activity_name, COUNT(DISTINCT l.loan_id) as loan_count
FROM loans AS l
JOIN activities AS a ON l.activity_id = a.activity_id
GROUP BY a.activity_name
ORDER BY loan_count DESC
LIMIT 10;
-- Purpose: Query the database to find the TOP 10 sectors by number of loans
SELECT s.sector_name, COUNT(DISTINCT l.loan_id) as loan_count
FROM loans AS l
JOIN sectors AS s ON l.sector_id = s.sector_id
GROUP BY s.sector_name
ORDER BY loan_count DESC
LIMIT 10;
-- Purpose: Query the database to find the average repayment term by sector
SELECT s.sector_name, ROUND(AVG(l.lender_repayment_term)::numeric, 1) as avg_repayment_term
FROM loans AS l
JOIN sectors AS s ON l.sector_id = s.sector_id
GROUP BY s.sector_id
ORDER BY avg_repayment_term DESC;


-- GENDER --
-- Purpose: Query the database to find the average loan amount by gender
SELECT d.gender, ROUND(AVG(l.loan_amount), 2) AS avg_loan_amount
FROM loans AS l
JOIN demographics AS d ON l.borrower_id = d.borrower_id
GROUP BY d.gender;
-- Purpose: Query the database to find the total number of loans received by gender
SELECT d.gender, COUNT(l.loan_id) AS loan_count
FROM loans AS l
JOIN demographics AS d ON l.borrower_id = d.borrower_id
GROUP BY d.gender
ORDER BY loan_count DESC;
-- Purpose: Query the database to find the total number of loans with the tag '#Women-Owned Business'. Create a View to parse through the list in the Tags column, then query the View for the specific tag
CREATE VIEW split_tags AS
SELECT SPLIT_PART(SPLIT_PART(uti.tags, '[', 2), ']', 1) FROM utility AS uti;
--Step 2
SELECT COUNT(split_part) AS women_owned FROM split_tags
WHERE split_part ILIKE ('''%%#Woman-Owned Business%%''')
ORDER BY women_owned DESC;

-- COUNTRIES --
-- Purpose: Query the database to find the TOP 10 countries by number of loans
SELECT c.country_name, COUNT(DISTINCT l.loan_id) as loan_count
FROM loans AS l
JOIN countries AS c ON c.iso_code = l.iso_code
----Optional where clause to focus on women-owned
--JOIN demographics AS dem on dem.borrower_id = l.borrower_id
--WHERE dem.gender = 'female'
GROUP BY c.country_name
ORDER BY loan_count DESC
LIMIT 10;
-- Purpose: Query the database to find the TOP 10 countries by average loan amount
SELECT c.country_name, ROUND(AVG(l.loan_amount)::numeric, 2) as avg_loan_amount
FROM loans AS l
JOIN countries AS c ON c.iso_code = l.iso_code
GROUP BY c.country_name
ORDER BY avg_loan_amount DESC
LIMIT 10;
-- Purpose: Query the database to find the average repayment term by countries
SELECT c.country_name, ROUND(AVG(l.lender_repayment_term)::numeric, 1) as avg_repayment_term
FROM loans AS l
JOIN countries AS c ON c.iso_code = l.iso_code
GROUP BY  c.country_name
ORDER BY avg_repayment_term DESC;
