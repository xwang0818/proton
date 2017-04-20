echo "Setting RAM to max"
openstack quota set --ram -1 admin
echo "Setting Cores to max"
openstack quota set --cores -1 admin
echo "Setting Instances to max"
openstack quota set --instances -1 admin
echo "Setting Ports to max"
openstack quota set --port -1 admin
