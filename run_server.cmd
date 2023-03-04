cd .\service\order\rpc
go run .\order.go -f .\etc\order.yaml

cd ../../
cd .\service\product\rpc
go run .\product.go -f .\etc\product.yaml

cd ../../
cd .\service\order\rpc
go run .\order.go -f .\etc\order.yaml

cd ../../
cd .\service\pay\rpc
go run .\pay.go -f .\etc\pay.yaml


cd ../../
cd .\service\user\api\
go run .\user.go -f .\etc\user.yaml

cd ../../
cd .\service\product\api\
go run .\product.go -f .\etc\product.yaml

cd ../../
cd .\service\order\api
go run .\order.go -f .\etc\order.yaml

cd ../../
cd .\service\pay\api\
go run .\pay.go -f .\etc\pay.yaml