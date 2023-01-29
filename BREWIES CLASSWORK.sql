create table "sales_brew"(
"SALES_ID" numeric,
"SALES_REP" text,
"EMAILS" varchar,
"BRANDS" text,
"PLANT_COST" numeric,
"UNIT_PRICE" numeric,
"QUANTITY" numeric,
"COST" numeric,
"PROFIT" numeric,
"COUNTRIES" text,
"REGION" text,
"MONTHS" text,
"YEARS" numeric
);

select *
from "sales_brew";

select distinct "YEARS"
from "sales_brew";

select distinct "COUNTRIES"
from "sales_brew";

select distinct "MONTHS"
from "sales_brew";


---- PROFIT ANALYSIS ------

--1. Within the space of the last three years, what was the profit worth of the breweries,
--   inclusive of the anglophone and the francophone territories?
select sum("PROFIT") as "total_profit"
from "sales_brew"
where "YEARS" in (2017, 2018, 2019) 
and "COUNTRIES" in ('Togo', 'Senegal', 'Ghana', 'Nigeria', 'Benin');

-- 2. Compare the total profit between these two territories in order for the territory manager,
-- Mr. Stone made a strategic decision that will aid profit maximization in 2020.
-- Country that generated the highest profit in 2019

-- TOTAL PROFIT FOR FRANCOPHONE COUNTRIES
select sum("PROFIT") as "francophone_profit"
from "sales_brew"
where "COUNTRIES" in ('Togo', 'Senegal', 'Benin');

-- TOTAL PROFIT FOR ANGLOPHONE COUNTRIES
select sum("PROFIT") as "anglophone_profit"
from "sales_brew"
where "COUNTRIES" in ('Nigeria', 'Ghana');

-- Help him find the year with the highest profit.
select "YEARS", sum("PROFIT") as "year_profit"
from "sales_brew"
group by "YEARS"
order by "year_profit" desc
limit 1;

-- Which month in the three years was the least profit generated?
select "YEARS", "MONTHS", sum("PROFIT") as "profit_val"
from "sales_brew"
group by "YEARS", "MONTHS"
order by "profit_val" asc
limit 1;


--- What was the minimum profit in the month of December 2018?
select "YEARS", "MONTHS", sum("PROFIT") as "month_profit"
from "sales_brew"
where "MONTHS" in ('December') and "YEARS" in (2018)
group by "MONTHS", "YEARS"
order by "month_profit" asc;

-- CREATE COLUMN FOR TERRITORY CLASSIFICATION
select *,
case when "COUNTRIES" in ('Ghana', 'Nigeria') then 'anglophone'
else 'francophone' end as "TERRITORY"
from "sales_brew";

-- TOTAL PROFIT FOR ANGLOPHONE AND FRANCOPHONE COUNTRIES
select "TERRITORY", sum("PROFIT") as "territory_sum"
from

(select *,
case when "COUNTRIES" in ('Ghana', 'Nigeria') then 'anglophone'
else 'francophone' end as "TERRITORY"
from "sales_brew") as "table_one"

group by "TERRITORY"
order by "territory_sum" desc;

-- 7. Compare the profit in percentage for each of the month in 2019
SELECT "MONTHS", round(SUM("PROFIT") / SUM("COST"), 3) * 100 as "profit_percent"
FROM "sales_brew"
WHERE "YEARS" = 2019
GROUP BY "MONTHS"
ORDER BY "MONTHS" ASC;

-- 8. Which particular brand generated the highest profit in Senegal?
select "BRANDS", "COUNTRIES", sum("PROFIT") as "Profit_Senegal"
from "sales_brew"
where "COUNTRIES" in ('Senegal')
group by "BRANDS", "COUNTRIES"
order by "Profit_Senegal" desc
limit 1;


----- BRAND ANALYIS ----

-- 1. Within the last two years, the brand manager wants to know the top three brands
--- consumed in the francophone countries
Select "BRANDS", "YEARS", "COUNTRIES", sum("QUANTITY") as "Francophone_Brand"
from "sales_brew"
where "COUNTRIES" in ('Togo', 'Senegal', 'Benin') and "YEARS" in (2019,2018)
group by "BRANDS", "YEARS", "COUNTRIES"
order by "Francophone_Brand" desc
limit 3;

 --2. Find out the top two choice of consumer brands in Ghana
Select "BRANDS", "COUNTRIES", sum("QUANTITY") as "TopBrands_Consumed_Ghana"
from "sales_brew"
where "COUNTRIES" in ('Ghana')
group by "BRANDS", "COUNTRIES"
order by "TopBrands_Consumed_Ghana" desc
limit 2;

