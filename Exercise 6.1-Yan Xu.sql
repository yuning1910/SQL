select *
from CHARTER

-- Create CHARTER table

select CHAR_TRIP,CHAR_DATE, CHAR_CITY, CHAR_MILES, CHAR_PAX, CHAR_CARGO, PILOT, FLT_ENGINEER, 
        LOAD_MASTER, AC_NUMBER
into CHARTERTABLE
from CHARTER;

-- show CHARTERTABLE
select *
from CHARTERTABLE;

-- Create MODEL table
select AC_NUMBER, MODEL_CODE, MODEL_SEATS, MODEL_CHG_MILE
into MODEL
from CHARTER;

-- show MODEL table
select *
from MODEL;

-- Create PILOT table
select PILOT, COPILOT
into PILOT
from CHARTER;

-- show PILOT table
select *
from PILOT;

-- Create CUSTOMER table
select CHAR_TRIP, CUST_NUM, CUST_LNAME
into CHARTERCUSTOMER
from CHARTER;

-- show CHARTERCUSTOMER table
select *
from CHARTERCUSTOMER;
