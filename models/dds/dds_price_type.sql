{{
    config (
      engine='MergeTree()',
      order_by=['PRICE_TYPE_ID', 'CREATED_DTTM'],
	  unique_key=['PRICE_TYPE_ID', 'CREATED_DTTM']
    )
}}

{% if is_incremental() %}

  with tmp as (
    select  if(t1.PRICE_TYPE_ID>t2.PRICE_TYPE_ID,t1.PRICE_TYPE_ID,t2.PRICE_TYPE_ID) as PRICE_TYPE_ID,
			if(t1.PRICE_TYPE_NM>t2.PRICE_TYPE_NM,t1.PRICE_TYPE_NM,t2.PRICE_TYPE_NM) as PRICE_TYPE_NM,
			if(t1.CREATED_DTTM>t2.CREATED_DTTM,t1.CREATED_DTTM,t2.CREATED_DTTM) as CREATED_DTTM,
			if(t1.MODIFIED_DTTM>t2.MODIFIED_DTTM,t1.MODIFIED_DTTM,t2.MODIFIED_DTTM) as MODIFIED_DTTM,
			if(t1.CREATED_PCS_ID>t2.CREATED_PCS_ID,t1.CREATED_PCS_ID,t2.CREATED_PCS_ID) as CREATED_PCS_ID,
			if(t1.MODIFIED_PCS_ID>t2.MODIFIED_PCS_ID,t1.MODIFIED_PCS_ID,t2.MODIFIED_PCS_ID) as MODIFIED_PCS_ID,
			if(t1.HASH_VAL>t2.HASH_VAL,t1.HASH_VAL,t2.HASH_VAL) as HASH_VAL
	from {{ ref('stg_price_type') }} as t1 
	full join {{ this }} as t2
	on t1.PRICE_TYPE_ID = t2.PRICE_TYPE_ID 
	and t1.CREATED_DTTM = t2.CREATED_DTTM
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_price_type') }} 
)

{% endif %}

select *
from tmp