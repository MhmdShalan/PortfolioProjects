--Counting how many non_nulls and nulls with categorization of grouped col start_lat 
SELECT  start_lat, COUNT(CASE WHEN start_station_id IS NULL THEN 1 ELSE 1 END) count_start_station_id ,
COUNT(CASE WHEN start_station_id IS NULL THEN 1 END) Num_Nulls,
CASE WHEN COUNT(CASE WHEN start_station_id IS NULL THEN 1 END) > 0 THEN 'Has Nulls' ELSE 'No Nulls' END AS Col_type
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY  start_lat 
ORDER BY Num_Nulls DESC

--HERE IS A CONFIRMATION OF THE START_LAT IS TRUE ACCORDING TO THE ABOVE QUERY (testing one value of start_lat)
SELECT start_station_id, start_lat
FROM [Project1].[dbo].tripdata
WHERE start_lat >= 41.6500015258789 - 0.000000001 
    AND start_lat <= 41.6500015258789 + 0.000000001 

-- SAME AS THE CONFIRMATION QUERY BUT DIFFEENT METHOD AND EASIER
	SELECT start_station_id, start_lat
FROM [Project1].[dbo].tripdata
WHERE ROUND(start_lat, 9) = ROUND(41.6500015258789, 9);


------------------------------------------------------------------------



--how many each start_lat has nulls
SELECT TOP 1000 COUNT(*) count,start_lat, start_station_id  
FROM [Project1].[dbo].[202205-divvy-tripdata] t1
WHERE start_station_id IS NULL
GROUP BY start_lat,start_station_id
HAVING COUNT(*) > 1



--here testing the above query by taking one value and check uniqueness
SELECT TOP 1000  start_lat,start_station_id  , COUNT(start_lat) start_lat_42
FROM [Project1].[dbo].[202205-divvy-tripdata] t1
WHERE start_lat   = 42 AND NOT start_station_id IS NULL
GROUP BY start_station_id, start_lat


--here same as above but with decimals fixed the problem of not counting decimals
SELECT TOP 1000 start_station_id  , COUNT(start_lat) start_lat_count
FROM [Project1].[dbo].[202205-divvy-tripdata] t1
WHERE CAST(start_lat AS decimal(18,10)) = CAST(41.8699989318848 AS decimal(18,10)) AND NOT start_station_id IS NULL
GROUP BY start_station_id


  ----------------------------------------------------------
-- Calculating date difference to see if difference exists more than one day which means bikers use the bike for longer than 24 hours
SELECT DATEDIFF(day, started_at, ended_at) AS date_difference
FROM [Project1].[dbo].[202205-divvy-tripdata]
WHERE DATEDIFF(day, started_at, ended_at) > 0
ORDER BY date_difference DESC


-- how many each member_casual used bikes more than 24 hrs
SELECT member_casual, COUNT( CASE WHEN DATEDIFF(HOUR, started_at, ended_at) > 24 THEN 1 END) AS num_24hrs_use
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY member_casual
ORDER BY member_casual


-- how many each member_casual each bike type used bikes more than 24 hrs
SELECT member_casual, rideable_type, COUNT( CASE WHEN DATEDIFF(HOUR, started_at, ended_at) > 24 THEN 1 END) AS num_24hrs_use
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY member_casual , rideable_type
ORDER BY member_casual


--checking how many nulls for each column
SELECT
    COUNT(CASE WHEN ride_id IS NULL THEN 1 END) AS ride_id_nulls,
    COUNT(CASE WHEN rideable_type IS NULL THEN 1 END) AS rideable_type_nulls,
    COUNT(CASE WHEN ended_at IS NULL THEN 1 END) AS ended_at_nulls,
	COUNT(CASE WHEN start_station_name IS NULL THEN 1 END) AS start_station_name_nulls ,
	COUNT(CASE WHEN start_station_id IS NULL THEN 1 END) AS start_station_id_nulls,
	COUNT(CASE WHEN end_station_name IS NULL THEN 1 END) AS end_station_name_nulls,
	COUNT(CASE WHEN end_station_id IS NULL THEN 1 END) AS end_station_id_nulls,
	COUNT(CASE WHEN start_lat IS NULL THEN 1 END) AS start_lat_nulls,
	COUNT(CASE WHEN start_lng IS NULL THEN 1 END) AS start_lng_nulls,
	COUNT(CASE WHEN end_lat IS NULL THEN 1 END) AS end_lat_nulls,
	COUNT(CASE WHEN end_lng IS NULL THEN 1 END) AS end_lng_nulls,
	COUNT(CASE WHEN member_casual IS NULL THEN 1 END) AS member_casual_nulls
FROM
    [Project1].[dbo].[202205-divvy-tripdata]

--How many each member_casual uses each type of bikes
SELECT member_casual, rideable_type,COUNT(*)  count
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY rideable_type, member_casual
ORDER BY count DESC

--How many each member_casual uses bikes 
SELECT member_casual,COUNT(*)  count
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY  member_casual
ORDER BY count DESC

