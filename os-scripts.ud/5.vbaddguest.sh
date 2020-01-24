#!/bin/bash
export DEBIAN_FRONTEND=noninteractive ;
set -eu ; # abort this script when a command fails or an unset variable is used.
#set -x ; # echo all the executed commands.

# install the Guest Additions.
if [ -n "$(lspci | grep VirtualBox | head -1)" ] ; then
	# install the VirtualBox Guest Additions.
	# this will be installed at /opt/VBoxGuestAdditions-VERSION.
	# REMOVE_INSTALLATION_DIR=0 is to fix a bug in VBoxLinuxAdditions.run.
	# See http://stackoverflow.com/a/25943638.
	apt-get -y -q install gcc dkms bzip2 ;
	mkdir -p /media/iso ;
	mount -o loop /home/vagrant/VBoxGuestAdditions.iso /media/iso ;
	while [ ! -f /media/iso/VBoxLinuxAdditions.run ]; do sleep 1; done
	# NB we assume this command will always succeed due to:
	#       VirtualBox Guest Additions: Running kernel modules will not be replaced until the system is restarted
	REMOVE_INSTALLATION_DIR=0 \
		/media/iso/VBoxLinuxAdditions.run \
		--target /tmp/VBoxGuestAdditions \
		|| true ;
	rm -rf /tmp/VBoxGuestAdditions ;
	umount /media/iso ;
	rm -rf /media/iso /home/vagrant/VBoxGuestAdditions.iso ;
	modinfo vboxguest ;
else
	echo 'ERROR: Unknown VM host.' || exit 1 ;
fi ;
