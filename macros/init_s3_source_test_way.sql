{% macro init_s3_source_test_way() -%}

    {% set sql %}

		CREATE TABLE otusproj.SRC_TEST_WAY
		(
			ID 		Int64,
			WAY 	String,
			TRA 	String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_TEST_WAY.csv', 'CSVWithNames')
		;

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}