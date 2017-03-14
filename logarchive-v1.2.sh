#! /bin/bash

#check parameter number
if [ $# -lt 4 ]
then
	echo Please add path and prefix, like this:
	echo ' './logarchive.sh /source/logs access /destination/logs afdoa_access_log
	exit
fi

#check parameter legal or not
if [ ! -d $1 ]
then
	echo $1 is not exist
	exit
fi

LOG_TO_ARCHIVE_PATH=$1
LOG_TO_ARCHIVE_PREFIX=$2
ARCHIVED_LOG_PATH=$3
ARCHIVED_LOG_PREFIX=$4

#delete archived log
rm -rf $ARCHIVED_LOG_PATH/$ARCHIVED_LOG_PREFIX.*

#gunzip .gz files
if [ ! -d $ARCHIVED_LOG_PATH ]
then
	mkdir $ARCHIVED_LOG_PATH
fi
mkdir $ARCHIVED_LOG_PATH/archive_tmp
cp $LOG_TO_ARCHIVE_PATH/$LOG_TO_ARCHIVE_PREFIX.* $ARCHIVED_LOG_PATH/archive_tmp
gzip -d $ARCHIVED_LOG_PATH/archive_tmp/*.gz

#start archive
function dealwithline {
	#echo $LINE
	TIME_SECONDS=$4
	#echo $TIME_SECONDS
	TIME_SECONDS=${TIME_SECONDS%.*}
	TIME_SECONDS=${TIME_SECONDS#*[}
	#echo $TIME_SECONDS
	TIME_DATE=$(date -d @$TIME_SECONDS "+%Y-%m-%d")
	#echo $TIME_DATE
	if [ -e $ARCHIVED_LOG_PATH/$ARCHIVED_LOG_PREFIX.$TIME_DATE.log ]
	then
		echo $LINE >> $ARCHIVED_LOG_PATH/$ARCHIVED_LOG_PREFIX.$TIME_DATE.log
	else
		echo $LINE > $ARCHIVED_LOG_PATH/$ARCHIVED_LOG_PREFIX.$TIME_DATE.log
	fi
}
cat $ARCHIVED_LOG_PATH/archive_tmp/$LOG_TO_ARCHIVE_PREFIX.* | while read LINE
do
	dealwithline $LINE
done

echo "delete temp file ..."
rm -rf $ARCHIVED_LOG_PATH/archive_tmp
