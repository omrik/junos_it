#!/bin/bash
# SNMP box with snmp v2 community based login
# usage junos_snmp_all.sh host_list_file 
# By Omri Kedem 10/2019
E_BADARGS=65
COMMUNITY=public
case $# in
  0)
  echo "Usage: `basename $0` switchlist.txt"
  exit $E_BADARGS  # If 0 or 1 arg, then bail out.
  ;;
esac
#Now ignores lines with hash (#) in files
SERVERS=`sed '/^ *#/d;s/#.*//' $1`

for host in $SERVERS
do
  HOST=`snmpwalk -v2c -c $COMMUNITY -O aqv $host sysName.0`
  echo "switch $HOST serials "
  snmpwalk -v2c -c $COMMUNITY -O aqv $host 1.3.6.1.4.1.2636.3.40.1.4.1.1.1.2
  echo "switch $HOST versions "
  snmpwalk -v2c -c $COMMUNITY -O aqv $host 1.3.6.1.4.1.2636.3.40.1.4.1.1.1.5
  echo "switch $HOST models "
  snmpwalk -v2c -c $COMMUNITY -O aqv $host 1.3.6.1.4.1.2636.3.40.1.4.1.1.1.8

done
