#!/bin/bash

set -e

if [ ! -d ~/GDrive ]; then
	mkdir -p ~/GDrive

	# This fakes a browser and instead prints the url to authenticate with google
	echo $'#!/bin/sh\necho $* > /dev/stderr' > xdg-open
	chmod 755 xdg-open
	echo "Open this Url in a browser and return here:"
	env PATH=`pwd`:$PATH google-drive-ocamlfuse
	rm xdg-open

	google-drive-ocamlfuse ~/GDrive
fi

unmountgdrive () {
	fusermount -u ~/GDrive
}
