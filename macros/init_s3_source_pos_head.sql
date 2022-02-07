{% macro init_s3_source_pos_head() -%}

    {% set sql %}

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

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}