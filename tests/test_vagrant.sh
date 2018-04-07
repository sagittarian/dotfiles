#!/bin/bash

set -e

basedir=$(readlink -f $(dirname $BASH_SOURCE))
echo Base directory: $basedir
vagrantdir=$basedir/vagrant
echo Vagrant directory: $vagrantdir

if [ ! -f "$basedir/vpass" ]; then
    echo "Put your vault password in the '$basedir/vpass' file"
    exit 1
fi
vpass=$(cat $basedir/vpass)

if [ ! -d $vagrantdir ]; then
    mkdir -p $vagrantdir
    cp $basedir/Vagrantfile $basedir/provision.sh $vagrantdir
fi
cd $vagrantdir
vagrant up

script=$(cat $basedir/moon.sh | sed -e "s/\$vpass/$vpass/")
vagrant ssh -c "$script"
