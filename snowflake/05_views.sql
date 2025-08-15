create or replace view cfpb.data.v_complaint_daily_summary as
select * from cfpb.data.complaint_daily_summary;

create or replace view cfpb.data.v_complaint_spikes as
select * from cfpb.data.complaint_spikes;


create or replace view v_company_risk_scores as
select *
from company_risk_scores
order by risk_score desc;


create or replace view cfpb.data.v_company_top_issues as
with risky_companies as (
  select company, state, risk_score
  from cfpb.data.company_risk_scores
  where risk_score >= 50
),
issue_breakdown as (
  select
    rc.company,
    s.state,
    s.issue,
    count(*) as complaints_count
  from risky_companies rc
  join cfpb.data.staging_cfpb_complaints s
    on rc.company = s.company and rc.state = s.state
  where s.date_received >= dateadd(month, -3, current_date)
  group by rc.company, s.state, s.issue
)
select
  company,
  state,
  issue,
  complaints_count
from issue_breakdown
order by complaints_count desc;
