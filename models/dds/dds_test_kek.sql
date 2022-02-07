{{
    config (
      engine='MergeTree()',
      order_by=['ID','CREATED_DTTM'],
	  unique_key=['ID','CREATED_DTTM']
    )
}}

{% if is_incremental() %}

  with tmp as (
    select if(t1.ID>t2.ID,t1.ID,t2.ID) as ID, if(t1.NM>t2.NM, t1.NM, t2.NM) as NM, if(t1.CREATED_DTTM>t2.CREATED_DTTM, t1.CREATED_DTTM, t2.CREATED_DTTM) as CREATED_DTTM
	from {{ ref('stg_test_kek') }} as t1 
	full join {{ this }} as t2
	on t1.ID = t2.ID
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_test_kek') }} 
)

{% endif %}

select *
from tmp