#!/bin/bash

str = $"/n"
enter = $(echo -e " $str")

cd ./service

go build ./user/rpc/user.go
nohup ./user/rpc -f ./user/rpc/etc/user.yaml &
echo "$enter"
go build ./user/api/user.go
nohup ./user/api -f ./user/api/etc/user.yaml &
echo "$enter"

go build ./product/rpc/product.go
nohup ./product/rpc -f ./product/rpc/etc/product.yaml &
echo "$enter"
go build ./product/api/product.go
nohup ./product/api -f ./product/api/etc/product.yaml &
echo "$enter"

go build ./order/rpc/order.go
nohup ./order/rpc -f ./order/rpc/order/order.yaml &
echo "$enter"
go build ./order/api/order.go
nohup ./order/api -f ./order/api/order/order.yaml &
echo "$enter"

go build ./pay/rpc/pay.go
nohup ./pay/rpc -f ./pay/rpc/etc/pay.yaml &
echo "$enter"
go build ./pay/api/pay.go
nohup ./pay/api -f ./pay/api/etc/pay.yaml &
echo "$enter"