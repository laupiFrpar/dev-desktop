#!/bin/sh

cd /tmp
curl -SsL -o dev-desktop.zip https://github.com/laupiFrpar/dev-desktop/archive/main.zip
unzip dev-desktop > ~/.dev-desktop.log
cd dev-desktop-main
./dev-desktop 2>&1 | tee ~/dev-desktop.log
cd ..
rm -rf dev-desktop*
