#! /bin/bash

# path & prefix
log_to_archive_path="/home/rocj/sync/logs"
log_to_archive_prefix="access"
archived_log_path="/home/rocj/sync/logs/afdoa_access_log"
archived_log_prefix="afdoa_access_log"

echo "delete archived log ..."
rm -rf $archived_log_path
echo

echo "start gunzip .gz files ..."
mkdir $archived_log_path
mkdir $archived_log_path/archive_tmp
cp $log_to_archive_path/$log_to_archive_prefix.* $archived_log_path/archive_tmp
gzip -d $archived_log_path/archive_tmp/*.gz
echo

echo "start archive ..."
function dealwithline {
	echo $line
	time_seconds=$4
	#echo $time_seconds
	time_seconds=${time_seconds%.*}
	time_seconds=${time_seconds#*[}
	#echo $time_seconds
	time_date=$(date -d @$time_seconds "+%Y-%m-%d")
	#echo $time_date
	if test -e $archived_log_path/$archived_log_prefix.$time_date.log
	then
		echo $line >> $archived_log_path/$archived_log_prefix.$time_date.log
	else
		echo $line > $archived_log_path/$archived_log_prefix.$time_date.log
	fi
}
cat $archived_log_path/archive_tmp/$log_to_archive_prefix.* | while read line
do
	dealwithline $line
done

echo "delete temp file ..."
rm -rf $archived_log_path/archive_tmp
