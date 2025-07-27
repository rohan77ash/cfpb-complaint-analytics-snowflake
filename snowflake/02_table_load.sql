CREATE OR REPLACE TABLE raw_cfpb_complaints_json (
  raw VARIANT
);

create or replace pipe pipe_cfpb_raw_ingest 
as
copy into raw_cfpb_complaints
from @raw_cfpb_ext_stage
file_format = (type = 'json');

alter pipe pipe_cfpb_raw_ingest refresh;
