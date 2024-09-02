#!/bin/bash
sudo ufw disable
if [ -d "/root/idena-node-proxy" ]; then
echo "idena-node-proxy already installed"
else
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git unzip curl screen -y
# Node.js instalation
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -
sudo apt-get install -y nodejs

mkdir datadir && cd datadir
mkdir idenachain.db && cd idenachain.db
#wget "https://sync.idena.site/idenachain.db.zip"
#unzip idenachain.db.zip && rm idenachain.db.zip
cd ../..

curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest \
| grep browser_download_url \
| grep idena-node-linux-1.* \
| cut -d '"' -f 4 \
| wget -qi -
mv idena-* idena-go && chmod +x idena-go
bash -c 'echo "{\"IpfsConf\":{\"Profile\": \"server\" ,\"FlipPinThreshold\":1},\"Sync\": {\"LoadAllFlips\": true, \"AllFlipsLoadingTime\":7200000000000}}" > config.json'

#this is conf for minimal test node
#bash -c 'echo "{\"P2P\":{\"MaxInboundPeers\":4,\"MaxOutboundPeers\":1},\"IpfsConf\":{\"Profile\":\"server\",\"BlockPinThreshold\":0.1,\"FlipPinThreshold\":0.1}}" > config.json'

touch node-restarted.log

tee update << 'EOF'
killall screen
rm idena-go
curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep browser_download_url | grep idena-node-linux-1.* | cut -d '"' -f 4 | wget -qi -
mv idena-node-linux* idena-go
chmod +x idena-go
screen -dmS node $PWD/start
echo Update was successfull
EOF
chmod +x update

tee version << 'EOF'
curl 'http://127.0.0.1:9009/' -H 'Content-Type: application/json' --data '{"method":"dna_version","params":[{}],"id":1,"key":"123"}'
EOF
chmod +x version

bash -c 'echo "while :
do
./idena-go --config=config.json --profile=shared --apikey=123
date >> node-restarted.log
done" > start'
chmod +x start
(crontab -l 2>/dev/null; echo "@reboot screen -dmS node $PWD/start") | crontab -

#npm i npm@latest -g
git clone https://github.com/idena-network/idena-node-proxy
npm i -g pm2

cd idena-node-proxy
wget https://raw.githubusercontent.com/rioda-org/idena/main/index.html

bash -c 'echo "AVAILABLE_KEYS=[\"api1\",\"api2\"]
IDENA_URL=\"http://localhost:9009\"
IDENA_KEY=\"123\"
PORT=80" > .env'
#GOD_API_KEY=\"test\"
#REMOTE_KEYS_ENABLED=0

npm install
sed -i 's/stdout/file/g' config_default.json
npm start
pm2 startup
sudo reboot
fi
