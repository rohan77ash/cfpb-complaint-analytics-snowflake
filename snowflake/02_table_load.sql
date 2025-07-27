CREATE OR REPLACE TABLE raw_cfpb_complaints_json (
  raw VARIANT
);

copy into raw_cfpb_complaints_json
from @raw_cfpb_stage
file_format = (type = 'JSON');


