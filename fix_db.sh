killall screen
cd datadir
rm -r idenachain.db
rm -r ipfs
mkdir idenachain.db
cd idenachain.db
apt-get install unzip
#wget "https://idena.site/idenachain.db.zip"
wget "https://sync.idena.site/idenachain.db.zip"
unzip idenachain.db.zip
rm idenachain.db.zip
cd ..
cd ..
screen -dmS idena ./idena-go
