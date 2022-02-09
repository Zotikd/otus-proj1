#!/bin/bash
cd /home/rusdnz/otus-proj1/

/home/rusdnz/.local/bin/dbt run --select tmp_daily_pos 
/home/rusdnz/.local/bin/dbt run --select tmp_daily_pos_flg
/home/rusdnz/.local/bin/dbt run --select tmp_daily_promo_curr
/home/rusdnz/.local/bin/dbt run --select tmp_daily_total_curr
/home/rusdnz/.local/bin/dbt run --select tmp_cnt_promo_before
/home/rusdnz/.local/bin/dbt run --select tmp_cnt_promo_curr
/home/rusdnz/.local/bin/dbt run --select tmp_correction_cnt_ord
/home/rusdnz/.local/bin/dbt run --select tmp_daily_pos_curr
/home/rusdnz/.local/bin/dbt run --select tmp_daily_pos_before
/home/rusdnz/.local/bin/dbt run --select tmp_promo_type