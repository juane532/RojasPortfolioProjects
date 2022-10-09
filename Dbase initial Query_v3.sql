/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [TotalCases]
      ,[TotalDeaths]
      ,[DeathPercentage]
  FROM [PortfolioProject].[dbo].[GlobalNumbers]