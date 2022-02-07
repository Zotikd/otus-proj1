{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['STORE_LOCATION_ID','STORE_ATTR_CD','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_STORE_LOC_ATTR')) }}

from {{ source('projdb', 'IN_STORE_LOC_ATTR') }}