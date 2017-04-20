#!/bin/bash
do_action() {
   echo perform action on  $1
   ssh -F $SSH_FILE root@$1 ' 
   for item in $(ip link show | awk -F '"'"'[:]'"'"' '"'"'{print $2}'"'"' | grep "brq\|tap\|vxlan");  do
     ip link delete $item;
   done
   '
}

SSH_FILE=$1
if [ -z "$SSH_FILE" ]; then
   SSH_FILE="/root/.ssh/config"
fi

for item in $(cat $SSH_FILE | grep "Host " | awk '{ print $2 }'); do
   do_action $item
done
