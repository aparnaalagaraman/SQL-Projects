---1st Query for Viz
SELECT SUM(new_cases) AS total_new_cases,
	   SUM(new_deaths) AS total_new_deaths,
	   CASE WHEN SUM(new_cases) = 0 THEN 0 ELSE SUM(CAST(new_deaths AS INT)) / SUM(new_cases) END * 100 AS new_death_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
ORDER BY 1,2

--2nd Query for Viz
SELECT location,
	   SUM(new_deaths) AS Totaldeathcount
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NULL
AND location NOT IN ('World','European Union','International')
GROUP BY location
ORDER BY Totaldeathcount DESC

--3rd Query for Viz
SELECT location,
	   population,
	   Max(total_cases) AS highest_infection_count,
	   Max((cast(total_cases as float)/population))*100 AS covid_infection_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
GROUP BY location,population
ORDER BY covid_infection_rate DESC

--4th Query for Viz
SELECT location, 
	   population,
	   date, 
	   MAX(total_cases) as HighestInfectionCount,  
	   Max((total_cases/population))*100 AS PercentPopulationInfected
FROM [Portfolio Project].[dbo].[covid_deaths]
--Where location like '%states%'
GROUP BY location, population, date
ORDER BY PercentPopulationInfected DESC