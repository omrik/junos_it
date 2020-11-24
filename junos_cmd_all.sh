#!/bin/bash
# Juniper box with ssh key based login
# usage junos_cmd_all.sh host_list_file command
# By Omri Kedem 04/2008
E_BADARGS=65

case $# in
  0|1)
  echo "Usage: `basename $0` switch-list.txt command"
  echo "Command of type \"edit;set vlans test-script vlan-id 877 ;commit;exit\""
  exit $E_BADARGS  # If 0 or 1 arg, then bail out.
  ;;
esac
#Now ignores lines with hash (#) in files
SERVERS=`sed '/^ *#/d;s/#.*//' $1`
CMD=$2

for host in $SERVERS
do
 echo "------------------------ $host ----------------------------"
 ssh $host cli $CMD

done
