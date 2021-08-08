MOSH = /usr/bin/mosh
DOCKER = /usr/bin/docker

help:
	echo "For available installers see the contents of this makefile"

all: mosh docker
essentials: mosh

mosh: $(MOSH)
$(MOSH):
	sudo apt-get install mosh
	
docker: $(DOCKER)
$(DOCKER):
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
