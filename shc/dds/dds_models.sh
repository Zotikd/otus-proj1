#в скрипте 1 параметр LOAD_TYPE - типа загрузки. hist - полная перезагрузка
#	hist - полная перезагрузка. переподключаемся к ресурсам на s3, --full-refresh - для моделей dbt
#	любое другое значение - забор дельты. 
#	режим hist будет автоматически применен ко всем новым таблицам. см док-ию dbt

LOAD_TYPE_DDS=$1

cd /home/rusdnz/otus-proj1

if [[ ${LOAD_TYPE_DDS} == hist ]];then
  dbt run -m tag:dds --full-refresh
else
  dbt run -m tag:dds
fi
