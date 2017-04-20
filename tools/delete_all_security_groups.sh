#!/bin/bash

PATTERN=$1
if [ -z "$PATTERN" ];
then
  PATTERN='^\S*'
else
  FILTER="XXXXXXXXXXXXXXX"
fi

SEC_GROUP_LIST=$(openstack security group list | grep -v ID | grep -v default | grep -E $PATTERN | awk '{ print $2 }')

for item in $SEC_GROUP_LIST;
do
  echo $item;
  openstack security group delete $item
done
