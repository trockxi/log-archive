#! /bin/bash

cd ~/sync/logs
echo

echo "delete archive.log ..."
rm -rf afdoa_access_log.*
echo

echo "start tar .gz files ..."
gzip -dk *.gz
echo

echo "content after tar ..."
ls
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
	echo $time_date
	if test -e afdoa_access_log.$time_date.log
	then
		echo $line >> afdoa_access_log.$time_date.log
	else
		echo $line > afdoa_access_log.$time_date.log
	fi
}
cat access.* | while read line
do
	dealwithline $line
done
