#!/bin/bash
do_action() {
   echo ""
   echo "###################### Perform action on  $1 ##################"
   ssh -F $SSH_FILE $1 ' 
sudo systemctl stop neutron-linuxbridge-agent.service 
sudo systemctl start neutron-linuxbridge-agent.service
sudo systemctl stop neutron-server.service 
sudo systemctl start neutron-server.service
sudo systemctl stop neutron-dhcp-agent.service 
sudo systemctl start neutron-dhcp-agent.service
sudo systemctl stop neutron-metadata-agent.service 
sudo systemctl start neutron-metadata-agent.service
sudo systemctl stop neutron-l3-agent.service 
sudo systemctl start neutron-l3-agent.service
   '
}

SSH_FILE=$1
if [ -z "$SSH_FILE" ]; then
   echo "Usage: $0 <ssh_config>"
   exit 0
fi

for item in $(cat $SSH_FILE | grep -v '*' | grep "Host " | awk '{ print $2 }'); do
   do_action $item
done
