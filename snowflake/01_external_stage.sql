create or replace storage integration si_blob
  type = external_stage
  storage_provider = 'azure'
  enabled = true
  azure_tenant_id = '12345678-90ab-cdef-1234-567890abcdef'
  storage_allowed_locations = ('azure://cfpbdatastorage.blob.core.windows.net/landing-ext-stage/raw');

create or replace stage raw_cfpb_ext_stage
  url = 'azure://cfpbdatastorage.blob.core.windows.net/landing-ext-stage/raw'
  storage_integration = my_blob_integration
  file_format = (type = 'JSON');
