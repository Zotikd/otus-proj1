{% macro init_s3_source_promo() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}