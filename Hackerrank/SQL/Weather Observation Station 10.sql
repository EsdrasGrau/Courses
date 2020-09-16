SELECT city
FROM STATION
WHERE UPPER(RIGHT(city,1)) NOT IN ('A', 'E', 'I', 'O', 'U')
GROUP BY city
ORDER BY city ASC;
