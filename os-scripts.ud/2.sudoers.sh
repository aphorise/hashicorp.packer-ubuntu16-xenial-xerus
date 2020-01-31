#!/bin/bash
export DEBIAN_FRONTEND=noninteractive ;
set -eu ; # abort this script when a command fails or an unset variable is used.
#set -x ; # echo all the executed commands.

# make sure we cannot directly login as root.
usermod --lock root ;

apt-get -yq install sudo ;

# let the sudo group members use root permissions without a password.
# NB d-i automatically adds vagrant into the sudo group.
sed -i -E 's,^%sudo\s+.+,%sudo ALL=(ALL) NOPASSWD:ALL,g' /etc/sudoers ;

if [ $(grep -c vagrant /etc/passwd) == 0 ] ; then
    useradd vagrant -m ;
    # Add vagrant to sudo group
    usermod -a -G sudo vagrant ;
fi ;

# no tty
echo "Defaults !requiretty" >> /etc/sudoers ;
