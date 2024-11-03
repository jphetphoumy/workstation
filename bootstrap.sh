#!/usr/bin/env bash

echo "[+] Bootstrap Workstation"
nix_bin=$(which nix)
if [ $? -eq 1 ];
then
	echo "- Autoinstall of nix"
	sh <(curl -L https://nixos.org/nix/install) --daemon --yes
fi
flake=$(grep "experimental-features = nix-command flakes" /etc/nix/nix.conf -q)
if [ $? -eq 1 ];
then
	echo "[+] Enabling flake and nix-command"
	sudo sed -i '1s/^/experimental-features = nix-command flakes\n/' /etc/nix/nix.conf
fi
echo "[+] Initialize Homemanager"
CWD=pwd
nix run home-manager/$branch -- init --switch ~/Documents/Workstation/home-manager/ 
home-manager switch --flake ~/Documents/Workstation/home-manager
