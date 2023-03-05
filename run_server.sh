#!/bin/bash

str = $"/n"
enter = $(echo -e " $str")

cd ./service

go build ./user/rpc/user.go
chmod +x ./user/rpc/user
nohup ./user/rpc -f ./user/rpc/etc/user.yaml &
echo "$enter"
go build ./user/api/user.go
chmod +x ./user/api/user
nohup ./user/api -f ./user/api/etc/user.yaml &
echo "$enter"

go build ./product/rpc/product.go
chmod +x ./product/rpc/product
nohup ./product/rpc -f ./product/rpc/etc/product.yaml &
echo "$enter"
go build ./product/api/product.go
chmod +x ./product/api/product
nohup ./product/api -f ./product/api/etc/product.yaml &
echo "$enter"

go build ./order/rpc/order.go
chmod +x ./order/rpc/order
nohup ./order/rpc -f ./order/rpc/order/order.yaml &
echo "$enter"
go build ./order/api/order.go
chmod +x ./order/api/order
nohup ./order/api -f ./order/api/order/order.yaml &
echo "$enter"

go build ./pay/rpc/pay.go
chmod +x ./pay/rpc/pay
nohup ./pay/rpc -f ./pay/rpc/etc/pay.yaml &
echo "$enter"
go build ./pay/api/pay.go
chmod +x ./pay/api/pay
nohup ./pay/api -f ./pay/api/etc/pay.yaml &
echo "$enter"