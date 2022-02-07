{{
    config (
      engine='MergeTree()',
      order_by='ID',
	  unique_key='ID'
    )
}}

with tmp1 as (
select ID, WAY
from {{ ref('dds_test_way') }}
),

tmp2 as (
select t1.ID as ID, t1.NM, t1.CREATED_DTTM, t2.WAY
from {{ ref('dds_test_kek') }} as t1 
left join tmp1 as t2
on t1.ID = t2.ID
)

select *
from tmp2