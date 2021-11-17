pm2 delete idena-node-proxy
cd idena-node-proxy
mv .env ..
cd ..
rm -r idena-node-proxy
git clone https://github.com/idena-network/idena-node-proxy
mv .env idena-node-proxy/
cd idena-node-proxy
npm install
sed -i 's/stdout/file/g' config_default.json
npm start
