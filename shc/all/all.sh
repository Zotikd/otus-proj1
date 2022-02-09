#в скрипте 1 параметр LOAD_TYPE - типа загрузки. hist - полная перезагрузка
#	hist - полная перезагрузка. переподключаемся к ресурсам на s3, --full-refresh - для моделей dbt
#	inc - забор дельты. 
#TODO очистка БД

LOAD_TYPE=$1

if [[ ${LOAD_TYPE} == hist ]];then
  echo "Запущен режим ${LOAD_TYPE}"
  /home/rusdnz/otus-proj1/shc/src/drop_src.sh
  /home/rusdnz/otus-proj1/shc/src/all_src.sh
  /home/rusdnz/otus-proj1/shc/stg/stg_models.sh
  /home/rusdnz/otus-proj1/shc/dds/dds_models.sh hist
  /home/rusdnz/otus-proj1/shc/tmp/tmp_models.sh
  /home/rusdnz/otus-proj1/shc/mart/mart_models.sh
elif [[ ${LOAD_TYPE} == inc ]];then
  echo "Запущен режим ${LOAD_TYPE}"
  /home/rusdnz/otus-proj1/shc/stg/stg_models.sh
  /home/rusdnz/otus-proj1/shc/dds/dds_models.sh inc
  /home/rusdnz/otus-proj1/shc/tmp/tmp_models.sh
  /home/rusdnz/otus-proj1/shc/mart/mart_models.sh
else
  echo "Необходимо задать переменную LOAD_TYPE - тип загрузки(hist/inc)"
fi

#/home/rusdnz/otus-proj1/shc/stg/stg_models.sh
#/home/rusdnz/otus-proj1/shc/dds/dds_models.sh
#/home/rusdnz/otus-proj1/shc/tmp/tmp_models.sh
#/home/rusdnz/otus-proj1/shc/mart/mart_models.sh