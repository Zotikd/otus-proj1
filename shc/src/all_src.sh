cd /home/rusdnz/otus-proj1

dbt run-operation init_s3_source_product
dbt run-operation init_s3_source_store_location
dbt run-operation init_s3_source_store_loc_attr
dbt run-operation init_s3_source_price
dbt run-operation init_s3_source_price_type
dbt run-operation init_s3_source_promo
dbt run-operation init_s3_source_pos_head
dbt run-operation init_s3_source_promo_pos
dbt run-operation init_s3_source_pos_body
dbt run-operation init_s3_source_stock
dbt run-operation init_s3_source_test_kek
dbt run-operation init_s3_source_test_way