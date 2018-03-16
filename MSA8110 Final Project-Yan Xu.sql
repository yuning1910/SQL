-- 1. Overall assessment of store sales
-- a. Provide a concise summary of total sales.
select sum(Total_Visit_Amt) as 'Total Store Sales'
from store_visits;

select count(distinct store_nbr)
from store_visits

--b. Provide a concise summary of total sales by each store.
-- i. Top 5 performing stores
select top 5 store_visits.Store_Nbr, region_nbr, sum(Total_Visit_Amt) as  'Total Store Sales'
from store_visits, store_information
where store_visits.store_nbr = store_information.store_nbr
group by store_visits.Store_Nbr, region_nbr
order by sum(Total_Visit_Amt) desc;

-- ii. Bottom 5 performing stores
select top 5 store_visits.Store_Nbr, region_nbr, sum(Total_Visit_Amt) as  'Total Store Sales'
from store_visits, store_information
where store_visits.store_nbr = store_information.store_nbr
group by store_visits.Store_Nbr, region_nbr
order by sum(Total_Visit_Amt);



-- c. Provide a concise summary of total sales breakdowns:
-- i. By the day of the week.
select datename(weekday, Transaction_Date) as 'Day of the week', sum(Total_Visit_Amt) as 'Total Weekday Sales'
from store_visits
group by datename(weekday,Transaction_Date)
order by sum(Total_Visit_Amt) desc;

 -- ii. By membership types.
select member_type, sum(Total_Visit_Amt) as 'Total Sales By Membership'
from store_visits,member_index
where store_visits.membership_nbr = member_index.membership_nbr
group by member_type
order by sum(Total_Visit_Amt) desc;


-- iii. By Tender types.
select tender_type, sum(Total_Visit_Amt) as 'Total Sales By Tender Type'
from store_visits
group by tender_type
order by sum(Total_Visit_amt) desc;

-- iiii. By Region.
select region_nbr,sum(Total_Visit_Amt) as 'Average Sales By Region'
from store_visits v, store_information i
where v.store_nbr = i.store_nbr
group by region_nbr
order by sum(Total_Visit_Amt) desc;

-- 2. Assessment of member buying behavior
-- a. Provide a concise summary of the typical purchase patterns (amount and number of
-- items) by our members per visit.
-- Top 10 members who spend the most on average
select top 10 store_visits.membership_nbr, member_type,  avg(Total_Visit_Amt) as 'Average Spending', avg(Tot_Scan_Cnt) as 'Average Number of items'
from store_visits, member_index
where store_visits.membership_nbr = member_index.membership_nbr and store_visits.membership_nbr != 9999
group by store_visits.membership_nbr, member_type
order by avg(Total_Visit_Amt) desc;

-- Top 5 members who spend the most on total

select top 5 (distinct store_visits.membership_nbr), member_type,  Total_Visit_Amt, Tot_Scan_Cnt 
from store_visits, member_index
where store_visits.membership_nbr = member_index.membership_nbr and store_visits.membership_nbr != 9999
order by Total_Visit_Amt desc;


-- b. Provide a concise summary of member visits breakdowns:
-- i. By the day of the week.
select  datename(weekday, Transaction_Date) as 'Day of the week', count(visit_nbr) as 'Total Visit'
from store_visits
group by datename(weekday, Transaction_date)
order by count(visit_nbr) desc;

drop table stringtime
--ii. By hours during a day.
select convert(varchar, transaction_time) as 'Time_in_String', visit_nbr
into stringtime
from store_visits 

select substring(Time_in_String, -5, len(Time_in_String)) as 'Hour of the day', count(visit_nbr) as 'Total Visit'
from stringtime
group by substring(Time_in_String,-5, len(Time_in_String))
order by count(visit_nbr) desc;

--iii.  By Elite Stat Code.
select elite_stat_code, count(visit_nbr) as 'Visit by Elite status'
from store_visits v, member_index m
where v.membership_nbr = m.membership_nbr
group by elite_stat_code;


-- c. Identify the characteristics of the most active (in sales and in frequent visits) 
-- members.
select top 1 membership_nbr,count(visit_nbr) as 'Total Number of Visit', sum(Total_Visit_amt) as 'Total Spending'
into mostactivecustomer
from store_visits
where membership_nbr != 9999
group by membership_nbr
order by count(visit_nbr) desc;

select m.*
from mostactivecustomer a, member_index m
where m.membership_nbr = a.membership_nbr


