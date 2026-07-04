#!/usr/bin/env bash

cd /home/user/nixos || exit 1

DATE=$(date +"%d.%m.%y")

git add .
git commit -m "$DATE"
git push origin main
sudo nixos-rebuild switch --flake /home/user/nixos#nixos
