#!/bin/bash

FLOATING_LIST=$(openstack floating ip list | grep -v ID| grep -v "+" | awk '{ print $2 }')

for item in $FLOATING_LIST;
do
  echo $item;
  openstack floating ip delete $item
done
