-- Joining tables based on relationships

-- Example 1a
select *
from "orders" o
join "web_events" w
on o.account_id = w.account_id;

-- Example 1b
select o.total_amt_usd "total_sales", w.channel "channel"
from "orders" o
join "web_events" w
on o.account_id = w.account_id;

-- Example 1c
select "channel", sum("total_sales") as "sum_channel"
from
(select o.total_amt_usd "total_sales", w.channel "channel"
from "orders" o
join "web_events" w
on o.account_id = w.account_id) as "table_one"
group by "channel"
order by "sum_channel" desc;

-- Example 1d
select "channel", sum("total_sales") as "sum_channel"
from
(select o.occured_at "time", o.total_amt_usd "total_sales", w.channel "channel"
from "orders" o
join "web_events" w
on o.account_id = w.account_id) as "table_one"
where "time" >= '2015-09-07' and "time" <= '2016-10-02'
group by "channel"
order by "sum_channel" desc;


-- Assignment
-- Business question
-- Which day of the week made more sales, and which channel is responsible for those sales?



--

-- Example 2a
-- Joining 3 tables
select *
from "accounts" a
join "orders" o
on a.id = o.account_id
join "web_events" w
on o.account_id = w.account_id;

-- Example 2b
-- Joining 3 tables and viewing specific columns
select a.name "order_name", a.website "orders_website", o.id "order_id", 
o.total "order_total", w.occurred_at "time", w.channel "channel_point"
from "accounts" a
join "orders" o
on a.id = o.account_id
join "web_events" w
on o.account_id = w.account_id;

----CLASS ASSIGNMENT------

-- Question - Which day of the week made more sales, and which channel is responsible for those sales?
-- ANSWER---
select "channel", "Week_Day", count("Week_Day") as "orders_Count"
from
(
select *, to_char(cast(o.occurred_at as date), 'Day') as "Week_Day"
from "orders" as o
join "web_events" as w
on o.account_id = w.account_id
) as "table_one"
group by "channel", "Week_Day"
order by "orders_Count" desc
limit 1;
