{% macro init_s3_source_store_loc_attr() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}