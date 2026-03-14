-- ============================================================
-- Investor Behavior & Risk Analytics
-- MySQL Analysis Queries
-- Dataset: finance_data
-- ============================================================


-- ============================================================
-- SECTION 0: SETUP
-- ============================================================

-- Add a unique primary key column to the table
ALTER TABLE finance_data 
ADD COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;


-- SECTION 1: DATA EXPLORATION

-- Preview all records in the dataset
SELECT * FROM finance_data;



-- SECTION 2: DEMOGRAPHIC ANALYSIS

-- Q: What is the average age of investors for each investment avenue?
-- Helps identify whether younger or older investors prefer certain avenues.
SELECT 
    Avenue,
    ROUND(AVG(Age), 1) AS avg_age
FROM finance_data
GROUP BY Avenue
ORDER BY avg_age DESC;


-- Q: How are investors distributed across age groups?
-- Segments investors into 5-year age bands to understand the age profile of the dataset.
SELECT 
    CASE
        WHEN Age BETWEEN 20 AND 25 THEN '20-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        WHEN Age BETWEEN 31 AND 35 THEN '31-35'
        ELSE '36+'
    END AS Age_Group,
    COUNT(*) AS Total_Investors
FROM finance_data
GROUP BY Age_Group
ORDER BY Total_Investors DESC;


-- SECTION 3: RISK ANALYSIS

-- Q: How many investors fall into each risk category?
-- Risk is derived from the Equity_Market score:
--   Score <= 2        → High Risk (aggressive investors)
--   Score 3-4         → Moderate Risk
--   Score >= 5        → Low Risk (conservative investors)
SELECT 
    CASE
        WHEN Equity_Market <= 2 THEN 'High Risk'
        WHEN Equity_Market BETWEEN 3 AND 4 THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS Risk_Category,
    COUNT(*) AS Total_Investors
FROM finance_data
GROUP BY Risk_Category
ORDER BY Total_Investors DESC;


-- SECTION 4: INVESTMENT PREFERENCE ANALYSIS

-- Q: What percentage of each gender's investments go to each avenue?
-- Uses a window function (PARTITION BY gender) to calculate within-gender percentages.
-- Shows whether male and female investors prefer different avenues.
SELECT 
    gender, 
    Avenue, 
    COUNT(*) AS avenue_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY gender), 2) AS pct_of_gender_total
FROM finance_data
GROUP BY gender, Avenue
ORDER BY gender, pct_of_gender_total DESC;


-- Q: What is the top investment avenue for each gender by investor count?
-- A simpler view of gender vs. avenue preference, ordered by popularity.
SELECT 
    gender,
    Avenue,
    COUNT(*) AS investors
FROM finance_data
GROUP BY gender, Avenue
ORDER BY gender, investors DESC;


-- Q: How does each avenue rank by average mutual fund preference score?
-- Uses DENSE_RANK() to rank avenues — rank 1 = lowest average MF score.
-- Useful for understanding which investor groups are least drawn to mutual funds.
SELECT 
    Avenue, 
    ROUND(AVG(Mutual_Funds), 2) AS avg_mf_score,
    DENSE_RANK() OVER(ORDER BY AVG(Mutual_Funds) ASC) AS score_rank
FROM finance_data
GROUP BY Avenue;


-- Q: Which investors have a below-average mutual fund score?
-- Identifies investors less engaged with mutual funds compared to the overall average.
SELECT 
    gender, 
    age, 
    Mutual_Funds, 
    Avenue
FROM finance_data
WHERE Mutual_Funds < (SELECT AVG(Mutual_Funds) FROM finance_data)
ORDER BY Mutual_Funds ASC;


-- ============================================================
-- SECTION 5: RETURN EXPECTATION ANALYSIS
-- ============================================================

-- Q: Which older-than-average investors (by gender) expect high returns (20%–40%)?
-- Uses a correlated subquery to compare each investor's age against
-- the average age of their own gender group.
-- Highlights high-ambition investors who are older than their peers.
SELECT 
    gender, 
    age, 
    Expect, 
    Avenue
FROM finance_data f1
WHERE age > (
    SELECT AVG(age) 
    FROM finance_data f2 
    WHERE f1.gender = f2.gender
)
AND Expect IN ('20%-30%', '30%-40%')
ORDER BY age DESC;
