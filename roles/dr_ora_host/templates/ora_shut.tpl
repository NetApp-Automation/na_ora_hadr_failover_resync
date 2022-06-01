#/usr/bin/sh
# Description: Shutdown Oracle database and sevices before resync database volumes at target with primary
# The script search Oracle databases in /etc/oratab file in "running mode or Y" and
# loop through each database on target server to complete database and listener shutdown.

ORATAB=/etc/oratab
if [ ! -f $ORATAB ]
then
        exit 1
fi

grep ".*:.*:Y" /etc/oratab | while read line
   do
     ORACLE_SID=`echo $line | awk -F ":" '{print $1}'`
     ORACLE_HOME=`echo $line | awk -F ":" '{print $2}'`
     export ORACLE_SID
     export ORACLE_HOME
     export PATH=$PATH:$ORACLE_HOME/bin
     $ORACLE_HOME/bin/lsnrctl stop listener.{{ oracle_sid }}
     $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" <<!>> db_shut
     whenever sqlerror exit SQL.SQLCODE
     shutdown abort;
     exit;
!
   done
