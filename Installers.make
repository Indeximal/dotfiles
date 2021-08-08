MOSH = /usr/bin/mosh
DOCKER = /usr/bin/docker
GDRIVEFUSE = /usr/bin/google-drive-ocamlfuse

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
	
gdrivefuse: $(GDRIVEFUSE)
$(GDRIVEFUSE):
	sudo add-apt-repository ppa:alessandro-strada/ppa
	sudo apt-get update
	sudo apt-get install google-drive-ocamlfuse

