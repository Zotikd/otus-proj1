{{
    config (
	  materialized='table',
      engine='MergeTree()',
      order_by='ID'
    )
}}

select 

  {{ dbt_utils.star(from=source('projdb', 'IN_TEST_KEK')) }}

from {{ source('projdb', 'IN_TEST_KEK') }}