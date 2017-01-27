#!/bin/sh
echo "Starting the conversion at " `date`
DATABASES="DBblacklist DBblacklistDuration DBgenericUser DBmoderationAuto DBmoderationClient DBmoderationManual DBmoderationRouter DBmoderationStats  DBvfs"

for i in $DATABASES
do
        echo Dumping $i
        mysqldump --default-character-set=latin1 --skip-set-charset $i  > dump-$i.sql
        echo converting the dump
        sed  -e 's/latin1/utf8/g' -i dump-$i.sql
done

#echo "Stopping the db for removing the old Databases"
#mysqld.sh stop
#for i in $DATABASES
#do
#       rm -Rf  data/$i
#done

#echo "Starting the DB to finish the work"

#mysqld.sh start
#sleep 5
#for i in $DATABASES
#do
#       mysql -e "create database $i;"
#       mysql $i < dump-$i.sql 
#       #rm dump-$i.sql
#done

#echo "End of the conversion at " `date`

