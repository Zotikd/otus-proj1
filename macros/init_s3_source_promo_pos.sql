{% macro init_s3_source_promo_pos() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}