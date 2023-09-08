CREATE TABLE appleStore_Description_combined as 
	select * from appleStore_description1
    UNION ALL
    SELECT * FROM appleStore_description2
    UNION ALL
    SELECT *  FROM appleStore_description3
    UNION ALL
    SELECT * FROM appleStore_description4
    
** EXPORATORY DATA ANALYSIS **
--check the unique apps in both tables
select COUNT(DISTINCT id) as uniqueAppsId from AppleStore;

select COUNT(DISTINCT id) as uniqueAppsId from appleStore_Description_combined;

-- check for any missing values in key field
select COUNT(*) as missing_values 
from AppleStore
where id is NULL or track_name is NULL;

SELECT COUNT(*) as missing_values 
from appleStore_Description_combined
where app_desc is NULL or track_name is NULL;

--Find out the number of apps per genre
SELECT prime_genre, COUNT(*) as numApps
from AppleStore
GROUP by 1
order by numApps DESC;

-- Get an overview of the apps rating
SELECT min(user_rating) as minRating,
       max(user_rating) as maxRating,
       avg(user_rating) AS avgRating
from AppleStore

** DATA ANALYSIS **
-- Determine whether paid apps have higher ratings than free apps
select * from AppleStore;

SELECT
	CASE
        WHEN price > 0 THEN	'Paid'
        ELSE 'Free'
    END as App_Type,
    round(avg(user_rating),2) as aveRating 
    from AppleStore
    GROUP by App_Type;
    
-- Check if apps with more supported languages have higher rating
select * FROM AppleStore;

SELECT
	CASE
    	WHEN lang_num < 10 THEN '< 10 languages'
        WHEn lang_num BETWEEN 11 and 30 THEN ' 11-30 languages'
        WHEN lang_num BETWEEN 31 and 40 THEN ' 31-40 languages'
        ELSE '> 40 languages'
        END as lang_Type,
	round(avg(user_rating),2) as avgRating
    from AppleStore
    GROUP  by lang_Type
    ORDER BY avgRating DESC;

-- Which App category had highest price
SELECT * FROM AppleStore;

SELECT prime_genre, price from AppleStore
GROUP BY 1
ORDER by 2 DESC
LIMIT 5;

-- Check genre with low ratings
SELECT * FROM AppleStore;

SELECT prime_genre, round(avg(user_rating),2) as avgRating
from AppleStore
GROUP by prime_genre
ORDER by avgRating asc
LIMIT 10;

-- Check if there is correlation between the length of the app and 
-- description and the user rating.
SELECT * FROM appleStore_Description_combined;

SELECT CASE
			WHEn length(b.app_desc) < 500 THEN "Short"
            WHEN length(b.app_desc) BETWEEN 501 and 1000 THEN "Medium"
            ELSE "Long"
        END as description_length,
        round(avg(a.user_rating),2) as average_Rating
FROM AppleStore as a
JOIN appleStore_Description_combined as b
on a.id = b.id

GROUP BY description_length
ORDER by average_Rating DESC
LIMIT 10;



CONCLUSION
/* 1: Paid App are slightly higher compared to a Free Apps */
/* 2: Apps that support more than 40 languages had the higher ratings compared to the other apps
/* 3: Utility, Business, Medical and Education apps has the highest price amoung all apps category */
/* 4: Catalogs, Finance and Book apps has the lowest rating amoung all apps category */
/* 5: Apps with longer description have better ratings