
from datetime import timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.contrib.operators.ssh_operator import SSHOperator
from airflow.contrib.hooks import SSHHook

sshHook = SSHHook(conn_id=ssh_default)

args = {
    'owner': 'airflow',
}

with DAG(
    dag_id='d_test_dag_dbt',
    default_args=args,
    schedule_interval='30 22 * * *',
    start_date=days_ago(0),
    dagrun_timeout=timedelta(minutes=60),
    tags=['dbt', 'ch'],
    params={"example_key": "example_value"},
) as dag:

    run_this = BashOperator(
        task_id='test_run',
        bash_command='touch /home/rusdnz/keys/test_res_daf.txt ',
        ssh_hook=sshHook,
    )
    
    run_this_last = DummyOperator(
        task_id='run_this_last',
    )

    run_this >> run_this_last

if __name__ == "__main__":
    dag.cli()