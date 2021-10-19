killall screen
rm start
bash -c 'echo "while :
do
./idena-go --config=config.json --profile=shared --apikey=123
date >> node-restarted.log
done" > start'
chmod +x start
screen -dmS node ./start
