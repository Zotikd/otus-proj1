{{
    config (
      engine='MergeTree()',
      order_by=['POS_ID', 'PRODUCT_ID', 'STORE_LOCATION_ID'],
	  unique_key=['POS_ID', 'PRODUCT_ID', 'STORE_LOCATION_ID']
    )
}}

with in_pos_head_body as (

SELECT DISTINCT
	  b.POS_ID as POS_ID		
	, b.POS_POS_NUM as POS_POS_NUM 
	, b.INV_CD as INV_CD		
	, b.INV_POS_NUM as INV_POS_NUM
	, b.PRODUCT_ID as PRODUCT_ID	
	, h.ORDER_STORE_LOC_ID as ORDER_STORE_LOC_ID
	, h.POS_DT as POS_DT
	, b.SERVICE_FLG as SERVICE_FLG	
	, b.OPERATION_TYPE as OPERATION_TYPE
	, b.ORIG_POS_ID as ORIG_POS_ID 
	, b.ORIG_POS_POS_NUM as ORIG_POS_POS_NUM 
	, b.STORNO_INV_CD as STORNO_INV_CD
	, b.COST as COST 
	, b.SALES_QTY_BASE as SALES_QTY_BASE
	, b.REVENUE as REVENUE 	
	, b.REVENUE_WITH_VAT as REVENUE_WITH_VAT 
FROM otusproj.dds_pos_body b
INNER JOIN otusproj.dds_pos_head h 
	on b.POS_ID = h.POS_ID
INNER JOIN otusproj.dds_store_location as s
	on h.ORDER_STORE_LOC_ID = s.STORE_LOCATION_ID
	and  s.ACTUAL_STORE_FLG='Y' 
INNER JOIN otusproj.dds_product as p
	on b.PRODUCT_ID = p.PRODUCT_ID
WHERE POS_DT >=  date_sub(YEAR, 2, today())
and POS_DT >= s.STORE_OPEN_DT
and PRODUCT_ID <> 0
), 

pos_agg as (
SELECT POS_ID, ORIG_POS_ID, POS_POS_NUM , ORIG_POS_POS_NUM, PRODUCT_ID, POS_DT, ORDER_STORE_LOC_ID 
	,round(sum(SALES_QTY_BASE)) as SALES_QTY_BASE
	,round(sum(COST),2) as COST
	,round(sum(REVENUE),2) as REVENUE
	,round(sum(REVENUE_WITH_VAT),2)  as REVENUE_WITH_VAT
FROM in_pos_head_body
GROUP BY POS_ID
	,ORIG_POS_ID
	,POS_POS_NUM
	,ORIG_POS_POS_NUM 
	,PRODUCT_ID
	,POS_DT
	,ORDER_STORE_LOC_ID
),

vozvrat as (
SELECT ORDER_STORE_LOC_ID, ORIG_POS_ID, ORIG_POS_POS_NUM, PRODUCT_ID
	,round(sum(SALES_QTY_BASE)) as SALES_QTY_BASE
FROM in_pos_head_body
GROUP BY  
	ORDER_STORE_LOC_ID
	, ORIG_POS_ID
	, ORIG_POS_POS_NUM
	, PRODUCT_ID
),

pos_vozvrat as (
SELECT 
	A.POS_ID as POS_ID
	,A.POS_POS_NUM as POS_POS_NUM
	,A.PRODUCT_ID as PRODUCT_ID
	,A.ORDER_STORE_LOC_ID as ORDER_STORE_LOC_ID
	,A.POS_DT as POS_DT
	,B.SALES_QTY_BASE AS SALES_QTY
	,A.COST * B.SALES_QTY_BASE / A.SALES_QTY_BASE AS COST
	,A.REVENUE *  B.SALES_QTY_BASE / A.SALES_QTY_BASE AS REVENUE
	,A.REVENUE_WITH_VAT * B.SALES_QTY_BASE / A.SALES_QTY_BASE AS REVENUE_WITH_VAT
FROM pos_agg AS A
INNER JOIN vozvrat AS B 
	ON A.PRODUCT_ID = B.PRODUCT_ID
	AND A.ORDER_STORE_LOC_ID = B.ORDER_STORE_LOC_ID
	AND A.ORIG_POS_ID = B.ORIG_POS_ID
	AND A.ORIG_POS_POS_NUM = B.ORIG_POS_POS_NUM
WHERE A.POS_ID = A.ORIG_POS_ID
	AND B.SALES_QTY_BASE <> 0 
	AND A.SALES_QTY_BASE <> 0
)

SELECT 
	T1.POS_ID as POS_ID
	, T1.PRODUCT_ID as PRODUCT_ID
	, T1.ORDER_STORE_LOC_ID as STORE_LOCATION_ID
	, T1.POS_DT as DATE
	, T3.PROMO_TYPE_ID as PROMO_TYPE_ID
	, CASE WHEN T1.POS_DT >= date_sub(YEAR, 1, today()) THEN 'CURR'	ELSE 'BEFORE' END as PERIOD_TYPE
	, SUM(T1.COST) as COST
	, SUM(T1.SALES_QTY) as SALES_QTY
	, SUM(T1.REVENUE_WITH_VAT) as REVENUE 
	, SUM(T1.REVENUE_WITH_VAT) - SUM(T1.REVENUE) as VAT
FROM pos_vozvrat AS T1 
LEFT JOIN otusproj.dds_promo_pos AS T2
	ON  T1.POS_ID = T2.POS_ID
	AND T1.POS_POS_NUM = T2.POS_POS_NUM
LEFT JOIN (SELECT DISTINCT PROMO_ID, PROMO_TYPE_ID
			FROM otusproj.dds_promo
			WHERE PROMO_POS_TYPE = 'B') AS T3 
	ON T2.PROMO_ID = T3.PROMO_ID
GROUP BY 
	T1.POS_ID
	, T1.PRODUCT_ID
	, T1.ORDER_STORE_LOC_ID
	, T1.POS_DT
	, T3.PROMO_TYPE_ID
	, PERIOD_TYPE
