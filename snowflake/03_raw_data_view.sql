create or replace view cfpb.data.staging_cfpb_complaints as
select
  raw:"_id"::STRING as _id,
  raw:"_index"::STRING as _index,
  raw:"_type"::STRING as _type,
  raw:"_source":company::STRING as company,
  raw:"_source":company_public_response::STRING as company_public_response,
  raw:"_source":company_response::STRING as company_response,
  raw:"_source":complaint_id::STRING as complaint_id,
  raw:"_source":complaint_what_happened::STRING as complaint_what_happened,
  raw:"_source":consumer_consent_provided::STRING as consumer_consent_provided,
  raw:"_source":consumer_disputed::STRING as consumer_disputed,
  raw:"_source":date_received::DATE as date_received,
  raw:"_source":date_sent_to_company::DATE as date_sent_to_company,
  raw:"_source":issue::STRING as issue,
  raw:"_source":product::STRING as product,
  raw:"_source":state::STRING as state,
  raw:"_source":sub_issue::STRING as sub_issue,
  raw:"_source":sub_product::STRING as sub_product,
  raw:"_source":submitted_via::STRING as submitted_via,
  raw:"_source":tags::STRING as tags,
  raw:"_source":timely::STRING as timely,
  raw:"_source":zip_code::STRING as zip_code
from cfpb.data.raw_cfpb_complaints_json;
