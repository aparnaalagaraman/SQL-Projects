SELECT *
  FROM [Portfolio Project].[dbo].[covid_deaths]
  ORDER BY 3,4

  -- Select the needed data
  SELECT location,
		 date,
		 total_cases,
		 new_cases,
		 total_deaths,
		 population
  FROM [Portfolio Project].[dbo].[covid_deaths]
  ORDER BY location,date


-- Total Cases Vs Total Deaths 
SELECT location,
	   date,
	   total_cases,
	   total_deaths,
	   (population/2) AS death_rate
  FROM [Portfolio Project].[dbo].[covid_deaths]
  ORDER BY location,date
