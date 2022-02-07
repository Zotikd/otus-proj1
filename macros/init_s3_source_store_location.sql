{% macro init_s3_source_store_location() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}