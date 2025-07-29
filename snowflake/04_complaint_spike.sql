CREATE OR REPLACE TASK cfpb.data.daily_refresh_cfpb_pipeline
  WAREHOUSE = my_wh 
  SCHEDULE = 'USING CRON 0 5 * * * UTC'
AS
CREATE OR REPLACE TABLE cfpb.data.complaint_daily_summary AS
SELECT
  company,
  state,
  DATE_TRUNC('DAY', date_received) AS complaint_date,
  COUNT(*) AS complaints_count
FROM cfpb.data.staging_cfpb_complaints
GROUP BY company, state, complaint_date;
CREATE OR REPLACE TABLE cfpb.data.complaint_spikes AS
SELECT
  company,
  state,
  complaint_date,
  complaints_count,
  LAG(complaints_count) OVER (
    PARTITION BY company, state ORDER BY complaint_date
  ) AS prev_day_count,
  CASE
    WHEN LAG(complaints_count) OVER (
      PARTITION BY company, state ORDER BY complaint_date
    ) = 0 THEN NULL
    ELSE ROUND(
      ((complaints_count - LAG(complaints_count) OVER (
        PARTITION BY company, state ORDER BY complaint_date
      )) / LAG(complaints_count) OVER (
        PARTITION BY company, state ORDER BY complaint_date
      )) * 100, 2)
  END AS spike_pct
FROM cfpb.data.complaint_daily_summary;
CREATE OR REPLACE TABLE cfpb.data.company_risk_scores AS
WITH last_90_days AS (
  SELECT
    company,
    state,
    complaint_date,
    complaints_count,
    spike_pct
  FROM cfpb.data.complaint_spikes
  WHERE complaint_date >= DATEADD(DAY, -90, CURRENT_DATE)
)
SELECT
  company,
  state,
  AVG(spike_pct) AS avg_spike_pct,
  SUM(complaints_count) AS total_complaints_90d,
  CASE
    WHEN AVG(spike_pct) > 50 THEN 50
    WHEN AVG(spike_pct) > 25 THEN 30
    ELSE 10
  END +
  CASE
    WHEN SUM(complaints_count) > 500 THEN 30
    WHEN SUM(complaints_count) > 200 THEN 20
    ELSE 10
  END AS risk_score
FROM last_90_days
GROUP BY company, state;


create or replace view cfpb.data.v_complaint_daily_summary as
select * from cfpb.data.complaint_daily_summary;

create or replace view cfpb.data.v_complaint_spikes as
select * from cfpb.data.complaint_spikes;
