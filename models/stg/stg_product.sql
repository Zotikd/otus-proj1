{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['PRODUCT_ID','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_PRODUCT')) }}

from {{ source('projdb', 'IN_PRODUCT') }}