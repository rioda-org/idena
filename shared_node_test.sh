#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git npm unzip curl screen -y
mkdir datadir && cd datadir
mkdir idenachain.db && cd idenachain.db
#wget "https://idena.site/idenachain.db.zip"
wget "https://sync.idena.site/idenachain.db.zip"
unzip idenachain.db.zip && rm idenachain.db.zip
cd .. && cd ..
curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest \
| grep browser_download_url \
| grep idena-node-linux-0.* \
| cut -d '"' -f 4 \
| wget -qi -
mv idena-* idena-go && chmod +x idena-go
bash -c 'echo "{\"P2P\":{\"MaxInboundPeers\":4,\"MaxOutboundPeers\":1},\"IpfsConf\":{\"Profile\":\"server\",\"BlockPinThreshold\":0.1,\"FlipPinThreshold\":0.1}}" > config.json'
touch node-restarted.log
bash -c 'echo "while :
do
./idena-go --config=config.json --apikey=123
date >> node-restarted.log
done" > start'
chmod +x start
(crontab -l 2>/dev/null; echo "@reboot screen -dmS node $PWD/start") | crontab -
bash -c 'echo "screen -S node -X quit
screen -dmS node /root/start" > restart'
chmod +x restart
(crontab -l 2>/dev/null; echo "0 0 * * * $PWD/restart") | crontab -
npm i npm@latest -g
git clone https://github.com/idena-network/idena-node-proxy
npm i -g pm2
cd idena-node-proxy
bash -c 'echo "AVAILABLE_KEYS=[\"test_apikey\"]
IDENA_URL=\"http://localhost:9009\"
IDENA_KEY=\"123\"
PORT=80" > .env'
npm install
npm start
pm2 startup
sudo reboot
