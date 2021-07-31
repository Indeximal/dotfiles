#!/bin/bash

set -eu  # exit on error or undefined variable

mkdir -p ~/dev

# Install Mosh
if ! [ -x "$(command -v docker)" ]; then
	echo "TODO: install mosh"
fi

# Install Docker
if ! [ -x "$(command -v docker)" ]; then
	echo "TODO: install docker"
fi

# Install Samba
if [-z $(docker ps -qf name=samba)]; then
	docker run -it --name samba -p 139:139 -p 445:445 /
	-v ~/dev/:/mount -d dperson/samba -p /
	-s "public;/mount;yes;no;yes"
fi
