#!/bin/bash
sudo apt-get install unzip curl screen -y
mkdir shared-node
cd shared-node
mkdir datadir
cd datadir
mkdir idenachain.db
cd idenachain.db
#wget https://idena.site/idenachain.db.zip
wget "https://sync.idena-ar.com/idenachain.db.zip"
unzip idenachain.db.zip
rm idenachain.db.zip
cd ..
cd ..
curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep browser_download_url | grep idena-node-linux-0.* | cut -d '"' -f 4 | wget -qi -
mv idena-* idena-go && chmod +x idena-go
bash -c 'echo "{\"IpfsConf\":{\"Profile\": \"server\" ,\"FlipPinThreshold\":1},\"Sync\": {\"LoadAllFlips\": true}}" > config.json'
touch node-restarted.log
bash -c 'echo "while :
do
./idena-go --config=config.json --apikey=123
date >> node-restarted.log
done" > start'
chmod +x start
screen -dmS node ./start
