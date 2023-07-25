 
-- How to build rfm calculation.sql based on raw data 
-- date,user_id,event,amount

with combinedtable as (
-- get user id, purchase date and purchase amount from main data table
	select 
		maintable.user_id, 
		maintable.date, 
		recentdate.recent_date, 
		sum(maintable.amount) as amount, 
		count(maintable.user_id) as totalevents 
	from <your table> as maintable
	-- replace <your table> with your data table.
	-- get the date of last purchase for each user and join it with maintable to get the last purchase date
	join 
	(
		SELECT 
			user_id, 
			max(date) as recent_date 
		from maintable 
		group by 1
	) as recentdate
	on maintable.user_id = recentdate.user_id
	group by 1,2,3
)


-- from combinedtable calculate recency, fregquency and monetary value for each users.
rfm as (
  select 
  	user_id, 
  	DATE_DIFF(current_date(),recent_date,day) as recency, 
  	count(user_id) as frequency, 
  	sum(amount) as monetary  
  from combinedtable
  group by 1,2
  order by recency
)

-- show final table.
select *  from rfm;  
