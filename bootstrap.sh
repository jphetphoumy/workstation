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
CWD=$(pwd)
home_manager_bin=$(which home-manager)
if [ $? -eq 1 ];
then
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
fi
home-manager switch --flake $CWD/home-manager -b backup
