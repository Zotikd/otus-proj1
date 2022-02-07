{% macro init_s3_source_price_type() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}