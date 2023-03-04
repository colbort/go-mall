cd ./service
cd ./user/rpc
go build ./user.go
./user -f etc/user.yaml -d

cd ../../
cd ./user/api
go build ./user.go
./user -f etc/user.yaml -d

cd ../../
cd ./product/rpc
go build ./product.go
./product -f etc/product.yaml -d

cd ../../
cd ./product/api
go build ./product.go
./product -f etc/product.yaml -d

cd ../../
cd ./order/rpc
go build ./order.go
./order -f etc/order.yaml -d

cd ../../
cd ./order/api
go build ./order.go
./order -f etc/order.yaml -d

cd ../../
cd ./pay/rpc
go build ./pay.go
./pay -f etc/pay.yaml -d

cd ../../
cd ./pay/api
go build ./pay.go
./pay -f etc/pay.yaml -d