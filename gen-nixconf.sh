#!/bin/bash -ue

conffile=nix.conf
netrc_path=netrc
nixconf_path=$HOME/.config/nix/

if [ -r nixconf_path ]; then
  echo "${netrc_path} file is not found"
  exit 1
fi

echo "experimental-features = nix-command flakes" > $conffile
echo "netrc-file = $HOME/.config/nix/netrc" >> $conffile

cp $netrc_path "$nixconf_path"
cp $conffile "$nixconf_path"
