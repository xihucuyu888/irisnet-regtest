#!/bin/bash
PW=11111111


echo $PW | iriscli bank send --to=faa1880dqz6x8h0r2pxwy7nupypdrs07vk2mqghrgl --from=validator1 --chain-id=testing --amount=100000iris --fee=0.5iris
sleep 10
echo $PW | iriscli bank send --to=faa1rml69htrp4ye4u6fuhyt9l3vdzuq0p00m2y7jn --from=validator1 --chain-id=testing --amount=100000iris --fee=0.5iris
sleep 10
echo $PW | iriscli bank send --to=faa1qgpu0x0hlm5x7hz26vameqwmcru2ptarz9s98p --from=validator1 --chain-id=testing --amount=100000iris --fee=0.5iris
sleep 10
echo $PW | iriscli bank send --to=faa1temysg90fdz2mj5vzx0y9qxw8j6au823kvv4hf --from=validator1 --chain-id=testing --amount=100000iris --fee=0.5iris
