{% macro init_s3_source_pos_body() -%}

    {% set sql %}

		CREATE TABLE otusproj.SRC_POS_BODY
		(
			POS_ID 				Int64,
			POS_POS_NUM 		Int64,
			INV_CD 				String,
			INV_POS_NUM 		String,
			PRODUCT_ID 			Int64,
			PICKUP_STORE_LOC_ID Int64,
			PICKUP_DT 			Date,
			SERVICE_FLG 		String,
			INV_DT 				Date,
			OPERATION_TYPE 		String,
			ORIG_POS_ID 		Int64,
			ORIG_POS_POS_NUM 	Int64,
			STORNO_INV_CD 		String,
			UNIT 				String,
			COST 				Float32,
			COST_PRODUCT 		Float32,
			COST_FREIGHT 		Float32,
			COST_DELIVERY 		Float32,
			SALES_QTY 			Float32,
			UNIT_BASE 			String,
			SALES_QTY_BASE 		Float32,
			REVENUE 			Float32,
			REVENUE_WITH_VAT 	Float32,
			DISCOUNT_CARD 		Float32,
			CREATED_DTTM 		DateTime64(3),
			MODIFIED_DTTM 		DateTime64(3),
			CREATED_PCS_ID 		Int64,
			MODIFIED_PCS_ID 	Int64,
			DELETE_FLG 			String
		)
		ENGINE = S3('https://storage.yandexcloud.net/storage-proj/history/IN_POS_BODY.csv', 'CSVWithNames')
		;

    {% endset %}
    
    {% set table = run_query(sql) %}


{%- endmacro %}