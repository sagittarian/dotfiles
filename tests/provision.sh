#!/bin/bash

# Provision a vagrant virtual machine so that the bootstrap ansible
# playbook can be run on it.

set -e

sshkey=id_rsa
ssh_config=$(cat <<EOF

Host github.com
  Hostname github.com
  StrictHostKeyChecking no
EOF
)


# sudo resize2fs /dev/sda1 10000M
df

mkdir -p ~$HOME/.ssh
cp $HOME/ssh-config/$sshkey{,.pub} $HOME/.ssh
echo "$ssh_config" >> $HOME/.ssh/config
