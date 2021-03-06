{{
    config (
      engine='MergeTree()',
      order_by=['PRODUCT_ID', 'STORE_LOCATION_ID','PROMO_TYPE_ID', 'DATE_CURR'],
	  unique_key=['PRODUCT_ID', 'STORE_LOCATION_ID','PROMO_TYPE_ID', 'DATE_CURR']
    )
}}

SELECT T1.STORE_LOCATION_ID as STORE_LOCATION_ID, T1.PROMO_TYPE_ID as PROMO_TYPE_ID ,T1.PRODUCT_ID as PRODUCT_ID
	,toStartOfMonth(T1.DATE) as DATE_CURR
	,COUNT(1) as CNT_ORD_BY_PROMO
FROM otusproj.tmp_daily_pos AS T1
WHERE T1.PERIOD_TYPE = 'CURR' 
GROUP BY T1.STORE_LOCATION_ID, T1.PROMO_TYPE_ID, T1.PRODUCT_ID, DATE_CURR