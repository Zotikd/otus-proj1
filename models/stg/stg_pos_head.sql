{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by=['POS_ID','MODIFIED_DTTM']
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_POS_HEAD')) }}

from {{ source('projdb', 'IN_POS_HEAD') }}