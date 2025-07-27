create or replace table cfpb.data.company_risk_scores as
with last_90_days as (
  select
    company,
    state,
    complaint_date,
    complaints_count,
    spike_percent
  from cfpb.data.complaint_spikes
  where complaint_date >= dateadd(day, -90, current_date)
)
select
  company,
  state,
  avg(spike_percent) as avg_spike_percent,
  sum(complaints_count) as total_complaints_90d,
  case
    when avg(spike_percent) > 50 then 50
    when avg(spike_percent) > 25 then 30
    else 10
  end +
  case
    when sum(complaints_count) > 500 then 30
    when sum(complaints_count) > 200 then 20
    else 10
  end as risk_score
from last_90_days
group by company, state;


create or replace view v_company_risk_scores as
select *
from company_risk_scores
order by risk_score desc;

