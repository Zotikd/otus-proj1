{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['PRICE_TYPE_ID','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_PRICE_TYPE')) }}

from {{ source('projdb', 'IN_PRICE_TYPE') }}