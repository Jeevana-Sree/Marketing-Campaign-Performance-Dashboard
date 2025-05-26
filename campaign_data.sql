SELECT * from campaign_data limit 5;

--  Campaign Funnel & Performance

-- Total campaigns by channel

select Channel_Used, count(distinct Campaign_ID) as Total_Campaings
from campaign_data
group by Channel_Used;

-- CTR (Click-Through Rate) by channel

select Channel_Used,
sum(Impressions) as Total_Impressions,
sum(Clicks) as Total_Clicks,
round(sum(Clicks)*100/nullif(sum(Impressions),0),2)
from campaign_data
group by Channel_Used;

-- Top 5 campaigns by ROI

select Campaign_ID, company, ROI
from campaign_data
order by ROI DESC
limit 5;

--  Cost efficiency (lowest acquisition cost campaigns)

select Campaign_ID, Company, Channel_Used, Acquisition_Cost
from campaign_data
order by Acquisition_Cost 
limit 5;

-- ROI vs Acquisition Cost overview

select Channel_Used,
round(avg(ROI),2) as Avg_ROI,
round(avg(Acquisition_Cost),2) as Avg_Cost
from campaign_data
group by Channel_Used;

-- Customer Segments & Audience Insights

-- Conversion rate by customer segment

select Customer_Segment,
round(avg(Conversion_Rate),2) as Avg_Conversion
from campaign_data
group by Customer_Segment;

--  Engagement score by customer segment

select Customer_Segment,
round(avg(Engagement_Score),2) as Avg_Engagement
from campaign_data
group by Customer_Segment;

--  Target audience performance

select Target_Audience,
round(avg(Conversion_Rate),2) as Avg_Conversion,
round(avg(Engagement_Score),2) as Avg_Engagement
from campaign_data
group by Target_Audience
order by Avg_Conversion DESC;

-- Channel & Location Analysis

-- Channel effectiveness summary

select Channel_Used,
round(avg(Conversion_Rate),2) as Avg_Conversion,
round(avg(ROI), 2) as Avg_ROI
from campaign_data
group by Channel_Used;

--  Best-performing regions

select Location,
round(avg(ROI),2) as Avg_ROI,
round(avg(Conversion_Rate),2) as Avg_Conversion
from campaign_data
group by Location
order by Avg_ROI DESC
Limit 5;

-- Time-Based Trends (if dates are per day)

-- Revenue trend (if ROI is revenue-driven)

select Date,
round(avg(ROI),2) as Daily_ROI
from campaign_data
group by Date 
order by Date;

-- Weekly/Monthly campaign volume (if date granularity allows)

select strftime('%Y-%m',Date) as Month,
count(distinct Campaign_ID) as Campaigns
from campaign_data
where Date is NOT NULL
group by Month
Order by Month;

-- Comparative Insights

-- Language-wise performance

select Language,
round(avg(ROI),2) as Avg_ROI,
round(Avg(Conversion_Rate),2) as Avg_Conversion
from campaign_data
group by Language;

-- Company-wise efficiency

select Company,
round(avg(ROI),2) as Avg_ROI,
round(avg(Acquisition_Cost),2) as Avg_Acquisition
from campaign_data
Group by Company
order by Avg_ROI DESC;


-- Total Campaigns

select count(DISTINCT Campaign_ID) from campaign_data;

-- Total Clicks 

select sum(Clicks) from campaign_data;

-- Average CTR 

select round(sum(Clicks)*100/sum(Impressions),2) from campaign_data;

-- Total Impressions

select sum(Impressions) from campaign_data;

-- Average ROI

select round(avg(ROI),2) from campaign_data;

-- Total Estimated Conversions 

SELECT 
    Channel_Used,
    SUM(Clicks) AS Total_Clicks,
    ROUND(SUM(Clicks * (Conversion_Rate / 100.0)), 0) AS Estimated_Conversions
FROM campaign_data
GROUP BY Channel_Used
ORDER BY Estimated_Conversions DESC;


SELECT 
  ROUND(SUM(Impressions * Conversion_Rate / 100.0), 0) AS Estimated_Conversions
FROM campaign_data
WHERE Impressions IS NOT NULL AND Conversion_Rate IS NOT NULL;
