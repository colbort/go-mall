cd .\service\order\rpc
go run .\order.go -f .\etc\order.yaml

cd ../../
cd .\product\rpc
go run .\product.go -f .\etc\product.yaml

cd ../../
cd .\order\rpc
go run .\order.go -f .\etc\order.yaml

cd ../../
cd .\pay\rpc
go run .\pay.go -f .\etc\pay.yaml


cd ../../
cd .\user\api\
go run .\user.go -f .\etc\user.yaml

cd ../../
cd .\product\api\
go run .\product.go -f .\etc\product.yaml

cd ../../
cd .\order\api
go run .\order.go -f .\etc\order.yaml

cd ../../
cd .\pay\api\
go run .\pay.go -f .\etc\pay.yaml