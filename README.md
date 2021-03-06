# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```


        +-----------------------------------------------------+
        |                                                     |
        |                                                     |eth0
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |            eth0|            |eth2     eth2|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |eth1                       |eth1
        |  N  |                      |                           |
        |  A  |                      |                           |
        |  G  |                      |                     +-----+----+
        |  E  |                      |eth1                 |          |
        |  M  |            +-------------------+           |          |
        |  E  |        eth0|                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |eth2         |eth3                |eth0
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |eth1         |eth1                |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |    eth0|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |eth0                   |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

# Requirements
 - Python 3
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/fabrizio-granelli/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab] vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 4 VMs
 ```
 [dncs-lab]$ vagrant status                                                                                                                                                                
Current machine states:

router                    running (virtualbox)
switch                    running (virtualbox)
host-a                    running (virtualbox)
host-b                    running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router`
`vagrant ssh switch`
`vagrant ssh host-a`
`vagrant ssh host-b`
`vagrant ssh host-c`

# Assignment
This section describes the assignment, its requirements and the tasks the student has to complete.
The assignment consists in a simple piece of design work that students have to carry out to satisfy the requirements described below.
The assignment deliverable consists of a Github repository containing:
- the code necessary for the infrastructure to be replicated and instantiated
- an updated README.md file where design decisions and experimental results are illustrated
- an updated answers.yml file containing the details of your project

## Design Requirements
- Hosts 1-a and 1-b are in two subnets (*Hosts-A* and *Hosts-B*) that must be able to scale up to respectively 209 and 239 usable addresses
- Host 2-c is in a subnet (*Hub*) that needs to accommodate up to 418 usable addresses
- Host 2-c must run a docker image (dustnic82/nginx-test) which implements a web-server that must be reachable from Host-1-a and Host-1-b
- No dynamic routing can be used
- Routes must be as generic as possible
- The lab setup must be portable and executed just by launching the `vagrant up` command

## Tasks
- Fork the Github repository: https://github.com/fabrizio-granelli/dncs-lab
- Clone the repository
- Run the initiator script (dncs-init). The script generates a custom `answers.yml` file and updates the Readme.md file with specific details automatically generated by the script itself.
  This can be done just once in case the work is being carried out by a group of (<=2) engineers, using the name of the 'squad lead'. 
- Implement the design by integrating the necessary commands into the VM startup scripts (create more if necessary)
- Modify the Vagrantfile (if necessary)
- Document the design by expanding this readme file
- Fill the `answers.yml` file where required (make sure that is committed and pushed to your repository)
- Commit the changes and push to your own repository
- Notify the examiner (fabrizio.granelli@unitn.it) that work is complete specifying the Github repository, First Name, Last Name and Matriculation number. This needs to happen at least 7 days prior an exam registration date.

# Notes and References
- https://rogerdudler.github.io/git-guide/
- http://therandomsecurityguy.com/openvswitch-cheat-sheet/
- https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
- https://www.vagrantup.com/intro/getting-started/


# Design

## Authors and Notes
This project has been developed by Marco Cestari (mat. 205306) and Giada Figliolini (mat. 202121) in equal parts working always in pair on Marco's device with the application Anydesk (software that allows to work on PC remotely and share the screen). We decided to work in this way because Marco's PC is the most powerful and fastest.

## Planning
We decided to divide the creation of the structure into two parts: part 1 and part 2 and then connect them together.
Part 1: the first part is based on the setup of the structure of host-a, host-b, switch and router-1.
Part 2: the second part is based on the setup of router-2 and host-c.
We decided to use for the subnet IP address that would have been easy to recognize so each subnet IP address is 8 bits next to the previous one.
Once the setup of the two parts is done we will proceed with the final testing and verification of its correct functioning and compliance with all requirements

## Address informations

| Device       | Network    | Netmask         | Broadcast   | Hosts | Host-min    | Host-max   |
|--------------|------------|-----------------|-------------|-------|-------------|------------|
| Host-a       | 10.1.0.0   | 255.255.255.0   | 10.1.0.255  | 254   | 10.1.0.1 	  | 10.1.0.254 |
| Host-b       | 10.2.0.0   | 255.255.255.0   | 10.2.0.255  | 254   | 10.2.0.1    | 10.2.0.254 |
| Host-c       | 10.3.0.0   | 255.255.254.0   | 10.3.0.255  | 510   | 10.3.0.1    | 10.3.1.254 |


