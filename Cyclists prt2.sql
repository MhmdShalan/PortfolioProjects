--calculating the distance using lat and lng
WITH t1 AS (SELECT member_casual,
    start_lat,
    end_lat,
    start_lng,
    end_lng,
    2 * 6371 * ASIN(SQRT(POWER(SIN((RADIANS(end_lat - start_lat)) / 2), 2) +
    COS(RADIANS(start_lat)) * COS(RADIANS(end_lat)) *
    POWER(SIN((RADIANS(end_lng - start_lng)) / 2), 2))) AS distance
FROM 
    [Project1].[dbo].[202205-divvy-tripdata] )
	SELECT TOP 10 member_casual, CONCAT(SUM(distance), ' KM') distance
	FROM t1 
	GROUP BY member_casual




-- AVG of count per member_casual of all year
WITH t1 AS (
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202205-divvy-tripdata]
)
SELECT member_casual, AVG(ride_count) AS average_count
FROM (
  SELECT member_casual, COUNT(*) AS ride_count
  FROM t1
  GROUP BY member_casual
) AS subquery
GROUP BY member_casual



-- AVG of count per member_casual per bikes of all year
WITH t1 AS (
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id FROM [Project1].[dbo].[202205-divvy-tripdata]
)
SELECT member_casual,rideable_type ,  AVG(ride_count) AS average_count
FROM (
  SELECT member_casual,rideable_type , COUNT(*) AS ride_count
  FROM t1
  GROUP BY member_casual , rideable_type
) AS subquery1
GROUP BY member_casual , rideable_type
ORDER BY member_casual DESC , average_count DESC


-- AVG of ride legnth per group per bike 
WITH t1 AS (
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202205-divvy-tripdata])

SELECT member_casual , rideable_type, AVG(ride_length_minutes) AS average_count
FROM t1
GROUP BY member_casual,rideable_type
ORDER BY member_casual DESC , rideable_type DESC



-- SUM of ride legnth per group 
WITH t1 AS (
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual, rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202205-divvy-tripdata])

SELECT member_casual ,  SUM(ride_length_minutes) AS average_count
FROM t1
GROUP BY member_casual
ORDER BY member_casual DESC 



--avg of distance  
WITH t1 AS (
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202205-divvy-tripdata]),

t2 AS (SELECT member_casual, rideable_type,
    start_lat,
    end_lat,
    start_lng,
    end_lng,
    2 * 6371 * ASIN(SQRT(POWER(SIN((RADIANS(end_lat - start_lat)) / 2), 2) +
    COS(RADIANS(start_lat)) * COS(RADIANS(end_lat)) *
    POWER(SIN((RADIANS(end_lng - start_lng)) / 2), 2))) AS distance
FROM t1 )
	SELECT TOP 10 member_casual, AVG(distance)
	FROM t2
	GROUP BY member_casual 


	-- truncated_date with counting of uses in each day
	WITH t1 AS (
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202205-divvy-tripdata])

SELECT
  DATEADD(day, DATEDIFF(day, 0, started_at), 0) AS truncated_date,
  COUNT(*) AS count
FROM t1
GROUP BY DATEADD(day, DATEDIFF(day, 0, started_at), 0)
ORDER BY DATEADD(day, DATEDIFF(day, 0, started_at), 0) 


-- truncated_dates of ride_length of each day for each group
WITH t1 AS (
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202205-divvy-tripdata])

SELECT 
  DATEADD(day, DATEDIFF(day, 0, started_at), 0) AS truncated_date, member_casual,
  CAST(AVG((DATEDIFF(SECOND, started_at, ended_at)/60.0)) AS DECIMAL(10, 2)) AS ride_length_minutes
FROM t1
GROUP BY DATEADD(day, DATEDIFF(day, 0, started_at), 0) , member_casual
ORDER BY DATEADD(day, DATEDIFF(day, 0, started_at), 0) 





-- average distance by day by member_casual
WITH t1 AS (
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202304-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202303-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202302-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202301-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202212-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202211-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202210-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202209-divvy-publictripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202208-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202207-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202206-divvy-tripdata]
  UNION ALL
  SELECT member_casual , started_at,ended_at, start_lat, end_lat, start_lng, end_lng , rideable_type, ride_id , (DATEDIFF(SECOND, started_at, ended_at)/60.0) ride_length_minutes FROM [Project1].[dbo].[202205-divvy-tripdata]),

t2 AS (SELECT  member_casual, rideable_type, DATEADD(day, DATEDIFF(day, 0, started_at), 0) day,
    start_lat,
    end_lat,
    start_lng,
    end_lng,
    2 * 6371 * ASIN(SQRT(POWER(SIN((RADIANS(end_lat - start_lat)) / 2), 2) +
    COS(RADIANS(start_lat)) * COS(RADIANS(end_lat)) *
    POWER(SIN((RADIANS(end_lng - start_lng)) / 2), 2))) AS distance
FROM t1 )
	SELECT day ,member_casual, AVG(distance) 
	FROM t2
	GROUP BY member_casual , day
