select * from financialdataset;
select count(*) from financialdataset;

# Requirement - Financial Performance Overview

select
 year,
SUM(Revenue) AS TOTAL_REVENUE,
SUM(Expenses) AS TOTAL_EXPENSES,
SUM(Net_Income) AS NET_PROFIT
FROM financialdataset
GROUP BY YEAR
ORDER BY YEAR;

select
 year,
 Quarter,
SUM(Revenue) AS TOTAL_REVENUE,
SUM(Expenses) AS TOTAL_EXPENSES,
SUM(Net_Income) AS NET_PROFIT
FROM financialdataset
GROUP BY YEAR, Quarter
ORDER BY YEAR, Quarter;

WITH yearly_data AS (
    SELECT 
        Year,
        SUM(Revenue) AS Total_Revenue
    FROM financialdataset
    GROUP BY Year
 )

SELECT 
    Year,
    Total_Revenue,
    LAG(Total_Revenue) OVER (ORDER BY Year) AS Previous_Year_Revenue,
    ROUND(
        (Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Year)) 
        / LAG(Total_Revenue) OVER (ORDER BY Year) * 100, 2
    ) AS Revenue_Growth_Percentage
FROM yearly_data;

SELECT 
    Year,
    SUM(Net_Income) AS Total_Profit,
    LAG(SUM(Net_Income)) OVER (ORDER BY Year) AS Previous_Profit,
    ROUND(
        (SUM(Net_Income) - LAG(SUM(Net_Income)) OVER (ORDER BY Year)) 
        / LAG(SUM(Net_Income)) OVER (ORDER BY Year) * 100, 2
    ) AS Profit_Growth_Percentage
FROM financialdataset
GROUP BY Year;

SELECT 
    Year,
    Quarter,
    SUM(Revenue) AS Revenue,
    LAG(SUM(Revenue)) OVER (ORDER BY Year, Quarter) AS Previous_Quarter_Revenue,
    ROUND(
        (SUM(Revenue) - LAG(SUM(Revenue)) OVER (ORDER BY Year, Quarter)) 
        / LAG(SUM(Revenue)) OVER (ORDER BY Year, Quarter) * 100, 2
    ) AS QoQ_Growth_Percentage
FROM financialdataset
GROUP BY Year, Quarter;    

# Profitability Analysis
# “Are we actually making money efficiently?”

WITH yearly_data AS (
SELECT 
Year,
SUM(Revenue) AS Total_Revenue,
SUM(Net_Income) AS Total_Profit
FROM financialdataset
GROUP BY Year
)

SELECT 
Year,
Total_Revenue,
Total_profit,
Round((Total_profit / Total_Revenue) * 100, 2) AS Profit_Margin_Percentage
FROM yearly_data; 

WITH yearly_data AS (
SELECT 
Year,
SUM(Operating_Income) AS Operating_Profit,
SUM(Revenue) AS Total_Revenue
FROM financialdataset
GROUP BY Year
)

SELECT 
Year,
Operating_profit,
Total_Revenue,
Round((Operating_Profit / Total_Revenue ) * 100,2) AS Operating_Margin_Percentage
FROM yearly_data;

SELECT 
Company_ID,
SUM(Revenue) AS Total_Revenue,
SUM(Net_Income) AS Total_Profit,
Round((SUM(Net_Income) / SUM(Revenue)) * 100, 2) AS Profit_Margin
FROM financialdataset
GROUP BY Company_ID
ORDER BY Profit_Margin desc;

WITH yearly_data AS (
SELECT 
Year,
SUM(Net_Income) AS Total_Profit
FROM Financialdataset
GROUP BY Year
)

SELECT
Year,
Total_Profit
FROM Yearly_data
ORDER BY Total_Profit desc;

WITH yearly_data AS (
SELECT 
Year,
Quarter,
SUM(Revenue) AS Total_Revenue,
SUM(Net_Income) AS Total_Profit
FROM financialdataset
Group BY Year, Quarter
)

SELECT
Year,
Quarter,
Total_Revenue,
Total_Profit,
Round((Total_Profit / Total_Revenue) * 100, 2) AS Profit_Margin
FROM yearly_data
ORDER BY Year, Quarter;


# Risk & Fraud Analysis

SELECT Fraud_Flag,
COUNT(*) AS Total_Records
FROM financialdataset
GROUP BY Fraud_Flag;

SELECT 
Company_ID,
COUNT(*) AS Fraud_Cases
FROM financialdataset 
WHERE Fraud_Flag = 1
GROUP BY Company_ID
ORDER BY Fraud_Cases DESC;

# External Factors Impact Analysis

SELECT 
Year,
 AVG(Inflation_Rate) AS Avg_Inflation,
 AVG(Exchange_Rate) AS Avg_Exchange_Rate,
 AVG(Interest_Rate) AS Avg_Interest_Rate,
    AVG(Global_Economic_Score) AS Avg_Global_Economic_Score,
 SUM(Net_Income) AS Total_Profit,
 SUM(Revenue) AS Total_Revenue
FROM financialdataset
GROUP BY Year
ORDER BY Year desc;

SELECT 
CASE 
  WHEN Inflation_Rate > 5 THEN 'High_Inflation'
  ELSE 'Low_inflation'
END AS Inflation_Category, 
AVG(Net_Income) AS Avg_Profit
FROM financialdataset
GROUP BY Inflation_Category;


# Market Sentiment & Stock Analysis
SELECT 
  Company_ID,
  AVG(Stock_Price) AS Avg_Stock_price,
  AVG(News_Sentiment_Score) AS Avg_Sentiment,
  AVG(Social_Media_Buzz) AS Avg_Buzz
FROM financialdataset
GROUP BY Company_ID
ORDER BY Avg_Sentiment;


