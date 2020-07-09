#!/bin/bash

IRIS_PATH=/opt/irisnet
CHAIN_ID=testing
NUM=1
PW=11111111

cd $IRIS_PATH
rm -rf node*
for((i=0;i<=$NUM;i++));
do
pm2 delete node$i
mkdir -p $IRIS_PATH/node$i
done
pm2 delete iris-rest-server

# initialize node0

for((i=0;i<=$NUM;i++));
do
iris init --chain-id=$CHAIN_ID  --home=$IRIS_PATH/node$i --moniker=validator$i
echo $PW | iris gentx --name=validator$i --home=/opt/irisnet/node$i
done

# cp backup/genesis.json node0/config/genesis.json

iris add-genesis-account $(iriscli keys show validator0 --address) 100000000000000iris --home=/opt/irisnet/node0

for((i=1;i<=$NUM;i++));
do
iris add-genesis-account $(iriscli keys show validator$i --address) 100000000000000iris --home=/opt/irisnet/node0
cp /opt/irisnet/node$i/config/gentx/* /opt/irisnet/node0/config/gentx
done

iris collect-gentxs --home=/opt/irisnet/node0

sed -i 's/"unbonding_time": "1814400000000000"/"unbonding_time": "120000000000"/' node0/config/genesis.json

for((i=1;i<=$NUM;i++));
do
  cp node0/config/genesis.json node$i/config
done

pm2 start runnode0.sh --name=node0

sleep 5

rm -rf node1/config/config.toml
cp backup/config.toml node1/config/config.toml


ID=`iris tendermint show-node-id --home=/opt/irisnet/node0`
PEERS="$ID@127.0.0.1:26656"

sed -i "/persistent_peers = ""/c persistent_peers = \"$PEERS\"" node1/config/config.toml


sleep 5
pm2 start runnode1.sh --name=node1

sleep 5
pm2 start start-rest-server.sh --name=iris-rest-server

