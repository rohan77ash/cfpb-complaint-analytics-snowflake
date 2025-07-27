create or replace table cfpb.data.raw_cfpb_complaints_csv (
  date_received DATE,
  product STRING,
  sub_product STRING,
  issue STRING,
  sub_issue STRING,
  narrative STRING,
  company_response STRING,
  company STRING,
  state STRING,
  zip_code STRING,
  tags STRING,
  consumer_consent STRING,
  submitted_via STRING,
  date_sent_to_company DATE,
  company_response_to_consumer STRING,
  timely_response STRING,
  consumer_disputed STRING,
  complaint_id STRING
);

copy into raw_cfpb_complaints_csv
from @raw_cfpb_stage
file_format = (type = 'CSV');

CREATE OR REPLACE TABLE raw_cfpb_complaints (
  raw VARIANT
);

copy into raw_cfpb_complaints_json
from @raw_cfpb_stage
file_format = (type = 'JSON');


