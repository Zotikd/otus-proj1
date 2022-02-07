{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['PRODUCT_ID','STORE_LOCATION_ID','PERIOD_START_DT','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_STOCK')) }}

from {{ source('projdb', 'IN_STOCK') }}