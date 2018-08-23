#!/bin/bash

# - Need to ensure that your SSH public key is updated at github and
#   bitbucket, and that the dotfiles repository is cloned at
#   $HOME/src/dotfiles.
# - Need to put the vault password in the vpass file (or similar).
# - If sudo requires a password, add --ask-become-pass to the ansible
#   command.


set -e

repourl='git@github.com:sagittarian/dotfiles.git'

sudo apt update
sudo apt -y install git python-pip
sudo python -m pip install ansible

mkdir -p $HOME/src
cd $HOME/src
[ -e $HOME/src/dotfiles ] || git clone "$repourl"

cd $HOME/src/dotfiles/ansible

[ ! -e vpass ] && echo "$vpass" > vpass

ansible-playbook -vvv --vault-password-file=vpass --become-method=sudo "$@" \
                 playbooks/bootstrap.yaml
