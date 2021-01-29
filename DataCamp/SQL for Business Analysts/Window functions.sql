SELECT
  Year,

  -- Assign numbers to each year
  ROW_NUMBER() OVER () AS Row_N
FROM (
  SELECT DISTINCT YEAR
  FROM Summer_Medals
  ORDER BY Year ASC
) AS Years
ORDER BY Year ASC;


--

SELECT
  Year,
  -- Assign the lowest numbers to the most recent years
  ROW_NUMBER() OVER (ORDER BY Year DESC) AS Row_N
FROM (
  SELECT DISTINCT Year
  FROM Summer_Medals
) AS Years
ORDER BY Year DESC;

--
/* Row numbering can also be used for ranking. For example, numbering rows and
 ordering by the count of medals each athlete earned in the OVER clause will
 assign 1 to the highest-earning medalist, 2 to the second highest-earning
 medalist, and so on. */

-- 1ST PART
SELECT
  -- Count the number of medals each athlete has earned
  Athlete,
  COUNT(*) AS Medals
FROM Summer_Medals
GROUP BY Athlete
ORDER BY Medals DESC;

-- 2ND PART
WITH Athlete_Medals AS (
  SELECT
    -- Count the number of medals each athlete has earned
    Athlete,
    COUNT(*) AS Medals
  FROM Summer_Medals
  GROUP BY Athlete)

SELECT
  -- Number each athlete by how many medals they've earned
  Athlete,
  ROW_NUMBER() OVER (ORDER BY Medals DESC) AS Row_N
FROM Athlete_Medals
ORDER BY Medals DESC;

--

/* A reigning champion is a champion who's won both the previous and current
years' competitions. To determine if a champion is reigning, the previous and
current years' results need to be in the same row, in two different columns.
*/

-- Return each year's gold medalists in the Men's 69KG weightlifting competition.
SELECT
  -- Return each year's champions' countries
  year,
  country AS champion
FROM Summer_Medals
WHERE
  Discipline = 'Weightlifting' AND
  Event = '69KG' AND
  Gender = 'Men' AND
  Medal = 'Gold';

-- Having wrapped the previous query in the Weightlifting_Gold CTE, get the
--previous year's champion for each year.

WITH Weightlifting_Gold AS (
  SELECT
    -- Return each year's champions' countries
    Year,
    Country AS champion
  FROM Summer_Medals
  WHERE
    Discipline = 'Weightlifting' AND
    Event = '69KG' AND
    Gender = 'Men' AND
    Medal = 'Gold')

SELECT
  Year, Champion,
  -- Fetch the previous year's champion
  LAG(Champion) OVER
    (ORDER BY Year ASC) AS Last_Champion
FROM Weightlifting_Gold
ORDER BY Year ASC;


--

/*You've already fetched the previous year's champion for one event. However,
if you have multiple events, genders, or other metrics as columns,
you'll need to split your table into partitions to avoid having a champion from
one event or gender appear as the previous champion of another event or gender.
*/

-- Return the previous champions of each year's event by gender.

WITH Tennis_Gold AS (
  SELECT DISTINCT
    Gender, Year, Country
  FROM Summer_Medals
  WHERE
    Year >= 2000 AND
    Event = 'Javelin Throw' AND
    Medal = 'Gold')

SELECT
  Gender, Year,
  Country AS Champion,
  -- Fetch the previous year's champion by gender
  LAG(Country) OVER (PARTITION BY Gender
            ORDER BY Year ASC) AS Last_Champion
FROM Tennis_Gold
ORDER BY Gender ASC, Year ASC;

-- Return the previous champions of each year's events by gender and event.

WITH Athletics_Gold AS (
  SELECT DISTINCT
    Gender, Year, Event, Country
  FROM Summer_Medals
  WHERE
    Year >= 2000 AND
    Discipline = 'Athletics' AND
    Event IN ('100M', '10000M') AND
    Medal = 'Gold')

SELECT
  Gender, Year, Event,
  Country AS Champion,
  -- Fetch the previous year's champion by gender and event
  LAG(Country) OVER (PARTITION BY Gender, Event
            ORDER BY Year ASC) AS Last_Champion
FROM Athletics_Gold
ORDER BY Event ASC, Gender ASC, Year ASC;

-- CHAPTER 2
-- For each year, fetch the current gold medalist and the gold medalist
-- 3 competitions ahead of the current row.

WITH Discus_Medalists AS (
  SELECT DISTINCT
    Year,
    Athlete
  FROM Summer_Medals
  WHERE Medal = 'Gold'
    AND Event = 'Discus Throw'
    AND Gender = 'Women'
    AND Year >= 2000)

SELECT
  -- For each year, fetch the current and future medalists
  year,
  Athlete,
  LEAD (Athlete,3) OVER (ORDER BY Year ASC) AS Future_Champion
FROM Discus_Medalists
ORDER BY Year ASC;

-- Return all athletes and the first athlete ordered by alphabetical order.

WITH All_Male_Medalists AS (
  SELECT DISTINCT
    Athlete
  FROM Summer_Medals
  WHERE Medal = 'Gold'
    AND Gender = 'Men')

SELECT
  -- Fetch all athletes and the first althete alphabetically
  Athlete,
  FIRST_VALUE(Athlete) OVER (
    ORDER BY Athlete ASC
  ) AS First_Athlete
FROM All_Male_Medalists;

-- Return the year and the city in which each Olympic games were held.
-- Fetch the last city in which the Olympic games were held.

WITH Hosts AS (
  SELECT DISTINCT Year, City
    FROM Summer_Medals)

SELECT
  Year,
  City,
  -- Get the last city in which the Olympic games were held
  LAST_VALUE(City) OVER (
   ORDER BY Year ASC
   RANGE BETWEEN
     UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING
  ) AS Last_City
FROM Hosts
ORDER BY Year ASC;


/* In chapter 1, you used ROW_NUMBER to rank athletes by awarded medals.
However, ROW_NUMBER assigns different numbers to athletes with the same count of
awarded medals, so it's not a useful ranking function; if two athletes earned the
same number of medals, they should have the same rank. */

-- Rank each athlete by the number of medals they've earned -- the higher the count,
-- the higher the rank -- with identical numbers in case of identical values.

-- First you get the general table without ranking with a cte then the ranking

WITH Athlete_Medals AS (
  SELECT
    Athlete,
    COUNT(*) AS Medals
  FROM Summer_Medals
  GROUP BY Athlete)

SELECT
  Athlete,
  Medals,
  -- Rank athletes by the medals they've won
  RANK() OVER (ORDER BY Medals DESC) AS Rank_N
FROM Athlete_Medals
ORDER BY Medals DESC;