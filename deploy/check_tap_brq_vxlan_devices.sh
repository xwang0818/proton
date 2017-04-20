#!/bin/bash
do_action() {
   echo perform action on  $1
   ssh -F $SSH_FILE root@$1 ' 
   echo $(ip link show | awk -F '"'"'[:]'"'"' '"'"'{print $2}'"'"' | grep "brq\|tap\|vxlan")
   echo $(ip link show | awk -F '"'"'[:]'"'"' '"'"'{print $2}'"'"' | grep "brq\|tap\|vxlan" | wc -l)
   '
}

SSH_FILE=$1
if [ -z "$SSH_FILE" ]; then
   SSH_FILE="/root/.ssh/config"
fi

for item in $(cat $SSH_FILE | grep "Host c" | awk '{ print $2 }'); do
   do_action $item
done
