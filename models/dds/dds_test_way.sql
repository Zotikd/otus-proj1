{{
    config (
      engine='MergeTree()',
      order_by='ID',
	  unique_key='ID'
    )
}}


{% if is_incremental() %}

  with tmp as (
    select if(t1.ID>t2.ID,t1.ID,t2.ID) as ID, if(t1.WAY>t2.WAY, t1.WAY, t2.WAY) as WAY, if(t1.TRA>t2.TRA, t1.TRA, t2.TRA) as TRA
	from {{ ref('stg_test_way') }} as t1 
	full join {{ this }} as t2
	on t1.ID = t2.ID
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_test_way') }} 
)

{% endif %}

select *
from tmp