#!/bin/bash
apt-get install unzip curl screen openssh-server -y

mkdir datadir && cd datadir
mkdir idenachain.db && cd idenachain.db
wget "https://idena.site/idenachain.db.zip"
unzip idenachain.db.zip && rm idenachain.db.zip

curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest \
| grep browser_download_url \
| grep idena-node-linux-0.* \
| cut -d '"' -f 4 \
| wget -qi -
mv idena-* idena-go && chmod +x idena-go
bash -c 'echo "{\"IpfsConf\":{\"Profile\": \"server\" ,\"FlipPinThreshold\":1},\"Sync\": {\"LoadAllFlips\": true}}" > config.json'
screen -dmS idena ./idena-go --config=config.json --apikey=123
