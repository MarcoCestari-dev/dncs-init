echo "****************************************************"
echo "           Applying network settings"
echo "****************************************************"

ifconfig enp0s8 down
ip link set enp0s8 name eth1
ifconfig eth1 up 

ifconfig enp0s9 down
ip link set enp0s9 name eth2
ifconfig eth2 up


ip link set eth1 up
ip link set eth2 up 

ip link add link eth1 name eth1.1 type vlan id 1     #Splitting port eth1 in eth1.1 and eth1.2
ip link add link eth1 name eth1.2 type vlan id 2     #Splitting port eth1 in eth1.1 and eth1.2

ip link set dev eth1.1 up
ip link set dev eth1.2 up

ip add add 10.1.0.1/24 dev eth1.1                    #add IP to eth1.1
ip add add 10.2.0.1/24 dev eth1.2                    #add IP to eth1.2
ip add add 10.20.0.1/24 dev eth2                     #add IP to eth2

ip route add 10.1.0.0/24  dev eth1.1                 #add route to reach the subnet of host-a
ip route add 10.2.0.0/24  dev eth1.2                 #add route to reach the subnet of host-b
ip route add 10.3.0.0/23 via 10.20.0.2 dev eth2      #add generic route to reach host-c network via router-2 

sysctl -w net.ipv4.ip_forward=1 > /dev/null

echo "Set eth1.1 of router1 on 10.1.0.1"
echo "Set eth1.2 of router1 on 10.2.0.1"
echo "Set eth2 of router1 on 10.20.0.1"

echo "****************************************************"
echo "                      Done!"
echo "****************************************************"
