#!/bin/bash -ue

conffile=nix.conf
nixconf_path=$HOME/.config/nix/

echo "experimental-features = nix-command flakes" > $conffile
echo "netrc-file = $HOME/.config/nix/netrc" >> $conffile

cp ./netrc $nixconf_path
cp $conffile $nixconf_path
