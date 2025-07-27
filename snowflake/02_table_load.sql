CREATE OR REPLACE TABLE raw_cfpb_complaints_json (
  raw VARIANT
);

create or replace pipe my_snowpipe 
as
copy into raw_cfpb_complaints
from @my_blob_stage
file_format = (type = 'json');




