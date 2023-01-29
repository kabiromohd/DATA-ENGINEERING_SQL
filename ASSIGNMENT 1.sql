create table "accounts"(
"id" numeric,
"name" text,
"website" varchar,
"lat" numeric,
"long" numeric,
"primary_poc" text,
"sales_rep_id" numeric
);

create table "orders"(
"id" numeric,
"account_id" numeric,
"occurred_at" varchar,
"standard_qty" numeric,
"gloss_qty" numeric,
"poster_qty" numeric,
"total" numeric,
"standard_amt_usd" numeric,
"gloss_amt_usd" numeric,
"poster_amt_usd" numeric,
"total_amt_usd" numeric
);

create table "region"(
"id" numeric,
"name" text
);

create table "sales_reps"(
"id" numeric,
"name" text,
"region_id" numeric
);

create table "web_events"(
"id" numeric,
"account_id" numeric,
"occurred_at" varchar,
"channel" text
);

select *
from "accounts"

select *
from "orders"

select *
from "region"

select *
from "sales_reps"

select *
from "web_events"