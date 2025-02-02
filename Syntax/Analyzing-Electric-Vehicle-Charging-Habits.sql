select * from charging_session

-- 1. Find the number of unique individuals that use each garage's shared charging stations
select garage_id,
	   COUNT(distinct user_id) as num_unique_users
from charging_session
where user_type = 'Shared'
group by garage_id 
order by num_unique_users desc
-- 2. Find the top 10 most popular charging start times (by weekday and start hour) for sessions that use shared charging stations
select weekdays_plugin,
	   start_plugin_hour,
	   count(*) as num_charging_sessions
from charging_session
where user_type = 'Shared'
group by weekdays_plugin, start_plugin_hour
order by num_charging_sessions desc 
limit 10;
-- 3. Find the users whose average charging duration last longer than 10 hours when using shared charging stations
select user_id,
	   round(avg(duration_hours), 1) as avg_charging_duration
from charging_session
where user_type = 'Shared'
group by user_id
having avg(duration_hours) > 10
order by avg_charging_duration
