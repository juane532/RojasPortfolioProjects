SELECT *
FROM PortfolioProject..CovifDeaths$
Where continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject..CovifVaccinations$
--order by 3,4


-- Selecting Data to be used

SELECT Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovifDeaths$
order by 1,2

-- Researching Total Cases vs Total Deaths
-- Shor the percetage of Dying from Covid in Country
SELECT Location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovifDeaths$
Where Location like '%States'
and continent is not null
order by 1,2

-- Total cases vs Population
-- Shows Percetange of Population wit Covid
SELECT Location, date, total_cases, population,(total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovifDeaths$
--Where Location like '%States'
order by 1,2


-- Researching Countries with High Infection Rate compared to population
SELECT Location, Population, MAX(total_cases) as Highest_Infection, Max((total_cases/population))*100 as PercentagePopulationInfected
from PortfolioProject..CovifDeaths$
Where continent is not null
--Where Location like '%States'
Group by Location, Population
order by PercentagePopulationInfected desc

-- Researching Total Deaths by Highest
SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovifDeaths$
Where continent is not null
--Where Location like '%States'
Group by Location
order by TotalDeathsCount desc

-- Researching by Continent
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovifDeaths$
Where continent is not null
--Where Location like '%States'
Group by continent
order by TotalDeathsCount desc

--Test right numbers bu continent
SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovifDeaths$
Where continent is null
--Where Location like '%States'
Group by Location
order by TotalDeathsCount desc

-- Showing Continents with the highest death count per population
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovifDeaths$
Where continent is not null
--Where Location like '%States'
Group by continent
order by TotalDeathsCount desc

--Researching Global Numbers

SELECT sum(total_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovifDeaths$
--Where Location like '%States'
Where continent is not null
--Group by date
order by 1,2

-- Joining Vaccine Tables to obtain a more robust information...Total Population vs Vaccination

-- use of CTE

With PopvsVac (continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as BIGINT)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovifDeaths$ Dea
Join PortfolioProject..CovifVaccinations$ Vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)

SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac


-- Temp Table Creation

DROP Table if exists #PercentPeopleVaccinated
Create Table #PercentPeopleVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert Into #PercentPeopleVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as BIGINT)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovifDeaths$ Dea
Join PortfolioProject..CovifVaccinations$ Vac
	on dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null

SELECT *, (RollingPeopleVaccinated/population)*100
FROM #PercentPeopleVaccinated

-- Create View to store data for Visualization

Create View PercentPeopleVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as BIGINT)) over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovifDeaths$ Dea
Join PortfolioProject..CovifVaccinations$ Vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
-- Order by 2,3

Select * 
FROM PercentPeopleVaccinated
