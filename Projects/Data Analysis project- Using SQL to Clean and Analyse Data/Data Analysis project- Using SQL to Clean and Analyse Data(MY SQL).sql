create DATABASE Fake_project;

use fake_project;

select * from calls

-- Create a table 
CREATE TABLE calls (
				ID CHAR(50),
                cust_name char(50),
                sentiment char(20),
                csat_score ınt,
                call_timestamp char (10),
                reason char (20),
                city char(20),
                state char(20),
                channel char(20),
                response_time char(20),
                call_duration_minutes INT,
                call_center char(20)
-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Cleaning our data -------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------
    -- the call_timestamp is a string , so we need to convert it date 
    
    SET SQL_SAFE_UPDATES = 0;
    UPDATE calls SET call_timestamp = str_to_date(call_timestamp, "%m/%d/%Y");
	SET SQL_SAFE_UPDATES = 1;
    
	select * from calls LIMIT 10;
    
 --  We need to set the SQL_SAFE_UPDATES off before we do change the column. reason is because we dont specify a where clause that uses a KEY column.
 -- That is why we set it off before the query, and then set it back on after. and the results?
 
 -- Now to our next problem. The zero’s in the csat_score.There are two options: either we set them to NULL, or we just leave them be and then when 
-- we query the table we just add the clause WHERE csat_score != 0. But I will set them to nulls in this way:
 
   SET SQL_SAFE_UPDATES = 0;
   UPDATE calls SET csat_score = null WHERE csat_score = 0;
   SET SQL_SAFE_UPDATES = 1;
   
   select * from calls LIMIT 10;



 
 
 
-- -----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- Exploring our data ------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- lets see sahape of our data, the number of columns and rows

SELECT COUNT(*) AS rows_num FROM calls ;
SELECT COUNT(*) AS cols_num FROM information_schema.columns WHERE table_name = "calls"

-- So we 32,941 records and 12 columns.

-- Chek the dıstınct  values of some columns :

SELECT  DISTINCT sentiment FROM calls;
SELECT  DISTINCT reason FROM calls;
SELECT  DISTINCT channel FROM calls;
SELECT  DISTINCT call_center FROM calls;

-- -- The count and precentage from total of each of the distinct values we got:

SELECT  sentiment , count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls)) * 100,1) AS pct FROM calls ROUP BY 1 ORDER BY 3 DESC;

SELECT reason ,count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls )) * 100,1) AS pct FROM calls GROUP BY 1 ORDER BY 3 DESC;

SELECT channel ,count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls )) * 100,1) AS pct FROM calls GROUP BY 1 ORDER BY 3 DESC;

SELECT response_time ,count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls )) * 100,1) AS pct FROM calls GROUP BY 1 ORDER BY 3 DESC;

SELECT call_center ,count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls )) * 100,1) AS pct FROM calls GROUP BY 1 ORDER BY 3 DESC;

SELECT state ,count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls )) * 100,1) AS pct FROM calls GROUP BY 1 ORDER BY 3 DESC;

-- To see the distribution of our calls among different columns. Let’s see the reason column:

SELECT reason ,count(*), ROUND((COUNT(*) / (SELECT COUNT(*) FROM calls )) * 100,1) AS pct FROM calls GROUP BY 1 ORDER BY 3 DESC;

-- Here we can see that Billing Questions amount to a whooping 71% of all calls, with service outage and payment related calls both are 14.4% of all calls.

-- Moving on, which day has the most calls?
 
  SELECT DAYNAME(call_timestamp) as Day_of_call, COUNT(*) num_of_calls FROM calls GROUP BY 1 ORDER BY 2 DESC;
 -- Friday has the most number of calls while Sunday has the least.
 
 
 
-- --------------------------------------------------- Aggregations----------------------------------------------------

SELECT MIN(csat_score) AS min_score, MAX(csat_score) AS max_score, ROUND(AVG(csat_score),1) AS avg_score FROM calls WHERE  csat_score !=0;

SELECT MIN(call_timestamp) AS earliest_date, MAX(call_timestamp) AS most_recent FROM calls;

SELECT call_center, response_time, COUNT(*) AS count
FROM calls GROUP BY 1,2 ORDER BY 1,3 DESC;

SELECT call_center, AVG(call_duration_minutes) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT channel, AVG(call_duration_minutes) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT state, COUNT(*) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT state, reason, COUNT(*) FROM calls GROUP BY 1,2 ORDER BY 1,2,3 DESC;

SELECT state, sentiment , COUNT(*) FROM calls GROUP BY 1,2 ORDER BY 1,3 DESC;

SELECT state, AVG(csat_score) as avg_csat_score FROM calls WHERE csat_score != 0 GROUP BY 1 ORDER BY 2 DESC;

SELECT MIN(call_duration_minutes) AS min_call_duration, MAX(call_duration_minutes) AS max_call_duration, AVG(call_duration_minutes) AS avg_call_duration FROM calls;

SELECT sentiment, AVG(call_duration_minutes) FROM calls GROUP BY 1 ORDER BY 2 DESC;

SELECT call_timestamp, MAX(call_duration_minutes) OVER(PARTITION BY call_timestamp) AS max_call_duration FROM calls GROUP BY 1 ORDER BY 2 DESC;










                