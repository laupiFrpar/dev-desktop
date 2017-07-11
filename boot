#!/bin/sh

if ! test -d "$HOME/.dev-desktop"; then
  echo "\nCreating the directory \"$HOME/.dev-desktop\" ...\n"
  mkdir "$HOME/.dev-desktop"
else
  echo "The directory \"$HOME/.dev-desktop\" already created. Skipping ..."
fi

cd "$HOME/.dev-desktop"

echo "\nDownloading functions script ..."
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/functions
echo "OK\nDownloading dev-desktop script ..."
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/dev-desktop
echo "OK\nDownloading Brewfile ..."
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/Brewfile
echo "OK"

echo "\nConfiguring your machine ...\n"
/usr/bin/env bash dev-desktop 2>&1 | tee ~/dev-desktop.log
