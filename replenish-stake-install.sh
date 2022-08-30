sudo apt-get install jq
wget https://raw.githubusercontent.com/rioda-org/idena/main/replenish-stake.sh
chmod +x replenish-stake.sh
(crontab -l 2>/dev/null; echo "0 0 * * * $PWD/replenish-stake.sh") | crontab -
