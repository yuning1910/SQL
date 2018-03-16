-- Assess the entity integrity for MEMBER INDEX table
select *
from member_index
where membership_nbr is null;

select membership_nbr, count(*)
from member_index
group by membership_nbr
having count(*) > 1;

-- Assess the entity integrity for STORE INFORMATION table
select *
from STORE_INFORMATION
where store_Nbr is null;

select store_nbr, count(*)
from store_information
group by store_nbr
having count(*) > 1;

-- Assess the entity integrity for STORE VISITS table
select *
from store_visits
where visit_Nbr is null;

select visit_Nbr, count(*)
from store_visits
group by visit_Nbr
having count(*) > 1;

-- Assess the referential integrity between Store Visits and Member Index
select membership_nbr
from store_visits
where membership_nbr not in (select membership_nbr from member_index);

-- Assess the referential integrity between Store Visits and Store Information
select store_nbr
from store_visits
where store_nbr not in (select store_nbr from store_information);

-- Create a Dummy Variable in the primary table
insert into MEMBER_INDEX values(9999, 'unkno', 'unknow', 'A','A', 0, '2001-10-13 00:00:00.000', '2001-10-13 00:00:00.000', 0, 0, 0, 'unkw', 0, '2001-10-13 00:00:00.000')

-- Updated the unmatched FK values to dummy values. 
update STORE_VISITS
set Membership_Nbr = 9999
where Membership_Nbr not in (select Membership_Nbr from MEMBER_INDEX);