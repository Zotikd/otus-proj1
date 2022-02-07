{{
    config (
      engine='MergeTree()',
      order_by='PROMO_TYPE_ID',
	  unique_key='PROMO_TYPE_ID'
    )
}}


SELECT DISTINCT PROMO_TYPE_ID,
CASE 
	WHEN PROMO_TYPE_ID = 666
	THEN 'событийные промо'
	WHEN PROMO_TYPE_ID = 401
	THEN 'скидка на полке'
	WHEN PROMO_TYPE_ID = 300
	THEN 'товар дня'
	WHEN PROMO_TYPE_ID = 204
	THEN 'x+y'
	WHEN PROMO_TYPE_ID = 203
	THEN 'подарок'
	WHEN PROMO_TYPE_ID = 110
	THEN 'промо на товар'
	WHEN PROMO_TYPE_ID = 107
	THEN 'лотерея'
	WHEN PROMO_TYPE_ID = 105
	THEN 'акция'
	WHEN PROMO_TYPE_ID = 109
	THEN 'именные'
	WHEN PROMO_TYPE_ID = 108
	THEN 'геворги'
	WHEN PROMO_TYPE_ID = 400
	THEN 'глубокая скидка'
	WHEN PROMO_TYPE_ID = 402
	THEN 'распродажа'
	WHEN PROMO_TYPE_ID = -1
	THEN 'правка'
	WHEN PROMO_TYPE_ID = 0
	THEN 'нет промо'
END AS PROMO_TYPE_NM 
FROM otusproj.dds_promo

