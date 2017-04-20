#!/bin/bash

PATTERN=$1
if [ -z "$PATTERN" ];
then
  PATTERN='^\S*'
fi

SERVER_LIST=$(openstack server list | grep -v ID| grep -v "+" | grep -E $PATTERN | awk '{ print $2 }')

for item in $SERVER_LIST;
do
  echo $item;
  openstack server delete $item
done
