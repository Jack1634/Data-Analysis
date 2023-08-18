
-- SELECT within SELECT Tutorial QUÝZ

-- 1. List each country name where the population is larger than that of 'Russia'.

	SELECT name FROM world
    WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
  
   SELECT name  FROM world
  where gdp/population > 
					(SELECT gdp/population FROM world where name='United Kingdom')
and continent='Europe'

--3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

	SELECT  name, continent from world
	where continent in (select continent from world  where name 
	in ('Argentina',  'Australia'))
	order by name

--4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
 
    select name,  population from world
    where population > (select population from world where name='Canada') 
	and population < (select population from world where name ='Poland')

--5.Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

--Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

--The format should be Name, Percentage for example:

--name	  percentage
--Albania	3%
--Andorra	0%
--Austria	11%
...	...
--Decimal places
--Percent symbol %
	
	SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') 
	FROM world WHERE continent = 'Europe'

--6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

	SELECT name from world
	where gdp > ( select max(gdp) from world 
	where continent ='Europe')

--7. Find the largest country (by area) in each continent, show the continent, the name and the area:
	
	select continent, name , area 
	from world where area IN (select max(area)
	from world group by continent)

--8. List each continent and the name of the country that comes first alphabetically.

SELECT continent, name FROM world x WHERE name <= ALL(SELECT name FROM world y WHERE x.continent = y.continent);

