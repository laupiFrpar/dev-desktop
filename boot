#!/bin/sh

if ! test -d "$HOME/.dev-desktop"; then
  printf "\nCreating the directory \"$HOME/.dev-desktop\" ...\n"
  mkdir "$HOME/.dev-desktop"
else
  printf "The directory \"$HOME/.dev-desktop\" already created. Skipping ..."
fi

cd "$HOME/.dev-desktop"

printf "\nDownloading functions script ..."
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/functions
printf "OK\nDownloading dev-desktop script ..."
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/dev-desktop
printf "OK\nDownloading Brewfile ..."
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/Brewfile
printf "OK"

printf "\nConfiguring your machine ...\n"
/usr/bin/env bash dev-desktop 2>&1 | tee ~/dev-desktop.log
