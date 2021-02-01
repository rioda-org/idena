sudo apt-get install unzip -y
killall screen
rm /home/idena-*
rm -r /home/datadir/idenachain.db
rm -r /home/datadir/ipfs
cd /home
mkdir datadir && cd datadir
mkdir idenachain.db && cd idenachain.db
#wget "https://idena.site/idenachain.db.zip"
wget "https://sync.idena-ar.com/idenachain.db.zip"
unzip idenachain.db.zip && rm idenachain.db.zip
cd ..
cd ..
curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep browser_download_url | grep idena-node-linux-0.* | cut -d '"' -f 4 | wget -qi -
mv idena-node-linux* idena-go
chmod +x idena-go
screen -d -m ./idena-go
echo Script has finished
