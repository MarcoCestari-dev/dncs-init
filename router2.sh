echo "****************************************************"
echo "           Applying network settings"
echo "****************************************************"

ifconfig enp0s8 down
ip link set enp0s8 name eth1
ifconfig eth1 up 

ifconfig enp0s9 down
ip link set enp0s9 name eth2
ifconfig eth2 up


ip add add 10.3.0.1/24 dev eth1                      #add IP to eth1
ip add add 10.20.0.2/24 dev eth2                     #add IP to eth2

ip route add 10.1.0.0/24 via 10.20.0.1 dev eth2      #add generic route to reach host-a network via router-1 
ip route add 10.2.0.0/24 via 10.20.0.1 dev eth2      #add generic route to reach host-b network via router-1

sysctl -w net.ipv4.ip_forward=1 > /dev/null

echo "Set eth1 of router2 on 10.3.0.1"
echo "Set eth2 of router2 on 10.20.0.2"


echo "****************************************************"
echo "                      Done!"
echo "****************************************************"