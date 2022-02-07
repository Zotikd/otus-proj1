{{
    config (
      engine='MergeTree()',
      order_by=['PRODUCT_ID', 'STORE_LOCATION_ID', 'PERIOD_START_DT', 'STOCK_TYPE', 'STOCK_SALE_TYPE', 'CREATED_DTTM'],
	  unique_key=['PRODUCT_ID', 'STORE_LOCATION_ID', 'PERIOD_START_DT', 'STOCK_TYPE', 'STOCK_SALE_TYPE', 'CREATED_DTTM']
    )
}}

{% if is_incremental() %}

  with tmp as (
    select 	if(t1.PRODUCT_ID>t2.PRODUCT_ID,t1.PRODUCT_ID,t2.PRODUCT_ID) as PRODUCT_ID,
			if(t1.STORE_LOCATION_ID>t2.STORE_LOCATION_ID,t1.STORE_LOCATION_ID,t2.STORE_LOCATION_ID) as STORE_LOCATION_ID,
			if(t1.PERIOD_START_DT>t2.PERIOD_START_DT,t1.PERIOD_START_DT,t2.PERIOD_START_DT) as PERIOD_START_DT,
			if(t1.STOCK_TYPE>t2.STOCK_TYPE,t1.STOCK_TYPE,t2.STOCK_TYPE) as STOCK_TYPE,
			if(t1.STOCK_SALE_TYPE>t2.STOCK_SALE_TYPE,t1.STOCK_SALE_TYPE,t2.STOCK_SALE_TYPE) as STOCK_SALE_TYPE,
			if(t1.STOCK_QTY>t2.STOCK_QTY,t1.STOCK_QTY,t2.STOCK_QTY) as STOCK_QTY,
			if(t1.CREATED_DTTM>t2.CREATED_DTTM,t1.CREATED_DTTM,t2.CREATED_DTTM) as CREATED_DTTM,
			if(t1.MODIFIED_DTTM>t2.MODIFIED_DTTM,t1.MODIFIED_DTTM,t2.MODIFIED_DTTM) as MODIFIED_DTTM,
			if(t1.CREATED_PCS_ID>t2.CREATED_PCS_ID,t1.CREATED_PCS_ID,t2.CREATED_PCS_ID) as CREATED_PCS_ID,
			if(t1.MODIFIED_PCS_ID>t2.MODIFIED_PCS_ID,t1.MODIFIED_PCS_ID,t2.MODIFIED_PCS_ID) as MODIFIED_PCS_ID,
			if(t1.DELETE_FLG>t2.DELETE_FLG,t1.DELETE_FLG,t2.DELETE_FLG) as DELETE_FLG
	from {{ ref('stg_stock') }} as t1 
	full join {{ this }} as t2
	on t1.PRODUCT_ID = t2.PRODUCT_ID 
	and t1.STORE_LOCATION_ID = t2.STORE_LOCATION_ID
	and t1.PERIOD_START_DT = t2.PERIOD_START_DT
	and t1.STOCK_TYPE = t2.STOCK_TYPE
	and t1.STOCK_SALE_TYPE = t2.STOCK_SALE_TYPE
	and t1.CREATED_DTTM = t2.CREATED_DTTM
  )

{% else %}

  with tmp as (
    select *
	from {{ ref('stg_stock') }} 
)

{% endif %}

select *
from tmp