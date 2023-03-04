cd ./service
cd ./user/rpc
go build ./user.go
./user -d -f etc/user.yaml

cd ../../
cd ./user/api
go build ./user.go
./user -d -f etc/user.yaml

cd ../../
cd ./product/rpc
go build ./product.go
./product -d -f etc/product.yaml

cd ../../
cd ./product/api
go build ./product.go
./product -d -f etc/product.yaml

cd ../../
cd ./order/rpc
go build ./order.go
./order -d -f etc/order.yaml

cd ../../
cd ./order/api
go build ./order.go
./order -d -f etc/order.yaml

cd ../../
cd ./pay/rpc
go build ./pay.go
./pay -d -f etc/pay.yaml

cd ../../
cd ./pay/api
go build ./pay.go
./pay -d -f etc/pay.yaml