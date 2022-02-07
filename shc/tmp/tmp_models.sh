cd /home/rusdnz/otus-proj1

dbt run --select tmp_daily_pos 
dbt run --select tmp_daily_pos_flg
dbt run --select tmp_daily_promo_curr
dbt run --select tmp_daily_total_curr
dbt run --select tmp_cnt_promo_before
dbt run --select tmp_cnt_promo_curr
dbt run --select tmp_correction_cnt_ord
dbt run --select tmp_daily_pos_curr
dbt run --select tmp_daily_pos_before
dbt run --select tmp_promo_type