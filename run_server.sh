cd ./services

nohup ./user/rpc -f ./user/rpc/etc/user.yaml &
nohup ./user/api -f ./user/api/etc/user.yaml &

nohup ./product/rpc -f ./product/rpc/etc/product.yaml &
nohup ./product/api -f ./product/api/etc/product.yaml &

nohup ./order/rpc -f ./order/rpc/order/order.yaml &
nohup ./order/api -f ./order/api/order/order.yaml &

nohup ./pay/rpc -f ./pay/rpc/etc/pay.yaml &
nohup ./pay/api -f ./pay/api/etc/pay.yaml &