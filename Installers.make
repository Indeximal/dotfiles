SHELL = /bin/bash

MOSH = /usr/bin/mosh
DOCKER = /usr/bin/docker
GDRIVEFUSE = /usr/bin/google-drive-ocamlfuse
ADDAPTREPO = /usr/bin/add-apt-repository

VPNCONFIG = ~/.vpnconfig.env


help:
	echo "For available installers see the contents of this makefile"

all: mosh docker vpnserver gdrivefuse
essentials: mosh


mosh: $(MOSH)
$(MOSH):
	sudo apt-get --yes install mosh

# There was an error once, which I fixed with https://blog.adriaan.io/install-docker-on-raspberry-pi-4-with-ubuntu-20-04.html
docker: $(DOCKER)
$(DOCKER):
	curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
	sudo sh /tmp/get-docker.sh

$(VPNCONFIG):
	$(error VPN environment file not found!)
vpnserver: $(DOCKER) $(VPNCONFIG)
	if [ -z $$(sudo docker ps -qf name=ipsec-vpn-server) ]; then \
	  sudo docker run \
	  --name ipsec-vpn-server \
	  --env-file $(VPNCONFIG) \
	  --restart=always \
	  -v ikev2-vpn-data:/etc/ipsec.d \
	  -p 500:500/udp \
	  -p 4500:4500/udp \
	  -d --privileged \
	  hwdsl2/ipsec-vpn-server; \
	else \
	  echo "VPN server already running"; \
	fi

$(ADDAPTREPO):
	sudo apt-get --yes install software-properties-common

gdrivefuse: $(GDRIVEFUSE)
$(GDRIVEFUSE): $(ADDAPTREPO)
	sudo add-apt-repository ppa:alessandro-strada/ppa
	sudo apt-get update
	sudo apt-get --yes install google-drive-ocamlfuse

