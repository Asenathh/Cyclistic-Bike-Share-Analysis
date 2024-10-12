--created a database, then created a table in the database.
CREATE TABLE TripsTable (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
	start_lat FLOAT,
	start_lng FLOAT,
	end_lat FLOAT,
	end_lng FLOAT,
    member_casual VARCHAR(255)
);

--loaded every csv file into my destination table using the BULK INSERT command
BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202310-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202311-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202312-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202401-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202402-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202403-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202404-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202405-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202406-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202407-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202408-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT TripsTable
FROM 'C:\Users\Asenath\Desktop\DATA ANALYTICS\Bike-Share\Cyclistic_12_Months\202409-divvy-tripdata.csv'
WITH (
    FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

--after loading each file above, i checked to make sure they were loading correctly
SELECT 
	COUNT(*)
FROM TripsTable;

--now to explore my data and understand the structure
SELECT 
	TOP 10 *
FROM TripsTable;

--to see the schema of the table
EXEC 
	sp_help TripsTable;

--more exploring
SELECT
	COUNT(*) AS Missing_Ride_Id
FROM TripsTable
WHERE ride_id = NULL;

SELECT
	COUNT(*) AS Missing_Rideable_Type
FROM TripsTable
WHERE rideable_type IS NULL;

SELECT
	COUNT(*) AS Missing_Started_At
FROM TripsTable
WHERE started_at IS NULL;

SELECT
	COUNT(*) AS Missing_Ended_At
FROM TripsTable
WHERE ended_at IS NULL;

--identifying columns with missing values
SELECT 
    COUNT(*) AS Total_Rides,
    COUNT(rideable_type) AS Rides_With_Bike_Type,
    COUNT(started_at) AS Rides_With_Start_Time,
    COUNT(ended_at) AS Rides_With_End_Time,
    COUNT(start_station_name) AS Rides_With_Start_Station,
    COUNT(end_station_name) AS Rides_With_End_Station,
    COUNT(member_casual) AS Rides_With_Membership_Status
FROM TripsTable;

--deleting rowa with missing values because they are few
DELETE FROM TripsTable
WHERE start_station_name IS NULL or end_station_name is NULL;

--check for duplicate value
SELECT
	ride_id, COUNT(*) AS Duplicate_Count
From TripsTable
GROUP BY ride_id
HAVING COUNT(*) > 1;

--Deleting duplicates
WITH CTE AS (
    SELECT 
        *, 
        ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY started_at) AS RowNum
    FROM TripsTable
)
DELETE FROM CTE WHERE RowNum > 1;

--trimming trailling space
UPDATE TripsTable
SET start_station_name = LTRIM(RTRIM(start_station_name)),
    end_station_name = LTRIM(RTRIM(end_station_name));

--data validation, checking to make sure ended_at is greater than started_at
SELECT *
FROM TripsTable
WHERE ended_at <= started_at;

--deleting the records where the data integrity condition fails
DELETE FROM TripsTable
WHERE ended_at <= started_at;

--reviewing data after cleaning
SELECT
	TOP 10 *
FROM TripsTable;

--performing exploratory data analysis
ALTER TABLE TripsTable
ADD trip_duration AS DATEDIFF(MINUTE, started_at, ended_at);

--trip duration
SELECT 
    member_casual,
    AVG(trip_duration) AS avg_trip_duration,
    MIN(trip_duration) AS min_trip_duration,
    MAX(trip_duration) AS max_trip_duration
FROM TripsTable
WHERE trip_duration > 0  -- Ensuring no negative durations post-cleaning
GROUP BY member_casual;

--popuplar ride time (hourly trends)
SELECT 
    member_casual,
    DATEPART(HOUR, started_at) AS ride_hour,
    COUNT(*) AS ride_count
FROM TripsTable
GROUP BY member_casual, DATEPART(HOUR, started_at)
ORDER BY member_casual, ride_hour;

--rideable type usage preference
SELECT --rideable type usage
    member_casual,
    rideable_type,
    COUNT(*) AS ride_count
FROM TripsTable
GROUP BY member_casual, rideable_type;

--popular start and end stations
SELECT 
    member_casual,
    start_station_name,
    COUNT(*) AS start_count
FROM TripsTable
GROUP BY member_casual, start_station_name
ORDER BY start_count DESC;

SELECT 
    member_casual,
	end_station_name,
    COUNT(*) AS end_count
FROM TripsTable
GROUP BY member_casual, end_station_name
ORDER BY end_count DESC;

--weekly trends
SELECT 
    member_casual,
    DATENAME(WEEKDAY, started_at) AS weekday,
    COUNT(*) AS ride_count
FROM TripsTable
GROUP BY member_casual, DATENAME(WEEKDAY, started_at)
ORDER BY member_casual, weekday;

--monthly trends
SELECT 
    member_casual,
    MONTH(started_at) AS month,
    COUNT(*) AS ride_count
FROM TripsTable
GROUP BY member_casual, MONTH(started_at)
ORDER BY member_casual, month;