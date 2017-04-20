#!/bin/bash

PATTERN=$1
if [ -z "$PATTERN" ];
then
  PATTERN='^\S*'
fi

PORT_LIST=$(openstack port list | grep -v ID | grep -v + | grep -E $PATTERN | awk '{ print $2 }')

for item in $PORT_LIST;
do
  echo $item;
  openstack port delete $item
done
