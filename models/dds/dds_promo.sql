{{
    config (
      engine='MergeTree()',
      order_by=['PROMO_ID','PRODUCT_ID','STORE_LOCATION_ID', 'PERIOD_START_DT', 'CREATED_DTTM'],
	  unique_key=['PROMO_ID', 'PROMO_NM', 'PRODUCT_ID', 'STORE_LOCATION_ID', 'PERIOD_START_DT', 'PROMO_TYPE_ID', 'STORE_LOCATION_FORMAT', 'PROMO_DISCOUNT_PRC', 'CREATED_DTTM']
    )
}}

{% if is_incremental() %}

  with tmp as (
    select 	if(t1.PROMO_ID>t2.PROMO_ID,t1.PROMO_ID,t2.PROMO_ID) as PROMO_ID,
			if(t1.PROMO_NM>t2.PROMO_NM,t1.PROMO_NM,t2.PROMO_NM) as PROMO_NM,
			if(t1.PROMO_SUBTYPE_NM>t2.PROMO_SUBTYPE_NM,t1.PROMO_SUBTYPE_NM,t2.PROMO_SUBTYPE_NM) as PROMO_SUBTYPE_NM,
			if(t1.PRODUCT_ID>t2.PRODUCT_ID,t1.PRODUCT_ID,t2.PRODUCT_ID) as PRODUCT_ID,
			if(t1.STORE_LOCATION_ID>t2.STORE_LOCATION_ID,t1.STORE_LOCATION_ID,t2.STORE_LOCATION_ID) as STORE_LOCATION_ID,
			if(t1.STORE_LOCATION_FORMAT>t2.STORE_LOCATION_FORMAT,t1.STORE_LOCATION_FORMAT,t2.STORE_LOCATION_FORMAT) as STORE_LOCATION_FORMAT,
			if(t1.PERIOD_START_DT>t2.PERIOD_START_DT,t1.PERIOD_START_DT,t2.PERIOD_START_DT) as PERIOD_START_DT,
			if(t1.PERIOD_END_DT>t2.PERIOD_END_DT,t1.PERIOD_END_DT,t2.PERIOD_END_DT) as PERIOD_END_DT,
			if(t1.PROMO_TYPE_ID>t2.PROMO_TYPE_ID,t1.PROMO_TYPE_ID,t2.PROMO_TYPE_ID) as PROMO_TYPE_ID,
			if(t1.PROMO_POS_TYPE>t2.PROMO_POS_TYPE,t1.PROMO_POS_TYPE,t2.PROMO_POS_TYPE) as PROMO_POS_TYPE,
			if(t1.PROMO_DISCOUNT_AMT>t2.PROMO_DISCOUNT_AMT,t1.PROMO_DISCOUNT_AMT,t2.PROMO_DISCOUNT_AMT) as PROMO_DISCOUNT_AMT,
			if(t1.PROMO_DISCOUNT_PRC>t2.PROMO_DISCOUNT_PRC,t1.PROMO_DISCOUNT_PRC,t2.PROMO_DISCOUNT_PRC) as PROMO_DISCOUNT_PRC,
			if(t1.DYNAMIC_DISCOUNT_FLG>t2.DYNAMIC_DISCOUNT_FLG,t1.DYNAMIC_DISCOUNT_FLG,t2.DYNAMIC_DISCOUNT_FLG) as DYNAMIC_DISCOUNT_FLG,
			if(t1.PROMO_CONDITION>t2.PROMO_CONDITION,t1.PROMO_CONDITION,t2.PROMO_CONDITION) as PROMO_CONDITION,
			if(t1.PRICE>t2.PRICE,t1.PRICE,t2.PRICE) as PRICE,
			if(t1.PROMO_DESCRIPTION>t2.PROMO_DESCRIPTION,t1.PROMO_DESCRIPTION,t2.PROMO_DESCRIPTION) as PROMO_DESCRIPTION,
			if(t1.PCODE_WORD>t2.PCODE_WORD,t1.PCODE_WORD,t2.PCODE_WORD) as PCODE_WORD,
			if(t1.PCODE_IS_AUTO_GEN_FLG>t2.PCODE_IS_AUTO_GEN_FLG,t1.PCODE_IS_AUTO_GEN_FLG,t2.PCODE_IS_AUTO_GEN_FLG) as PCODE_IS_AUTO_GEN_FLG,
			if(t1.PCODE_ACT_LMT>t2.PCODE_ACT_LMT,t1.PCODE_ACT_LMT,t2.PCODE_ACT_LMT) as PCODE_ACT_LMT,
			if(t1.PCODE_ACCU_AMT_LMT>t2.PCODE_ACCU_AMT_LMT,t1.PCODE_ACCU_AMT_LMT,t2.PCODE_ACCU_AMT_LMT) as PCODE_ACCU_AMT_LMT,
			if(t1.PCODE_CHECK_AMT_LMT>t2.PCODE_CHECK_AMT_LMT,t1.PCODE_CHECK_AMT_LMT,t2.PCODE_CHECK_AMT_LMT) as PCODE_CHECK_AMT_LMT,
			if(t1.PCODE_RED_PRICE_FLG>t2.PCODE_RED_PRICE_FLG,t1.PCODE_RED_PRICE_FLG,t2.PCODE_RED_PRICE_FLG) as PCODE_RED_PRICE_FLG,
			if(t1.PCODE_PER_FLG>t2.PCODE_PER_FLG,t1.PCODE_PER_FLG,t2.PCODE_PER_FLG) as PCODE_PER_FLG,
			if(t1.CREATED_DTTM>t2.CREATED_DTTM,t1.CREATED_DTTM,t2.CREATED_DTTM) as CREATED_DTTM,
			if(t1.MODIFIED_DTTM>t2.MODIFIED_DTTM,t1.MODIFIED_DTTM,t2.MODIFIED_DTTM) as MODIFIED_DTTM,
			if(t1.CREATED_PCS_ID>t2.CREATED_PCS_ID,t1.CREATED_PCS_ID,t2.CREATED_PCS_ID) as CREATED_PCS_ID,
			if(t1.MODIFIED_PCS_ID>t2.MODIFIED_PCS_ID,t1.MODIFIED_PCS_ID,t2.MODIFIED_PCS_ID) as MODIFIED_PCS_ID,
			if(t1.DELETE_FLG>t2.DELETE_FLG,t1.DELETE_FLG,t2.DELETE_FLG) as DELETE_FLG
	from {{ ref('stg_promo') }} as t1 
	full join {{ this }} as t2
	on t1.PROMO_ID = t2.PROMO_ID
	and t1.PROMO_NM = t2.PROMO_NM
	and t1.PRODUCT_ID = t2.PRODUCT_ID
	and t1.STORE_LOCATION_ID = t2.STORE_LOCATION_ID
	and t1.PERIOD_START_DT = t2.PERIOD_START_DT
	and t1.PROMO_TYPE_ID = t2.PROMO_TYPE_ID
	and t1.STORE_LOCATION_FORMAT = t2.STORE_LOCATION_FORMAT
	and t1.PROMO_DISCOUNT_PRC = t2.PROMO_DISCOUNT_PRC
	and t1.CREATED_DTTM = t2.CREATED_DTTM
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_promo') }} 
)

{% endif %}

select *
from tmp