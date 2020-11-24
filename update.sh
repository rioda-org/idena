killall screen
rm /home/idena-*
rm -r /home/datadir/idenachain.db
rm -r /home/datadir/ipfs
cd /home
curl -s https://api.github.com/repos/idena-network/idena-go/releases/latest | grep browser_download_url | grep idena-node-linux-0.* | cut -d '"' -f 4 | wget -qi -
mv idena-node-linux* idena-go
chmod +x idena-go
screen -d -m ./idena-go
echo Script has finished