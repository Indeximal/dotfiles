SHELL = /bin/bash

MOSH = /usr/bin/mosh
DOCKER = /usr/bin/docker
GDRIVEFUSE = /usr/bin/google-drive-ocamlfuse
ADDAPTREPO = /usr/bin/add-apt-repository
FFMPEG = /usr/bin/ffmpeg
PIP = /usr/bin/pip3
FACEALIGNERREPO = ~/facelapse

VPNCONFIG = ~/.vpnconfig.env


help:
	echo "For available installers see the contents of this makefile"

all: mosh docker vpnserver gdrivefuse ffmpeg pip facelapse
essentials: mosh gdrivefuse pip


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
	sudo add-apt-repository --yes ppa:alessandro-strada/ppa
	sudo apt-get update
	sudo apt-get --yes install google-drive-ocamlfuse

ffmpeg: $(FFMPEG)
$(FFMPEG):
	sudo apt-get --yes install ffmpeg

pip: $(PIP)
$(PIP):
	sudo apt-get --yes install python3-pip

facelapse: $(FFMPEG) $(FACEALIGNERREPO) ~/venvdir/facelapse ~/shape_predictor_68_face_landmarks.dat

$(FACEALIGNERREPO):
	if [ -d $@ ]; then rm -rf $@; fi
	mkdir -p $@
	git clone https://github.com/Indeximal/photo-a-day-aligner.git $@

~/venvdir/facelapse: $(PIP) $(FACEALIGNERREPO)
	# The apt install is only necessary because of an error when using the preinstalled version. Also isn't nicely idempotent.
	sudo apt-get --yes install python3-venv
	python3 -m venv --clear $@
	source $@/bin/activate && python3 -m pip install -r $(FACEALIGNERREPO)/requirements.txt

~/shape_predictor_68_face_landmarks.dat:
	curl -fsSL http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2 -o $@.bz2
	bzip2 -d $@.bz2

