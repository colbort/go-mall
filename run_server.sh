#!/bin/bash

str = $"\n"
enter = $(echo -e " $str")

cd ./service

go build -o ./user/rpc/user ./user/rpc/user.go
chmod +x ./user/rpc/user
nohup ./user/rpc/user -f ./user/rpc/etc/user.yaml > ./user/rpc/nohup.out &
echo "$enter"
go build -o ./user/api/user ./user/api/user.go
chmod +x ./user/api/user
nohup ./user/api/user -f ./user/api/etc/user.yaml > ./user/api/nohup.out &
echo "$enter"

go build -o ./product/rpc/product ./product/rpc/product.go
chmod +x ./product/rpc/product
nohup ./product/rpc/product -f ./product/rpc/etc/product.yaml > ./product/rpc/nohup.out  &
echo "$enter"
go build -o ./product/api/product ./product/api/product.go
chmod +x ./product/api/product
nohup ./product/api/product -f ./product/api/etc/product.yaml > ./product/api/nohup.out &
echo "$enter"

go build -o ./order/rpc/order ./order/rpc/order.go
chmod +x ./order/rpc/order
nohup ./order/rpc/order -f ./order/rpc/etc/order.yaml > ./order/rpc/nohup.out &
echo "$enter"
go build -o ./order/api/order ./order/api/order.go
chmod +x ./order/api/order
nohup ./order/api/order -f ./order/api/etc/order.yaml > ./order/api/nohup.out &
echo "$enter"

go build -o ./pay/rpc/pay ./pay/rpc/pay.go
chmod +x ./pay/rpc/pay
nohup ./pay/rpc/pay -f ./pay/rpc/etc/pay.yaml > ./pay/rpc/nohup.out &
echo "$enter"
go build -o ./pay/api/pay ./pay/api/pay.go
chmod +x ./pay/api/pay
nohup ./pay/api/pay -f ./pay/api/etc/pay.yaml > ./pay/api/nohup.out &
echo "$enter"