create or replace table raw_cfpb_complaints (
  raw variant
);

copy into raw_cfpb_complaints
from @raw_cfpb_stage
file_format = (type = 'JSON');

