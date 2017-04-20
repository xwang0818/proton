#!/bin/bash
do_action() {
   echo perform action on  $1
   ssh -F $SSH_FILE $1 "
#for item in `ip link show | grep vxlan | awk '{ print \$2 }'`;  do echo ${item::-1}; sudo ip link set dev $item down; sudo ip link delete dev $item; done 
  "
}

SSH_FILE=$1
if [ -z "$SSH_FILE" ]; then
   echo "Usage: $0 <ssh_config>"
   exit 0
fi

for item in $(cat $SSH_FILE | grep "Host " | awk '{ print $2 }'); do
   do_action $item
done
