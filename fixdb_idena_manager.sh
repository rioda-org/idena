idena-manager disable
cd datadir-node1
rm -r idenachain.db
rm -r ipfs
mkdir idenachain.db
cd idenachain.db
sudo apt-get install unzip
#wget "https://idena.site/idenachain.db.zip"
wget "https://sync.idena.site/idenachain.db.zip"
unzip idenachain.db.zip
rm idenachain.db.zip
cd ..
cd ..
idena-manager enable
idena-manager status
