{% macro init_s3_source_stock() -%}

    {% set sql %}

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