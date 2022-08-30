addy=$(curl 'http://127.0.0.1:9009/' -H 'Content-Type: application/json' --data '{"method":"dna_getCoinbaseAddr","params":[],"id":1,"key":"123"}' | jq .result)
balance=$(curl 'http://127.0.0.1:9009/' -H 'Content-Type: application/json' --data '{"method":"dna_getBalance","params":['$addy'],"id":2,"key":"123"}' | jq .result.balance)
balance=$(echo "$balance" | tr -d \")
balance=${balance%.*}
replenish=$(($balance-2))
curl 'http://127.0.0.1:9009/' -H 'Content-Type: application/json' --data '{"method":"dna_sendTransaction","params":[{"type":22,"from":'$addy',"to":'$addy',"amount":'$replenish'}],"id":1,"key":"123"}'
