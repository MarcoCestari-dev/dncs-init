export DEBIAN_FRONTEND=noninteractive
# Startup commands go here

sudo ip link set enp0s8 name eth1
sudo ip link set eth1 up
sudo ip addr add 192.168.1.2/24 dev eth1

sudo ip route add 192.168.0.0/16 via 192.168.1.1

