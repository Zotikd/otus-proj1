from airflow import DAG
from airflow_dbt.operators.dbt_operator import (
    DbtSeedOperator,
    DbtSnapshotOperator,
    DbtRunOperator,
    DbtTestOperator
)
from airflow.utils.dates import days_ago

default_args = {
  'dir': '/home/rusdnz/otus-proj1',
  'start_date': days_ago(0)
}

with DAG(dag_id='dbt', default_args=default_args, schedule_interval='@daily') as dag:

  dbt_run = DbtRunOperator(
    task_id='dbt_run',
	dbt_bin='/home/rusdnz/.local/bin/dbt',
	profiles_dir='/home/rusdnz/.dbt/',
	dir='/home/rusdnz/otus-proj1/',
	select=tmp_daily_pos
  )

  dbt_run_2 = DbtRunOperator(
    task_id='dbt_run_2',
	dbt_bin='/home/rusdnz/.local/bin/dbt',
	profiles_dir='/home/rusdnz/.dbt/',
	dir='/home/rusdnz/otus-proj1/',
	select=tmp_daily_pos_flg,
  )

  dbt_run >> dbt_run_2
