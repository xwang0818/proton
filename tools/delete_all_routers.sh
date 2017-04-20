#!/bin/bash

PATTERN=$1
FILTER="default"

if [ -z "$PATTERN" ];
then
  PATTERN='^\S*'
else
  FILTER="XXXXXXXXXXXXXXX"
fi




ROUTER_LIST=$(openstack router list | grep -v ID | grep -v $FILTER | grep -v + | grep -E $PATTERN | awk '{ print $2 }')

for item in $ROUTER_LIST;
do
  echo $item;
  neutron router-gateway-clear $item;
  INTERFACE_LIST=$(neutron router-port-list $item | grep subnet_id | grep -v HA | awk '{ print $10 }')
  for interface in $INTERFACE_LIST;
  do 
    echo $interface;
    neutron router-interface-delete $item ${interface:1:-2}
  done
  openstack router delete $item
done
