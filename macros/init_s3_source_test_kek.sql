{% macro init_s3_source_test_kek() -%}

    {% set sql %}

		CREATE TABLE otusproj.SRC_TEST_KEK
		(
			ID 				Int64,
			NM 				String,
			CREATED_DTTM 	DateTime64(3)
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_TEST_KEK.csv', 'CSVWithNames')
		;

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}