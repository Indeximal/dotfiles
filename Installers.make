MOSH = /usr/bin/mosh
DOCKER = /usr/bin/docker
GDRIVEFUSE = /usr/bin/google-drive-ocamlfuse
ADDAPTREPO = /usr/bin/add-apt-repository

help:
	echo "For available installers see the contents of this makefile"

all: mosh docker vpnserver gdrivefuse
essentials: mosh


mosh: $(MOSH)
$(MOSH):
	sudo apt-get install mosh

docker: $(DOCKER)
$(DOCKER):
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh

vpnserver: $(DOCKER)
	if [-z $(docker ps -qf name=ipsec-vpn-server)]; then
		if [! -f ./vpn.env]; then
			echo "VPN Enviroment file not found!"
			exit 1
		fi	
		sudo docker run \
	    --name ipsec-vpn-server \
	    --env-file ./vpn.env \
	    --restart=always \
	    -v ikev2-vpn-data:/etc/ipsec.d \
	    -p 500:500/udp \
	    -p 4500:4500/udp \
	    -d --privileged \
	    hwdsl2/ipsec-vpn-server
	fi	
	
$(ADDAPTREPO):
	sudo apt-get install software-properties-common

gdrivefuse: $(GDRIVEFUSE)
$(GDRIVEFUSE): $(ADDAPTREPO)
	sudo add-apt-repository ppa:alessandro-strada/ppa
	sudo apt-get update
	sudo apt-get install google-drive-ocamlfuse

