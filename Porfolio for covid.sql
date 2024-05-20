select *
from PortfolioProject..CovidDeaths
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

--select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject.dbo.covidDeaths
order by 1,2

--Looking at the Total cases vs Total Deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from PortfolioProject.dbo.covidDeaths
where Location like '%Nigeria%'
order by 1,2

--Looking at the Total cases vs population

select location, date,  population, total_cases, (total_cases/population)*100 as Populationpercentage
from PortfolioProject.dbo.covidDeaths
where Location like '%Nigeria%'
order by 1,2

--Looking at countries with highest infection rate compared to population

select location,   population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject.dbo.covidDeaths
--where Location like '%Nigeria%'
Group by Location, Population
order by PercentPopulationInfected desc

--Showing countries with Higest Death Count per Population

Select  Location, Max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject.dbo.covidDeaths
Group by Location
order by TotalDeathCount desc

--Breaking things down by continent
--COntinent with the highest death count per population
Select  continent, Max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject.dbo.covidDeaths
where continent is not null
Group by continent
order by TotalDeathCount desc


--GLOBAL NUMBERS
 
 Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
 SUM( cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
 from PortfolioProject.dbo.CovidDeaths
 where continent is not null
 Group by date
 order by 1,2

 --From Vaccination Table
 Select *
 from PortfolioProject.dbo.CovidDeaths as dea
 Join PortfolioProject.dbo.CovidVaccinations as vac
	on dea.continent = vac.continent
	and dea.date = vac.date


	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 from PortfolioProject.dbo.CovidDeaths as dea
 Join PortfolioProject.dbo.CovidVaccinations as vac
	on dea.continent = vac.continent
	and dea.date = vac.date
	where dea.continent is not null
	order by 1,2,3










