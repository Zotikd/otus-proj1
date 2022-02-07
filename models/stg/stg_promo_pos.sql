{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['POS_ID','PRODUCT_ID','PROMO_ID','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_PROMO_POS')) }}

from {{ source('projdb', 'IN_PROMO_POS') }}