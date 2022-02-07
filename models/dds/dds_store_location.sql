{{
    config (
      engine='MergeTree()',
      order_by=['STORE_LOCATION_ID', 'CREATED_DTTM'],
	  unique_key=['STORE_LOCATION_ID', 'CREATED_DTTM']
    )
}}

{% if is_incremental() %}

  with tmp as (
    select 	if(t1.STORE_LOCATION_ID>t2.STORE_LOCATION_ID,t1.STORE_LOCATION_ID,t2.STORE_LOCATION_ID) as STORE_LOCATION_ID,
			if(t1.STORE_LOCATION_CD>t2.STORE_LOCATION_CD,t1.STORE_LOCATION_CD,t2.STORE_LOCATION_CD) as STORE_LOCATION_CD,
			if(t1.STORE_LOCATION_NM>t2.STORE_LOCATION_NM,t1.STORE_LOCATION_NM,t2.STORE_LOCATION_NM) as STORE_LOCATION_NM,
			if(t1.STORE_LOCATION_LVL_ID1>t2.STORE_LOCATION_LVL_ID1,t1.STORE_LOCATION_LVL_ID1,t2.STORE_LOCATION_LVL_ID1) as STORE_LOCATION_LVL_ID1,
			if(t1.STORE_LOCATION_LVL_CD1>t2.STORE_LOCATION_LVL_CD1,t1.STORE_LOCATION_LVL_CD1,t2.STORE_LOCATION_LVL_CD1) as STORE_LOCATION_LVL_CD1,
			if(t1.STORE_LOCATION_LVL_NM1>t2.STORE_LOCATION_LVL_NM1,t1.STORE_LOCATION_LVL_NM1,t2.STORE_LOCATION_LVL_NM1) as STORE_LOCATION_LVL_NM1,
			if(t1.STORE_LOCATION_LVL_ID2>t2.STORE_LOCATION_LVL_ID2,t1.STORE_LOCATION_LVL_ID2,t2.STORE_LOCATION_LVL_ID2) as STORE_LOCATION_LVL_ID2,
			if(t1.STORE_LOCATION_LVL_CD2>t2.STORE_LOCATION_LVL_CD2,t1.STORE_LOCATION_LVL_CD2,t2.STORE_LOCATION_LVL_CD2) as STORE_LOCATION_LVL_CD2,
			if(t1.STORE_LOCATION_LVL_NM2>t2.STORE_LOCATION_LVL_NM2,t1.STORE_LOCATION_LVL_NM2,t2.STORE_LOCATION_LVL_NM2) as STORE_LOCATION_LVL_NM2,
			if(t1.STORE_LOCATION_LVL_ID3>t2.STORE_LOCATION_LVL_ID3,t1.STORE_LOCATION_LVL_ID3,t2.STORE_LOCATION_LVL_ID3) as STORE_LOCATION_LVL_ID3,
			if(t1.STORE_LOCATION_LVL_CD3>t2.STORE_LOCATION_LVL_CD3,t1.STORE_LOCATION_LVL_CD3,t2.STORE_LOCATION_LVL_CD3) as STORE_LOCATION_LVL_CD3,
			if(t1.STORE_LOCATION_LVL_NM3>t2.STORE_LOCATION_LVL_NM3,t1.STORE_LOCATION_LVL_NM3,t2.STORE_LOCATION_LVL_NM3) as STORE_LOCATION_LVL_NM3,
			if(t1.STORE_OPEN_DT>t2.STORE_OPEN_DT,t1.STORE_OPEN_DT,t2.STORE_OPEN_DT) as STORE_OPEN_DT,
			if(t1.STORE_CLOSE_DT>t2.STORE_CLOSE_DT,t1.STORE_CLOSE_DT,t2.STORE_CLOSE_DT) as STORE_CLOSE_DT,
			if(t1.ACTUAL_STORE_FLG>t2.ACTUAL_STORE_FLG,t1.ACTUAL_STORE_FLG,t2.ACTUAL_STORE_FLG) as ACTUAL_STORE_FLG,
			if(t1.STORE_IN_SCOPE_FLG>t2.STORE_IN_SCOPE_FLG,t1.STORE_IN_SCOPE_FLG,t2.STORE_IN_SCOPE_FLG) as STORE_IN_SCOPE_FLG,
			if(t1.CREATED_DTTM>t2.CREATED_DTTM,t1.CREATED_DTTM,t2.CREATED_DTTM) as CREATED_DTTM,
			if(t1.MODIFIED_DTTM>t2.MODIFIED_DTTM,t1.MODIFIED_DTTM,t2.MODIFIED_DTTM) as MODIFIED_DTTM,
			if(t1.CREATED_PCS_ID>t2.CREATED_PCS_ID,t1.CREATED_PCS_ID,t2.CREATED_PCS_ID) as CREATED_PCS_ID,
			if(t1.MODIFIED_PCS_ID>t2.MODIFIED_PCS_ID,t1.MODIFIED_PCS_ID,t2.MODIFIED_PCS_ID) as MODIFIED_PCS_ID,
			if(t1.HASH_VAL>t2.HASH_VAL,t1.HASH_VAL,t2.HASH_VAL) as HASH_VAL
	from {{ ref('stg_store_location') }} as t1 
	full join {{ this }} as t2
	on t1.STORE_LOCATION_ID = t2.STORE_LOCATION_ID 
	and t1.CREATED_DTTM = t2.CREATED_DTTM
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_store_location') }} 
)

{% endif %}

select *
from tmp