#!/bin/sh

if ! test -d "$HOME/.dev-desktop"; then
  mkdir "$HOME/.dev-desktop"
fi

cd "$HOME/.dev-desktop"

curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/functions
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/dev-desktop
curl -s --remote-name https://raw.githubusercontent.com/laupiFrpar/dev-desktop/master/Brewfile

/usr/bin/env bash dev-desktop 2>&1 | tee ~/dev-desktop.log
