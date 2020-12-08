#!/bin/bash
apt-get update && apt-get upgrade -y
apt-get install git npm unzip curl screen -y

mkdir datadir && cd datadir
mkdir idenachain.db && cd idenachain.db
wget "https://idena.site/idenachain.db.zip"
unzip idenachain.db.zip && rm idenachain.db.zip
cd ..
cd ..

curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest \
| grep browser_download_url \
| grep idena-node-linux-0.* \
| cut -d '"' -f 4 \
| wget -qi -
mv idena-* idena-go && chmod +x idena-go
bash -c 'echo "{\"IpfsConf\":{\"Profile\": \"server\" ,\"FlipPinThreshold\":1},\"Sync\": {\"LoadAllFlips\": true}}" > config.json'

touch node-restarted.log

bash -c 'echo "while :
do
./idena-go --config=config.json
date >> node-restarted.log
sleep 3
done" > start'

chmod +x start
screen -dmS idena ./start

npm i npm@latest -g
git clone https://github.com/idena-network/idena-node-proxy
npm i -g pm2

cd datadir
apikey=$(<"api.key")
cd ..

cd idena-node-proxy

bash -c 'echo "AVAILABLE_KEYS=[\"api1\",\"api2\"]
IDENA_URL=\"http://localhost:9009\"
IDENA_KEY=\"'$apikey'\"
PORT=80" > .env'

npm installna
npm start
