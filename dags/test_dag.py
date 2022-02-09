
from datetime import timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago

args = {
    'owner': 'airflow',
}

with DAG(
    dag_id='a_test_dag_dbt',
    default_args=args,
    schedule_interval='10 4 7 2 *',
    start_date=days_ago(0),
    dagrun_timeout=timedelta(minutes=60),
    tags=['dbt', 'ch'],
    params={"example_key": "example_value"},
) as dag:

    
    run_this = BashOperator(
        task_id='test_run',
        bash_command='/home/rusdnz/otus-proj1/shc/tmp/tmp_models.sh ',
        run_as_user='user1',
    )
    
    run_this_last = DummyOperator(
        task_id='run_this_last',
    )

    run_this >> run_this_last

if __name__ == "__main__":
    dag.cli()