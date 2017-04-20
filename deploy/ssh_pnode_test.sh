#!/bin/bash
do_action() {
   echo perform action on  $1
   ssh -F $SSH_FILE -o StrictHostKeyChecking=no -o ConnectTimeout=8 $1 "
   uptime     
   "
}

SSH_FILE=$1
if [ -z "$SSH_FILE" ]; then
   echo "Usage: $0 <ssh config>"
   exit 0
fi


for item in $(cat $SSH_FILE | grep "Hostname" | awk '{ print $2 }'); do
   echo "Removing $item from known hosts..."
   ssh-keygen -R $item
   ssh-keygen -f "/home/blueboxadmin/.ssh/known_hosts2" -R $item
done

for item in $(cat $SSH_FILE | grep "Host " | grep -v '*' | awk '{ print $2 }'); do
   do_action $item
done
