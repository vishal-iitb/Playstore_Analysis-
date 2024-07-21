-- identifying null values --

SELECT *
FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL

--now removing null values --
DELETE FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL


-- overall view of dataset--
SELECT 
COUNT (DISTINCT APP) AS total_app,
COUNT (DISTINCT Category) AS total_categories
FROM dbo.googleplaystore

--explring app category--
SELECT TOP 5 
Category,
COUNT (App) AS Total_app
from dbo.googleplaystore
GROUP BY Category
ORDER BY Total_app DESC

--top free apps--
select Top 10
app,
Category,
Rating,
Reviews
FROM dbo.googleplaystore
WHERE TYPE = 'Free' AND Rating <> 'Nan'
ORDER BY Rating DESC


--most review app --
select TOP 10
Category,
APP,
Reviews
from dbo.googleplaystore
ORDER BY Reviews DESC

-- avg rating by category--
select top 5
Category,
AVG (TRY_CAST(Rating as float)) AS avg_rating
FROM dbo.googleplaystore
group by Category
ORDER BY avg_rating DESC 

-- top categories by number of installs --
SELECT TOP 10
Category,
SUM(CAST(REPLACE(SUBSTRING(Installs, 1, PATINDEX('%[^0-9]%', Installs + ' ') - 1), ',' , ' ') AS INT)) AS total_installs
FROM dbo.googleplaystore
GROUP BY Category
ORDER BY total_installs DESC

-- avg sentiment polarity by app category --
SELECT TOP 10
Category,
AVG(TRY_CAST(Sentiment_Polarity AS FLOAT)) AS avg_sentiment_polarity
FROM dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
GROUP BY Category
ORDER BY avg_sentiment_polarity DESC

-- sentiment reviews by app category --
SELECT TOP 10
Category,
Sentiment,
COUNT(*) AS total_sentiment
FROM dbo.googleplaystore
JOIN dbo.googleplaystore_user_reviews
ON dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
WHERE Sentiment <> 'nan'
GROUP BY Category, Sentiment
ORDER BY total_sentiment DESC