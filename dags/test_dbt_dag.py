from datetime import timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago

args = {
    'owner': 'airflow',
}

with DAG(
    dag_id='b_test_dag_dbt1',
    default_args=args,
    schedule_interval='7 4 7 2 *',
    start_date=days_ago(0),
    dagrun_timeout=timedelta(minutes=60),
    tags=['dbt', 'ch'],
) as dag:

    
    run_this = BashOperator(
        task_id='test_run',
        bash_command=f'/home/rusdnz/otus-proj1/shc/tmp/tmp_models.sh ',
        run_as_user='rusdnz'
    )
    
    run_this_last = DummyOperator(
        task_id='run_this_last',
    )

    run_this >> run_this_last

if __name__ == "__main__":
    dag.cli()