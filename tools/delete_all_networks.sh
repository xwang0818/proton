#!/bin/bash

PATTERN=$1
if [ -z "$PATTERN" ];
then
  PATTERN='^\S*'
fi

NETWORK_LIST=$(openstack network list | grep -v ID | grep -v + | grep -v external | grep -v internal | grep -E $PATTERN | awk '{ print $2 }')

for item in $NETWORK_LIST;
do
  echo $item;
  openstack network delete $item
done
