#!/bin/bash
idena-manager disable
rm -r ~/datadir-node1/idenachain.db
cd datadir-node1
mkdir idenachain.db
cd idenachain.db
apt-get install unzip
wget "https://idena.site/idenachain.db.zip"
unzip idenachain.db.zip
rm idenachain.db.zip
idena-manager enable
idena-manager status