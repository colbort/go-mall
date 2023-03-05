#!/bin/bash

str = $"/n"
enter = $(echo -e " $str")

cd ./service

go build -o ./user/rpc/user ./user/rpc/user.go
chmod +x ./user/rpc/user
nohup ./user/rpc -f ./user/rpc/etc/user.yaml &
echo "$enter"
go build -o ./user/api/user ./user/api/user.go
chmod +x ./user/api/user
nohup ./user/api -f ./user/api/etc/user.yaml &
echo "$enter"

go build -o ./product/rpc/product ./product/rpc/product.go
chmod +x ./product/rpc/product
nohup ./product/rpc -f ./product/rpc/etc/product.yaml &
echo "$enter"
go build -o ./product/api/product ./product/api/product.go
chmod +x ./product/api/product
nohup ./product/api -f ./product/api/etc/product.yaml &
echo "$enter"

go build -o ./order/rpc/order ./order/rpc/order.go
chmod +x ./order/rpc/order
nohup ./order/rpc -f ./order/rpc/order/order.yaml &
echo "$enter"
go build -o ./order/api/order ./order/api/order.go
chmod +x ./order/api/order
nohup ./order/api -f ./order/api/order/order.yaml &
echo "$enter"

go build -o ./pay/rpc/pay ./pay/rpc/pay.go
chmod +x ./pay/rpc/pay
nohup ./pay/rpc -f ./pay/rpc/etc/pay.yaml &
echo "$enter"
go build -o ./pay/api/pay ./pay/api/pay.go
chmod +x ./pay/api/pay
nohup ./pay/api -f ./pay/api/etc/pay.yaml &
echo "$enter"