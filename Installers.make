MOSH = /usr/bin/mosh
DOCKER = /usr/bin/docker
GDRIVEFUSE = /usr/bin/google-drive-ocamlfuse
ADDAPTREPO = /usr/bin/add-apt-repository

help:
	echo "For available installers see the contents of this makefile"

all: mosh docker gdrivefuse
essentials: mosh


mosh: $(MOSH)
$(MOSH):
	sudo apt-get install mosh

docker: $(DOCKER)
$(DOCKER):
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh

$(ADDAPTREPO):
	sudo apt-get install software-properties-common

gdrivefuse: $(GDRIVEFUSE)
$(GDRIVEFUSE): $(ADDAPTREPO)
	sudo add-apt-repository ppa:alessandro-strada/ppa
	sudo apt-get update
	sudo apt-get install google-drive-ocamlfuse

