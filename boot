#!/bin/sh

cd /tmp
curl -SsL -o dev-desktop.zip https://github.com/laupiFrpar/dev-desktop/archive/master.zip
unzip dev-desktop
cd dev-desktop-master
/usr/bin/env bash dev-desktop 2>&1 | tee ~/dev-desktop.log
cd ..
rm -rf dev-desktop*
