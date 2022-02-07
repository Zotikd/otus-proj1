{% macro init_s3_source_price() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}