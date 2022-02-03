{% macro init_s3_sources() -%}

    {% set sql %}

		CREATE TABLE otusproj.SRC_PRODUCT
		(
			PRODUCT_ID 			Int64,
			PRODUCT_CD 			String,
			PRODUCT_NM 			String,
			RT_CD 				String,
			RT_NM 				String,
			PRODUCT_LVL_ID1 	Int64,
			PRODUCT_LVL_CD1 	String,
			PRODUCT_LVL_NM1 	String,
			PRODUCT_LVL_ID2 	Int64,
			PRODUCT_LVL_CD2 	String,
			PRODUCT_LVL_NM2 	String,
			PRODUCT_LVL_ID3 	Int64,
			PRODUCT_LVL_CD3 	String,
			PRODUCT_LVL_NM3 	String,
			PRODUCT_LVL_ID4 	Int64,
			PRODUCT_LVL_CD4 	String,
			PRODUCT_LVL_NM4 	String,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			HASH_VAL 			UInt64
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_PRODUCT.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_STORE_LOCATION
		(
			STORE_LOCATION_ID 			Int64,
			STORE_LOCATION_CD 			String,
			STORE_LOCATION_NM 			String,
			STORE_LOCATION_LVL_ID1 		Int64,
			STORE_LOCATION_LVL_CD1 		String,
			STORE_LOCATION_LVL_NM1 		String,
			STORE_LOCATION_LVL_ID2 		Int64,
			STORE_LOCATION_LVL_CD2 		String,
			STORE_LOCATION_LVL_NM2 		String,
			STORE_LOCATION_LVL_ID3 		Int64,
			STORE_LOCATION_LVL_CD3 		String,
			STORE_LOCATION_LVL_NM3 		String,
			STORE_OPEN_DT 				Date,
			STORE_CLOSE_DT 				Date,
			ACTUAL_STORE_FLG 			String,
			STORE_IN_SCOPE_FLG 			String,
			CREATED_DTTM 				DateTime64(3),
			MODIFIED_DTTM 				DateTime64(3),
			CREATED_PCS_ID 				Int64,
			MODIFIED_PCS_ID 			Int64,
			HASH_VAL 					Int64
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_STORE_LOCATION.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_STORE_LOC_ATTR
		(
			STORE_LOCATION_ID 		Int64,
			STORE_ATTR_CD 			String,
			STORE_ATTR_NM 			String,
			STORE_ATTR_VL 			String,
			CREATED_DTTM 			DateTime64(3),
			MODIFIED_DTTM 			DateTime64(3),
			CREATED_PCS_ID 			Int64,
			MODIFIED_PCS_ID 		Int64,
			HASH_VAL 				UInt32
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_STORE_LOC_ATTR.csv', 'CSVWithNames')
		;
		
		CREATE TABLE otusproj.SRC_PRICE
		(
			PRODUCT_ID 			Int64,
			STORE_LOCATION_ID 	Int64,
			PERIOD_START_DT 	Date,
			PERIOD_END_DT 		Date,
			PRICE 				Float32,
			UNIT 				String,
			PRICE_TYPE_ID 		Int64,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			DELETE_FLG 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_PRICE.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_PRICE_TYPE
		(
			PRICE_TYPE_ID 		Int64,
			PRICE_TYPE_NM 		String,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			HASH_VAL 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_PRICE_TYPE.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_PROMO
		(
			PROMO_ID 				Int64,
			PROMO_NM 				String,
			PROMO_SUBTYPE_NM 		String,
			PRODUCT_ID 				Int64,
			STORE_LOCATION_ID 		Int64,
			STORE_LOCATION_FORMAT 	String,
			PERIOD_START_DT 		Date,
			PERIOD_END_DT 			Date,
			PROMO_TYPE_ID 			Int64,
			PROMO_POS_TYPE 			String,
			PROMO_DISCOUNT_AMT 		Float32,
			PROMO_DISCOUNT_PRC 		Float32,
			DYNAMIC_DISCOUNT_FLG 	String,
			PROMO_CONDITION 		String,
			PRICE 					Float32,
			PROMO_DESCRIPTION 		String,
			PCODE_WORD 				String,
			PCODE_IS_AUTO_GEN_FLG 	String,
			PCODE_ACT_LMT 			Float32,
			PCODE_ACCU_AMT_LMT 		Float32,
			PCODE_CHECK_AMT_LMT 	Float32,
			PCODE_RED_PRICE_FLG 	String,
			PCODE_PER_FLG 			String,
			CREATED_DTTM 			DateTime64(3),
			MODIFIED_DTTM 			DateTime64(3),
			CREATED_PCS_ID 			Int64,
			MODIFIED_PCS_ID 		Int64,
			DELETE_FLG 				String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_PROMO.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_POS_HEAD
		(
			POS_ID 				Int64,
			POS_DT 				Date,
			ORDER_STORE_LOC_ID 	Int64,
			CARD_NM 			String,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			DELETE_FLG 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_POS_HEAD.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_PROMO_POS
		(
			POS_ID 				Int64,
			POS_POS_NUM 		Int64,
			PRODUCT_ID 			Int64,
			PROMO_ID 			Int64,
			PRIORITY_NUM 		Int64,
			PRICE_ACCUMULATED 	Float32,
			DELTA_DISCOUNT 		Float32,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			DELETE_FLG 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_PROMO_POS.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_POS_BODY
		(
			POS_ID 				Int64,
			POS_POS_NUM 		Int64,
			INV_CD 				String,
			INV_POS_NUM 		String,
			PRODUCT_ID 			Int64,
			PICKUP_STORE_LOC_ID Int64,
			PICKUP_DT 			Date,
			SERVICE_FLG 		String,
			INV_DT 				Date,
			OPERATION_TYPE 		String,
			ORIG_POS_ID 		Int64,
			ORIG_POS_POS_NUM 	Int64,
			STORNO_INV_CD 		String,
			UNIT 				String,
			COST 				Float32,
			COST_PRODUCT 		Float32,
			COST_FREIGHT 		Float32,
			COST_DELIVERY 		Float32,
			SALES_QTY 			Float32,
			UNIT_BASE 			String,
			SALES_QTY_BASE 		Float32,
			REVENUE 			Float32,
			REVENUE_WITH_VAT 	Float32,
			DISCOUNT_CARD 		Float32,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			DELETE_FLG 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_POS_BODY.csv', 'CSVWithNames')
		;

		CREATE TABLE otusproj.SRC_STOCK
		(
			PRODUCT_ID 			Int64,
			STORE_LOCATION_ID 	Int64,
			PERIOD_START_DT 	Date,
			STOCK_TYPE 			String,
			STOCK_SALE_TYPE 	String,
			STOCK_QTY 			Float32,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			DELETE_FLG 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_STOCK.csv', 'CSVWithNames')
		;

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}