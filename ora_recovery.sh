#!/usr/bin/bash

cd /home/ec2-user/na_oracle19c_data_protection

#log=/home/ec2-user/na_oracle19c_data_protection/logs/log_`date +"%Y-%m%d-%H%M.%S"`.log

DTB=`date +"%Y-%m%d-%H%M.%S"` 
echo "Oracle recovery begin at $DTB" 

/usr/local/bin/ansible-playbook -i hosts ora_recovery.yml -u ec2-user --private-key rdsFlex_db2.pem -e @vars/fsx_vars.yml 

DTE=`date +"%Y-%m%d-%H%M.%S"`
echo "Oracle recovery begin at $DTB and end at $DTE" 