To assign IP addresses to the VMs I had to follow this requirements, that say: 
- "Hosts-A" must be able to scale up to 209 usable addresses
- "Hosts-B" must be able to scale up to 239 usable addresses
-	"Host-C/Hub" must be able to scale up to 418 usable addresses
The Netmasks are sized to be as small as possible respecting the specifications

## Developing

### Developing Part #1
Host-a: it needs to accommodate up to 209 devices, as subnet IP addresses we used 10.1.0.0/24; in this host we turned on the eth1 interface with IP address 10.1.0.1/24.
Host-b: it needs to accommodate up to 239 devices, as subnet IP addresses we used 10.2.0.0/24; we turned on the eth1 interface with IP address 10.2.0.1/24.
Switch: we tried to figure out how to build a VLAN that would allow host-a and host-b to be kept in separate subnets. we were then able to install the openvswitch package, and activate eth1, eth2 and eth3.
Router-1: to develop the virtual LANs we decided to divide the router-1 eth1 into two separate visual ports (1.1 and 1.2, both connected to the eth1 switch port).
the switch bridge was built to handle packets from host-a and host-b to router-1 and vice versa. In this way we made host-a and host-b communicate only via router. We gave to the two virtual ports IP addresses 10.1.0.2/24, 10.2.0.2/24 for eth1.1 and eth1.2. We gave the router the command 'sysctl net.ipv4.ip_forward=1' to enable the router to forward packages.

### Testing Part #1
To test the infrastructure we used the ping command: we used the ping 10.2.0.2 command from host a to verify that host a reached host b and vice versa, i.e. from host b to host a (10.1.0.2).

### Developing Part #2
Host-c/Hub: since host-c must be able to host up to 418 addresses, we used 10.3.0.0/23 as the subnet mask, so that we have 511 address available.; then we turned on the eth1 link with IP address 10.3.0.1/23.
Router-2: We created router-2 to connect host-c to router-1's subnet. We set eth1 to 10.3.0.2/23 (10.3.0.0 subnet) and eth2 to 10.20.0.2/23 (10.20.0.0 subnet, shared between router-1 and router-2). We activated eth2, port of the router-1,  on address 10.20.0.1/23 so as to connect the routers for subnets. We gave the router the command 'sysctl net.ipv4.ip_forward=1' to enable the router to forward packages.
We set up the generic routes to connect router-2 nework to router-1 network.

#### Doker 
We began studying how to import the docker image: we consulted https://docs.docker.com/. We ran the commands that we found; we made some tests and they gave us good results. It runs on port 80.

### Final Testing 
We used ping commands to check all the routes; and "curl 10.3.0.1:80" to test the server based on host-c. The result is that the architecture works.

## Commands
To run the infrastructure use: "vagrant up".
Verify that all virtual machines are running correctly and are "running": “Vagrant status”

| Description - Ping                                              | Command                                        |
|-----------------------------------------------------------------|------------------------------------------------|
| Check if host-a can reach host-b                                | vagrant ssh host-a -c "ping 10.2.0.2 -c 1"     |
| Check if host-a can reach host-c                                | vagrant ssh host-a -c "ping 10.3.0.2 -c 1"     |
| Check if host-b can reach host-a                                | vagrant ssh host-b -c "ping 10.1.0.2 -c 1"     |
| Check if host-b can reach host-c                                | vagrant ssh host-b -c "ping 10.3.0.2 -c 1"     |
| Check if host-c can reach host-a                                | vagrant ssh host-c -c "ping 10.1.0.2 -c 1"     |
| Check if host-c can reach host-b                                | vagrant ssh host-c -c "ping 10.2.0.2 -c 1"     |

| Description - Verify Webserver                                  | Command                                        |
|-----------------------------------------------------------------|------------------------------------------------|
| Check if host-a can reach the webserver of host-c               | vagrant ssh host-a -c "curl 10.3.0.2 -c 1"     |
| Check if host-b can reach the webserver of host-c               | vagrant ssh host-b -c "curl 10.3.0.2 -c 1"     |
| Check if the host-c can reach the webserver of the host-c       | vagrant ssh host-c -c "curl 10.3.0.2 -c 1"     |

