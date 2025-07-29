create or replace view cfpb.data.v_complaint_daily_summary as
select * from cfpb.data.complaint_daily_summary;

create or replace view cfpb.data.v_complaint_spikes as
select * from cfpb.data.complaint_spikes;

create or replace view v_company_risk_scores as
select *
from company_risk_scores
order by risk_score desc;

