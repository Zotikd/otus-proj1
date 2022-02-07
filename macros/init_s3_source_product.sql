{% macro init_s3_source_product() -%}

    {% set sql %}

		CREATE TABLE otusproj.SRC_PRODUCT
		(
			PRODUCT_ID 			Int64,
			PRODUCT_CD 			String,
			PRODUCT_NM 			String,
			RT_CD 				String,
			RT_NM 				String,
			PRODUCT_LVL_ID1 	Int64,
			PRODUCT_LVL_CD1 	String,
			PRODUCT_LVL_NM1 	String,
			PRODUCT_LVL_ID2 	Int64,
			PRODUCT_LVL_CD2 	String,
			PRODUCT_LVL_NM2 	String,
			PRODUCT_LVL_ID3 	Int64,
			PRODUCT_LVL_CD3 	String,
			PRODUCT_LVL_NM3 	String,
			PRODUCT_LVL_ID4 	Int64,
			PRODUCT_LVL_CD4 	String,
			PRODUCT_LVL_NM4 	String,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			HASH_VAL 			UInt64
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_PRODUCT.csv', 'CSVWithNames')
		;

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}