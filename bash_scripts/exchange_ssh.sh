#!/bin/bash
# Exchange ssh RSA key with remote server, creating one if needed
# author: Prof. Aaron M. Johnson

if [ "$1" = "" ]; then
 echo "usage: `basename $0` user@server"
 exit
fi

if [ ! -e ~/.ssh/id_rsa.pub ]
  then
  pushd
  echo "No id_rsa.pub found! Creating one...Press [ENTER] then choose passphrase (or press [ENTER] agin)"
  cd ~/.ssh/
  ssh-keygen -t rsa
fi

echo "Attempting to transfer authorization key..."

cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir ~/.ssh 2>/dev/null ; cat >> ~/.ssh/authorized_keys"
