{{
    config (
      engine='MergeTree()',
      order_by=['POS_ID', 'CREATED_DTTM'],
	  unique_key=['POS_ID', 'CREATED_DTTM']
    )
}}

{% if is_incremental() %}

  with tmp as (
    select 	if(t1.POS_ID>t2.POS_ID,t1.POS_ID,t2.POS_ID) as POS_ID,
			if(t1.POS_DT>t2.POS_DT,t1.POS_DT,t2.POS_DT) as POS_DT,
			if(t1.ORDER_STORE_LOC_ID>t2.ORDER_STORE_LOC_ID,t1.ORDER_STORE_LOC_ID,t2.ORDER_STORE_LOC_ID) as ORDER_STORE_LOC_ID,
			if(t1.CARD_NM>t2.CARD_NM,t1.CARD_NM,t2.CARD_NM) as CARD_NM,
			if(t1.CREATED_DTTM>t2.CREATED_DTTM,t1.CREATED_DTTM,t2.CREATED_DTTM) as CREATED_DTTM,
			if(t1.MODIFIED_DTTM>t2.MODIFIED_DTTM,t1.MODIFIED_DTTM,t2.MODIFIED_DTTM) as MODIFIED_DTTM,
			if(t1.CREATED_PCS_ID>t2.CREATED_PCS_ID,t1.CREATED_PCS_ID,t2.CREATED_PCS_ID) as CREATED_PCS_ID,
			if(t1.MODIFIED_PCS_ID>t2.MODIFIED_PCS_ID,t1.MODIFIED_PCS_ID,t2.MODIFIED_PCS_ID) as MODIFIED_PCS_ID,
			if(t1.DELETE_FLG>t2.DELETE_FLG,t1.DELETE_FLG,t2.DELETE_FLG) as DELETE_FLG
	from {{ ref('stg_pos_head') }} as t1 
	full join {{ this }} as t2
	on t1.POS_ID = t2.POS_ID 
	and t1.CREATED_DTTM = t2.CREATED_DTTM
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_pos_head') }} 
)

{% endif %}

select *
from tmp