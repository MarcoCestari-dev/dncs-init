echo "****************************************************"
echo "           Applying network settings"
echo "****************************************************"

ifconfig enp0s8 down
ip link set enp0s8 name eth1
ifconfig eth1 up

ip link set eth1 up
            
ip add add 10.1.0.2/24 dev eth1           #add IP to eth1

ip route add 10.2.0.0/24 via 10.1.0.1     #add generic route to reach host-b network via router-1 (VLAN1 port eth1.1)
ip route add 10.20.0.0/24 via 10.1.0.1    #add generic route to reach router-2 network via router-1 (VLAN1 port eth1.1)
ip route add 10.3.0.0/23 via 10.1.0.1     #add generic route to reach host-c network via router-1 (VLAN1 port eth1.1)

echo "Set eth1 of hostA on 10.1.0.2"

echo "****************************************************"
echo "                      Done!"
echo "****************************************************"
