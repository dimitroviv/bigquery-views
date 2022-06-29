#!/bin/sh
#./cicd.sh mathem-ml-datahem-test views
project_id=$1
views_dir=$2
location=${3:-US}  

for file_entry in $(find ./$views_dir -type f -follow -print)
do
  echo "$file_entry"
  gcloud builds submit --async --config=cloudbuild.view.yaml --substitutions=_SQL_FILE="$file_entry" . 
done