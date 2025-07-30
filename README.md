# cfpb-complaint-analytics-snowflake
Complaint spike monitoring and risk scoring based on company and region through Consumer financial protection bureau US data using Snowflake and azure data pipelines.
Data is ingested into snowflake by first using REST api call triggered daily by an Azure data factory pipeline to store data in an external stage (Azure data lake storage) which is then copied into a raw table. 
A task runs 5 mins after the ADF trigger run which updates the final metrics tables and views  
