#!/bin/bash
do_action() {
        echo "****************************testing ssh for $1*************************************"
        echo "***********************************************************************************"
        ssh $1 bash -c "'
ping -c 3 www.google.com
sudo -u nova -H /bin/sh -c /var/lib/nova/bin/verify-ssh
        '"
}

for i in `seq 1 2`;
do
   do_action compute$i
done
