#!/bin/bash
export DEBIAN_FRONTEND=noninteractive ;
set -eu ; # abort this script when a command fails or an unset variable is used.
#set -x ; # echo all the executed commands.

apt-get update ;

# Install NFS for Vagrant, culr & other common CLI needed
apt-get -yq install nfs-common curl jq ;