-- 3. Find out the details of beers consumed in the past three years in the most oil reached
---   country in West Africa.
select "BRANDS", "COUNTRIES", "YEARS", sum("QUANTITY") as "Nigeria_Top_Beer_Consumed"
from "sales_brew"
where "BRANDS" in ('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy')
and "COUNTRIES" in ('Nigeria') and "YEARS" in (2019, 2018, 2017)
group by "BRANDS", "COUNTRIES", "YEARS"
order by "Nigeria_Top_Beer_Consumed" desc;


--- 4. Favorites malt brand in Anglophone region between 2018 and 2019
select "YEARS", "BRANDS", sum("QUANTITY") as "qty_consumed"
from
(
select *,
case when "COUNTRIES" in ('Senegal', 'Togo', 'Benin') then 'Francophone'
else 'Anglophone' end as "Territory"
from "sales_brew") as "table_one"
where "BRANDS" LIKE '%malt' and "Territory" = 'Anglophone'
group by "YEARS", "BRANDS"
order by "qty_consumed" desc;


-- 5. Which brands sold the highest in 2019 in Nigeria?
select "BRANDS", "COUNTRIES", "YEARS", sum("QUANTITY") as "Top_Brand_Nigeria_2019"
from "sales_brew"
where "COUNTRIES" in ('Nigeria') and "YEARS" in (2019)
group by "BRANDS", "COUNTRIES", "YEARS"
order by "Top_Brand_Nigeria_2019" desc
limit 1;


--- 6. Favorites brand in South_South region in Nigeria
select "BRANDS", "COUNTRIES", "REGION", sum("QUANTITY") as "Top_Brand_SSNigeria"
from "sales_brew"
where "COUNTRIES" in ('Nigeria') and "REGION" in ('southsouth')
group by "BRANDS", "COUNTRIES", "REGION"
order by "Top_Brand_SSNigeria"
limit 1;

--- 7. Bear consumption in Nigeria
select "BRANDS", "COUNTRIES", sum("QUANTITY") as "Nigeria_Beer_Consumption"
from "sales_brew"
where "BRANDS" in ('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy')
and "COUNTRIES" in ('Nigeria')
group by "BRANDS", "COUNTRIES"
order by "Nigeria_Beer_Consumption" desc;

--- 8. Level of consumption of Budweiser in the regions in Nigeria
select "BRANDS", "COUNTRIES", "REGION", sum("QUANTITY") as "Nigeria_Bud_Regions"
from "sales_brew"
where "BRANDS" in ('budweiser') and "COUNTRIES" in ('Nigeria')
group by "BRANDS", "COUNTRIES", "REGION"
order by "Nigeria_Bud_Regions" desc;

-- 9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
select "BRANDS", "COUNTRIES", "REGION", "YEARS", sum("QUANTITY") as "Nigeria_Bud_Regions"
from "sales_brew"
where "BRANDS" in ('budweiser') and "COUNTRIES" in ('Nigeria') and "YEARS" in (2019)
group by "BRANDS", "COUNTRIES", "REGION", "YEARS"
order by "Nigeria_Bud_Regions" desc;


----- COUNTRY ANALYISI -----

---1. Country with the highest consumption of beer.
select "BRANDS", "COUNTRIES", sum("QUANTITY") as "Country_Top_Beer"
from "sales_brew"
where "BRANDS" in ('eagle lager', 'hero', 'castle lite', 'budweiser', 'trophy')
group by "BRANDS", "COUNTRIES"
order by "Country_Top_Beer" desc
limit 1;

--- 2. Highest sales personnel of Budweiser in Senegal
select "BRANDS", "SALES_REP", "COUNTRIES", sum("QUANTITY") as "Highest_Sales_Pers"
from "sales_brew"
where "COUNTRIES" in ('Senegal') and "BRANDS" in ('budweiser')
group by "BRANDS", "SALES_REP", "COUNTRIES"
order by "Highest_Sales_Pers" desc
limit 1;


---3. Country with the highest profit of the fourth quarter in 2019
select "COUNTRIES", sum("PROFIT") as "Profit_last_Qrter_Country"
from
(
Select *,
case when "MONTHS" in ('October', 'November', 'December') then 'Fourth_Quarter'
	when "MONTHS" in ('January', 'February', 'March') then 'First_Quarter'
	when "MONTHS" in ('April', 'May', 'June') then 'Second_Quarter'
	else 'Third_Quarter' end as "QUARTERS" from "sales_brew") as "table_two"
where "QUARTERS" = 'Fourth_Quarter'
group by "COUNTRIES"
order by "Profit_last_Qrter_Country" desc
limit 1;