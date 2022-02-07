{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['STORE_LOCATION_ID','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_STORE_LOCATION')) }}

from {{ source('projdb', 'IN_STORE_LOCATION') }}