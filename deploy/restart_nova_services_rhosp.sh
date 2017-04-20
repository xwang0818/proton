#!/bin/bash
do_action() {
   echo ""
   echo "###################### Perform action on  $1 ##################"
   ssh -F $SSH_FILE $1 ' 
#      systemctl stop .service 
#      systemctl start .service

   '
}

SSH_FILE=$1
if [ -z "$SSH_FILE" ]; then
   echo "Usage: $0 <ssh_config>"
   exit 0
fi

for item in $(cat $SSH_FILE | grep "Host " | awk '{ print $2 }'); do
   do_action $item
done
