create or replace table cfpb.data.complaint_daily_summary as
select
  company,
  state,
  date_trunc('day', date_received) as complaint_date,
  count(*) as complaints_count
from cfpb.data.staging_cfpb_complaints
group by company, state, complaint_date;

create or replace table cfpb.data.complaint_spikes as
select
  company,
  state,
  complaint_date,
  complaints_count,
  lag(complaints_count) over (partition by company, state order by complaint_date) as prev_day_count,
  case
    when lag(complaints_count) over (partition by company, state order by complaint_date) = 0 then null
    else round(((complaints_count - lag(complaints_count) over
         (partition by company, state order by complaint_date)) / lag(complaints_count) over 
         (partition by company, state order by complaint_date)) * 100, 2)
  end as spike_percent
from cfpb.data.complaint_daily_summary;