--Checking repeated ride_id result .... no repeated ones
SELECT (SELECT COUNT(DISTINCT ride_id) FROM [project1].[dbo].[202205-divvy-tripdata]) unique_ride_id,
( SELECT COUNT(ride_id) FROM [Project1].[dbo].[202205-divvy-tripdata])

--same purpose of code
SELECT ride_id, COUNT(*) AS ride_id_count  
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY ride_id
HAVING COUNT(*) > 1


-- Checking for duplicates(uniqueness).  Result >>>> not unique 
   WITH t1 AS(SELECT DISTINCT COUNT(*) unrepeated_table
   FROM [Project1].[dbo].[202205-divvy-tripdata]),

   t2 AS ( SELECT COUNT(*) normal_table
      FROM [Project1].[dbo].[202205-divvy-tripdata])

	  SELECT t1.unrepeated_table,t2.normal_table
	  FROM t1,t2



-- how many rows that doesnt have any null
WITH t1 AS (
    SELECT COUNT(*) AS Non_nulls_rows
    FROM [Project1].[dbo].[202205-divvy-tripdata]
    WHERE start_station_id IS NOT NULL
        AND start_station_name IS NOT NULL
        AND end_station_id IS NOT NULL
        AND end_station_name IS NOT NULL
        AND end_lat IS NOT NULL
        AND end_lng IS NOT NULL
), t2 AS (
    SELECT COUNT(*) AS Nulls_rows
    FROM [Project1].[dbo].[202205-divvy-tripdata]
    WHERE start_station_id IS NULL
        OR start_station_name IS NULL
        OR end_station_id IS NULL
        OR end_station_name IS NULL
        OR end_lat IS NULL
        OR end_lng IS NULL
)
SELECT t2.Nulls_rows, t1.Non_nulls_rows
FROM t1, t2;


--Here checking the total_ride_length grouped by member_casual and bike_type which one has more ride_length
SELECT
  member_casual,
  rideable_type,
  CONCAT(CAST(ROUND(SUM(DATEDIFF(SECOND, started_at, ended_at)/60.0), 0)AS  int), ' Mins') AS minutes_ride_length --concat to write mins cast to return it to a numberwith no decmials round is to round up all decimals
FROM [project1].dbo.[202205-divvy-tripdata]
WHERE start_station_name IS NOT NULL
GROUP BY member_casual, rideable_type
ORDER BY SUM(DATEDIFF(SECOND, started_at, ended_at)) DESC;




--Here checking the total_ride_length grouped by member_casual which one has more ride_length
SELECT member_casual  ,CONCAT(CAST(ROUND(SUM(DATEDIFF(SECOND, started_at, ended_at)/60.0), 0)AS  int), ' Mins') AS minutes_ride_length
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY member_casual 
ORDER BY SUM(DATEDIFF(SECOND, started_at, ended_at)) DESC;
 


 --Getting the 5 highest start station and end station ride_length time
SELECT TOP 5
  start_station_name, 
  end_station_name,
  member_casual,
  CONCAT(CAST(ROUND(SUM(DATEDIFF(SECOND, started_at, ended_at)/60.0), 0) AS INT), ' Mins') AS minutes_ride_length
FROM [Project1].[dbo].[202205-divvy-tripdata]
WHERE NOT start_station_name IS NULL AND end_station_name IS NOT NULL
GROUP BY start_station_name,end_station_name, member_casual
ORDER BY SUM(DATEDIFF(SECOND, started_at, ended_at)) DESC;




-- Here the name of day in the start_at column
  SELECT DATENAME(WEEKDAY, started_at) AS started_at_day
FROM [Project1].[dbo].[202205-divvy-tripdata]



--Average of ride_length for each group member_casual 
SELECT member_casual, AVG(DATEDIFF(SECOND, started_at, ended_at)/60.0) AS minutes_ride_length
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY member_casual

--Average of ride_length for each group member_casual for each bike
SELECT member_casual, rideable_type, AVG(DATEDIFF(SECOND, started_at, ended_at)/60.0) AS minutes_ride_length
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY member_casual, rideable_type

--Calculate the mode of the day of week  
SELECT DATENAME(WEEKDAY, started_at) AS started_at_day, COUNT(*) AS frequency
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY DATENAME(WEEKDAY, started_at) 
HAVING COUNT(*) = (
  SELECT MAX(frequency)
  FROM (
    SELECT DATENAME(WEEKDAY, started_at) AS started_at_day, COUNT(*) AS frequency
    FROM [Project1].[dbo].[202205-divvy-tripdata]
    GROUP BY DATENAME(WEEKDAY, started_at) 
  ) AS subquery
);

--Calculate the Average of Ride_length by started_at_day
SELECT DATENAME(WEEKDAY, started_at) AS started_at_day, AVG(DATEDIFF(SECOND, started_at,ended_at)/60.0) Avg_ride_length
    FROM [Project1].[dbo].[202205-divvy-tripdata]
	GROUP BY DATENAME(WEEKDAY, started_at) 


--How many rides per user per day of week
SELECT DATENAME(WEEKDAY, started_at) AS start_at_day, COUNT(*) num_rides
FROM [Project1].[dbo].[202205-divvy-tripdata]
GROUP BY DATENAME(WEEKDAY, started_at)
ORDER BY COUNT(*) DESC

