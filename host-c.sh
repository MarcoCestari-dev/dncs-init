echo "****************************************************"
echo "           Applying network settings"
echo "****************************************************"

ifconfig enp0s8 down
ip link set enp0s8 name eth1
ifconfig eth1 up

ip link set eth1 up


ip add add 10.3.0.2/23 dev eth1          

ip route add 10.1.0.0/24 via 10.3.0.1      #add generic route to reach host-a network via router-2
ip route add 10.2.0.0/24 via 10.3.0.1      #add generic route to reach host-b network via router-2
ip route add 10.20.0.0/24 via 10.3.0.1     #add generic route to reach router-1 port network via router-2

echo "Set eth1 of hostC on 10.3.0.2"

echo "Installing Docker..."
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y docker.io

sudo docker pull nginx
sudo docker run --name web-server -p 80:80 -d nginx 
echo "Running docker called 'web-server'."


echo "****************************************************"
echo "                      Done!"
echo "****************************************************"
