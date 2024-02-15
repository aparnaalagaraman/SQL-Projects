/* Covid Data Exploration*/

SELECT location,
	   date,
	   total_cases,
	   new_cases,
	   total_deaths,
	   population
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
ORDER BY location,date


--Total Cases Vs Total Deaths
-- Calculating the death rate
-- Shows the death rate increases when the covid is at the peak for the location Australia
SELECT location,
	   date
	   total_cases,
	   total_deaths, 
	   (cast(total_deaths as float)/cast(total_cases as float))*100 AS death_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE location LIKE '%Australia%' 
AND continent IS NOT NULL
ORDER BY location,date

--Calculating the % of people caught covid in Australia
-- Total Cases Vs Population
SELECT location,
	   date,
	   population,
	   total_cases,
	   (cast(total_cases as float)/population)*100 AS covid_infection_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE location LIKE '%Australia%'
AND continent IS NOT NULL
ORDER BY location,date

--Calculating countries with highest infection rate compared to population
SELECT location,
	   population,
	   Max(total_cases) AS highest_infection_count,
	   Max((cast(total_cases as float)/population))*100 AS covid_infection_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY covid_infection_rate DESC

--Displaying the countries with highest death rate in %
SELECT location,
	   population,
	   Max(total_deaths) AS highest_death_count,
	   Max((cast(total_deaths as float)/population))*100 AS death_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY death_rate DESC

--Displaying the COUNTRIES(LOCATION) with highest death count
SELECT location,
	   population,
	   Max((cast(total_deaths as int))) AS highest_death_count
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY highest_death_count DESC

--Displaying the CONTINENTS with highest death count
SELECT continent,
	   Max((cast(total_deaths as int))) AS highest_death_count
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_death_count DESC


--Displaying the covid numbers globally
SELECT location,
	   date
	   total_cases,
	   total_deaths, 
	   (cast(total_deaths as float)/cast(total_cases as float))*100 AS death_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
ORDER BY location,date

--Displaying the covid numbers globally
SELECT date,
	   SUM(new_cases) AS total_new_cases,
	   SUM(new_deaths) AS total_new_deaths,
	   (SUM(new_deaths)/SUM(new_cases))*100 AS new_death_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date

-- Across the world the covid death percentage
SELECT SUM(new_cases) AS total_new_cases,
	   SUM(new_deaths) AS total_new_deaths,
	   (SUM(new_deaths)/SUM(new_cases))*100 AS new_death_rate
FROM [Portfolio Project].[dbo].[covid_deaths]
WHERE continent IS NOT NULL
AND new_cases IS NOT NULL
GROUP BY date
ORDER BY date

SELECT new_cases,
	   new_deaths
FROM [Portfolio Project].[dbo].[covid_deaths]
--WHERE continent IS NOT NULL
--AND new_cases IS NOT NULL
--GROUP BY date
ORDER BY new_cases


--Joining Covid Deaths and Covid Vaccination table
SELECT *
FROM [Portfolio Project].[dbo].[covid_deaths] AS cd
JOIN [Portfolio Project].[dbo].[covidvaccinations] AS cv
ON cd.location = cv.location
AND cd.date = cv.date

-- Displaying the total vaccinatinated population
SELECT cd.continent,
	   cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   SUM(cast(new_vaccinations AS int)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS Rolling_people_vaccinated
FROM [Portfolio Project].[dbo].[covid_deaths] AS cd
JOIN [Portfolio Project].[dbo].[covidvaccinations] AS cv
ON cd.location = cv.location
AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
ORDER BY 2,3


-- Displaying the vaccinated population vs the total population
--Use CTE  (Common Table Expression)
WITH popvsvacc (continent,location,date,population,new_vaccinations,Rolling_people_vaccinated) 
AS (SELECT cd.continent,
	   cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   SUM(cast(new_vaccinations AS int)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS Rolling_people_vaccinated
FROM [Portfolio Project].[dbo].[covid_deaths] AS cd
JOIN [Portfolio Project].[dbo].[covidvaccinations] AS cv
ON cd.location = cv.location
AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
)

SELECT *, (Rolling_people_vaccinated/population) * 100 
FROM popvsvacc


--Creating a temporary table for the percentage of population vaccinated
DROP TABLE IF EXISTS  #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
Rolling_people_vaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT cd.continent,
	   cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   SUM(cast(new_vaccinations AS int)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS Rolling_people_vaccinated
FROM [Portfolio Project].[dbo].[covid_deaths] AS cd
JOIN [Portfolio Project].[dbo].[covidvaccinations] AS cv
ON cd.location = cv.location
AND cd.date = cv.date
--WHERE cd.continent IS NOT NULL

SELECT *, (Rolling_people_vaccinated/population) * 100 
FROM #PercentPopulationVaccinated

-- Creating view to use for data visualizations
CREATE VIEW vaccinatedpopulationrate AS
SELECT cd.continent,
	   cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   SUM(cast(new_vaccinations AS int)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS Rolling_people_vaccinated
FROM [Portfolio Project].[dbo].[covid_deaths] AS cd
JOIN [Portfolio Project].[dbo].[covidvaccinations] AS cv
ON cd.location = cv.location
AND cd.date = cv.date
--WHERE cd.continent IS NOT NULL
--ORDER BY 2,3

SELECT * FROM vaccinatedpopulationrate