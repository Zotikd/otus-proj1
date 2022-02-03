{{
    config (
      engine='MergeTree()',
      order_by='PRODUCT_ID'
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_PRODUCT')) }}

from {{ source('projdb', 'IN_PRODUCT') }}