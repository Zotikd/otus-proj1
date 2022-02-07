{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['PROMO_ID','PRODUCT_ID','STORE_LOCATION_ID','PERIOD_START_DT','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_PROMO')) }}

from {{ source('projdb', 'IN_PROMO') }}