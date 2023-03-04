# 一、编写user服务
### 1、生成 user model 模型
```shell
cd mall/service/user
```
- 创建 sql 文件
```shell
vim model/user.sql
```
- 编写 sql 文件
```sql
CREATE TABLE `user` (
	`id` bigint unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(255)  NOT NULL DEFAULT '' COMMENT '用户姓名',
	`gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户性别',
	`mobile` varchar(255)  NOT NULL DEFAULT '' COMMENT '用户电话',
	`password` varchar(255)  NOT NULL DEFAULT '' COMMENT '用户密码',
	`create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	`update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE KEY `idx_mobile_unique` (`mobile`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
```
- 运行模板生成命令
```shell
goctl model mysql ddl -src ./model/user.sql -dir ./model -c
```
### 2、生成 user api 服务
- 创建 api 文件
```shell
vim api/user.api
```
- 编写 api 文件
```api
type (
	// 用户登录
	LoginRequest {
		Mobile   string `json:"mobile"`
		Password string `json:"password"`
	}
	LoginResponse {
		AccessToken  string `json:"accessToken"`
		AccessExpire int64  `json:"accessExpire"`
	}
	// 用户登录

	// 用户注册
	RegisterRequest {
		Name     string `json:"name"`
		Gender   int64  `json:"gender"`
		Mobile   string `json:"mobile"`
		Password string `json:"password"`
	}
	RegisterResponse {
		Id     int64  `json:"id"`
		Name   string `json:"name"`
		Gender int64  `json:"gender"`
		Mobile string `json:"mobile"`
	}
	// 用户注册

	// 用户信息
	UserInfoResponse {
		Id     int64  `json:"id"`
		Name   string `json:"name"`
		Gender int64  `json:"gender"`
		Mobile string `json:"mobile"`
	}
	// 用户信息
)

service User {
	@handler Login
	post /api/user/login(LoginRequest) returns (LoginResponse)
	
	@handler Register
	post /api/user/register(RegisterRequest) returns (RegisterResponse)
}

@server(
	jwt: Auth
)
service User {
	@handler UserInfo
	post /api/user/userinfo() returns (UserInfoResponse)
}
```
- 运行模板生成命令

### 3、生成 user rpc 服务
- 创建 proto 文件
```shell
vim rpc/user.proto
```
- 编写 proto 文件
```protobuf
syntax = "proto3";

package user;

option go_package = "./user";

// 用户登录
message LoginRequest {
    string Mobile = 1;
    string Password = 2;
}
message LoginResponse {
    int64 Id = 1;
    string Name = 2;
    int64 Gender = 3;
    string Mobile = 4;
}
// 用户登录

// 用户注册
message RegisterRequest {
    string Name = 1;
    int64 Gender = 2;
    string Mobile = 3;
    string Password = 4;
}
message RegisterResponse {
    int64 Id = 1;
    string Name = 2;
    int64 Gender = 3;
    string Mobile = 4;
}
// 用户注册

// 用户信息
message UserInfoRequest {
    int64 Id = 1;
}
message UserInfoResponse {
    int64 Id = 1;
    string Name = 2;
    int64 Gender = 3;
    string Mobile = 4;
}
// 用户信息

service User {
    rpc Login(LoginRequest) returns(LoginResponse);
    rpc Register(RegisterRequest) returns(RegisterResponse);
    rpc UserInfo(UserInfoRequest) returns(UserInfoResponse);
}
```
- 运行模板生成命令
```shell
goctl rpc protoc ./rpc/user.proto --go_out=./rpc/types --go-grpc_out=./rpc/types --zrpc_out=./rpc
```

```shell
 go run user.go -f etc/user.yaml Starting rpc server at 127.0.0.1:9000...
 go run user.go -f etc/user.yaml Starting server at 0.0.0.0:8000...
```



# 二、编写product服务
### 1、生成 product model 模型
```shell
cd mall/service/product
```
- 创建 sql 文件
```shell
vim model/product.sql
```
- 编写 sql 文件
```sql
CREATE TABLE `product` (
                           `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                           `name` varchar(255)  NOT NULL DEFAULT '' COMMENT '产品名称',
                           `desc` varchar(255)  NOT NULL DEFAULT '' COMMENT '产品描述',
                           `stock` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '产品库存',
                           `amount` int(10) unsigned NOT NULL DEFAULT '0'  COMMENT '产品金额',
                           `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '产品状态',
                           `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                           `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
```
- 运行模板生成命令
```shell
goctl model mysql ddl -src ./model/product.sql -dir ./model -c
```
### 2、生成 user api 服务
- 创建 api 文件
```shell
vim api/product.api
```
- 编写 api 文件
```api
type (
    // 产品创建
    CreateRequest {
        Name   string `json:"name"`
        Desc   string `json:"desc"`
        Stock  int64  `json:"stock"`
        Amount int64  `json:"amount"`
        Status int64  `json:"status"`
    }
    CreateResponse {
        Id int64 `json:"id"`
    }
        // 产品创建

        // 产品修改
    UpdateRequest {
        Id     int64  `json:"id"`
        Name   string `json:"name,optional"`
        Desc   string `json:"desc,optional"`
        Stock  int64  `json:"stock"`
        Amount int64  `json:"amount,optional"`
        Status int64  `json:"status,optional"`
    }
    UpdateResponse {
    }
        // 产品修改

        // 产品删除
    RemoveRequest {
        Id int64 `json:"id"`
    }
    RemoveResponse {
    }
        // 产品删除

        // 产品详情
    DetailRequest {
        Id int64 `json:"id"`
    }
    DetailResponse {
        Id     int64  `json:"id"`
        Name   string `json:"name"`
        Desc   string `json:"desc"`
        Stock  int64  `json:"stock"`
        Amount int64  `json:"amount"`
        Status int64  `json:"status"`
    }
    // 产品详情
)

@server(
    jwt: Auth
)
service Product {
    @handler Create
    post /api/product/create(CreateRequest) returns (CreateResponse)

    @handler Update
    post /api/product/update(UpdateRequest) returns (UpdateResponse)

    @handler Remove
    post /api/product/remove(RemoveRequest) returns (RemoveResponse)

    @handler Detail
    post /api/product/detail(DetailRequest) returns (DetailResponse)
}
```
- 运行模板生成命令

### 3、生成 product rpc 服务
- 创建 proto 文件
```shell
vim rpc/product.proto
```
- 编写 proto 文件

```protobuf
syntax = "proto3";

package product;

option go_package = "./product";

// 产品创建
message CreateRequest {
  string Name = 1;
  string Desc = 2;
  int64 Stock = 3;
  int64 Amount = 4;
  int64 Status = 5;
}
message CreateResponse {
  int64 id = 1;
}
// 产品创建

// 产品修改
message UpdateRequest {
  int64 id = 1;
  string Name = 2;
  string Desc = 3;
  int64 Stock = 4;
  int64 Amount = 5;
  int64 Status = 6;
}
message UpdateResponse {
}
// 产品修改

// 产品删除
message RemoveRequest {
  int64 id = 1;
}
message RemoveResponse {
}
// 产品删除

// 产品详情
message DetailRequest {
  int64 id = 1;
}
message DetailResponse {
  int64 id = 1;
  string Name = 2;
  string Desc = 3;
  int64 Stock = 4;
  int64 Amount = 5;
  int64 Status = 6;
}
// 产品详情

service Product {
  rpc Create(CreateRequest) returns(CreateResponse);
  rpc Update(UpdateRequest) returns(UpdateResponse);
  rpc Remove(RemoveRequest) returns(RemoveResponse);
  rpc Detail(DetailRequest) returns(DetailResponse);
}
```
- 运行模板生成命令
```shell
goctl rpc protoc ./rpc/product.proto --go_out=./rpc/types --go-grpc_out=./rpc/types --zrpc_out=./rpc
```

```shell
 go run user.go -f etc/product.yaml Starting rpc server at 127.0.0.1:9001...
 go run user.go -f etc/product.yaml Starting server at 0.0.0.0:8001...
```


# 三、编写order服务
### 1、生成 order model 模型
```shell
cd mall/service/order
```
- 创建 sql 文件
```shell
vim model/order.sql
```
- 编写 sql 文件
```sql
CREATE TABLE `order` (
                         `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                         `uid` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
                         `pid` bigint unsigned NOT NULL DEFAULT '0' COMMENT '产品ID',
                         `amount` int(10) unsigned NOT NULL DEFAULT '0'  COMMENT '订单金额',
                         `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态',
                         `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                         `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`),
                         KEY `idx_uid` (`uid`),
                         KEY `idx_pid` (`pid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
```
- 运行模板生成命令
```shell
goctl model mysql ddl -src ./model/order.sql -dir ./model -c
```
### 2、生成 order api 服务
- 创建 api 文件
```shell
vim api/order.api
```
- 编写 api 文件
```api
type (
    // 订单创建
    CreateRequest {
        Uid    int64 `json:"uid"`
        Pid    int64 `json:"pid"`
        Amount int64 `json:"amount"`
        Status int64 `json:"status"`
    }
    CreateResponse {
        Id int64 `json:"id"`
    }
        // 订单创建

        // 订单修改
    UpdateRequest {
        Id     int64 `json:"id"`
        Uid    int64 `json:"uid,optional"`
        Pid    int64 `json:"pid,optional"`
        Amount int64 `json:"amount,optional"`
        Status int64 `json:"status,optional"`
    }
    UpdateResponse {
    }
        // 订单修改

        // 订单删除
    RemoveRequest {
        Id int64 `json:"id"`
    }
    RemoveResponse {
    }
        // 订单删除

        // 订单详情
    DetailRequest {
        Id int64 `json:"id"`
    }
    DetailResponse {
        Id     int64 `json:"id"`
        Uid    int64 `json:"uid"`
        Pid    int64 `json:"pid"`
        Amount int64 `json:"amount"`
        Status int64 `json:"status"`
    }
        // 订单详情

        // 订单列表
    ListRequest {
        Uid int64 `json:"uid"`
    }
    ListResponse {
        Id     int64 `json:"id"`
        Uid    int64 `json:"uid"`
        Pid    int64 `json:"pid"`
        Amount int64 `json:"amount"`
        Status int64 `json:"status"`
    }
    // 订单列表
)

@server(
    jwt: Auth
)
service Order {
    @handler Create
    post /api/order/create(CreateRequest) returns (CreateResponse)

    @handler Update
    post /api/order/update(UpdateRequest) returns (UpdateResponse)

    @handler Remove
    post /api/order/remove(RemoveRequest) returns (RemoveResponse)

    @handler Detail
    post /api/order/detail(DetailRequest) returns (DetailResponse)

    @handler List
    post /api/order/list(ListRequest) returns (ListResponse)
}
```
- 运行模板生成命令

### 3、生成 user rpc 服务
- 创建 proto 文件
```shell
vim rpc/order.proto
```
- 编写 proto 文件

```protobuf
syntax = "proto3";

package order;

option go_package = "./order";

// 订单创建
message CreateRequest {
  int64 Uid = 1;
  int64 Pid = 2;
  int64 Amount = 3;
  int64 Status = 4;
}
message CreateResponse {
  int64 id = 1;
}
// 订单创建

// 订单修改
message UpdateRequest {
  int64 id = 1;
  int64 Uid = 2;
  int64 Pid = 3;
  int64 Amount = 4;
  int64 Status = 5;
}
message UpdateResponse {
}
// 订单修改

// 订单删除
message RemoveRequest {
  int64 id = 1;
}
message RemoveResponse {
}
// 订单删除

// 订单详情
message DetailRequest {
  int64 id = 1;
}
message DetailResponse {
  int64 id = 1;
  int64 Uid = 2;
  int64 Pid = 3;
  int64 Amount = 4;
  int64 Status = 5;
}
// 订单详情

// 订单列表
message ListRequest {
  int64 uid = 1;
}
message ListResponse {
  repeated DetailResponse data = 1;
}
// 订单列表

// 订单支付
message PaidRequest {
  int64 id = 1;
}
message PaidResponse {
}
// 订单支付

service Order {
  rpc Create(CreateRequest) returns(CreateResponse);
  rpc Update(UpdateRequest) returns(UpdateResponse);
  rpc Remove(RemoveRequest) returns(RemoveResponse);
  rpc Detail(DetailRequest) returns(DetailResponse);
  rpc List(ListRequest) returns(ListResponse);
  rpc Paid(PaidRequest) returns(PaidResponse);
}
```
- 运行模板生成命令
```shell
goctl rpc protoc ./rpc/user.proto --go_out=./rpc/types --go-grpc_out=./rpc/types --zrpc_out=./rpc
```

```shell
 go run user.go -f etc/order.yaml Starting rpc server at 127.0.0.1:9002...
 go run user.go -f etc/order.yaml Starting server at 0.0.0.0:8002...
```



# 四、编写pay服务
### 1、生成 pay model 模型
```shell
cd mall/service/pay
```
- 创建 sql 文件
```shell
vim model/pay.sql
```
- 编写 sql 文件
```sql
CREATE TABLE `pay` (
                       `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                       `uid` bigint unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
                       `oid` bigint unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
                       `amount` int(10) unsigned NOT NULL DEFAULT '0'  COMMENT '产品金额',
                       `source` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付方式',
                       `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态',
                       `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                       `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       PRIMARY KEY (`id`),
                       KEY `idx_uid` (`uid`),
                       KEY `idx_oid` (`oid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
```
- 运行模板生成命令
```shell
goctl model mysql ddl -src ./model/pay.sql -dir ./model -c
```
### 2、生成 user api 服务
- 创建 api 文件
```shell
vim api/pay.api
```
- 编写 api 文件
```api
type (
    // 支付创建
    CreateRequest {
        Uid    int64 `json:"uid"`
        Oid    int64 `json:"oid"`
        Amount int64 `json:"amount"`
    }
    CreateResponse {
        Id int64 `json:"id"`
    }
        // 支付创建

        // 支付详情
    DetailRequest {
        Id int64 `json:"id"`
    }
    DetailResponse {
        Id     int64 `json:"id"`
        Uid    int64 `json:"uid"`
        Oid    int64 `json:"oid"`
        Amount int64 `json:"amount"`
        Source int64 `json:"source"`
        Status int64 `json:"status"`
    }
        // 支付详情

        // 支付回调
    CallbackRequest {
        Id     int64 `json:"id"`
        Uid    int64 `json:"uid"`
        Oid    int64 `json:"oid"`
        Amount int64 `json:"amount"`
        Source int64 `json:"source"`
        Status int64 `json:"status"`
    }
    CallbackResponse {
    }
    // 支付回调

)

@server(
    jwt: Auth
)
service Pay {
    @handler Create
    post /api/pay/create(CreateRequest) returns (CreateResponse)

    @handler Detail
    post /api/pay/detail(DetailRequest) returns (DetailResponse)

    @handler Callback
    post /api/pay/callback(CallbackRequest) returns (CallbackResponse)
}
```
- 运行模板生成命令

### 3、生成 product rpc 服务
- 创建 proto 文件
```shell
vim rpc/pay.proto
```
- 编写 proto 文件

```protobuf
syntax = "proto3";

package pay;

option go_package = "./pay";

// 支付创建
message CreateRequest {
  int64 Uid = 1;
  int64 Oid = 2;
  int64 Amount = 3;
}
message CreateResponse {
  int64 id = 1;
}
// 支付创建

// 支付详情
message DetailRequest {
  int64 id = 1;
}
message DetailResponse {
  int64 id = 1;
  int64 Uid = 2;
  int64 Oid = 3;
  int64 Amount = 4;
  int64 Source = 5;
  int64 Status = 6;
}
// 支付详情

// 支付详情
message CallbackRequest {
  int64 id = 1;
  int64 Uid = 2;
  int64 Oid = 3;
  int64 Amount = 4;
  int64 Source = 5;
  int64 Status = 6;
}
message CallbackResponse {
}
// 支付详情


service Pay {
  rpc Create(CreateRequest) returns(CreateResponse);
  rpc Detail(DetailRequest) returns(DetailResponse);
  rpc Callback(CallbackRequest) returns(CallbackResponse);
}
```
- 运行模板生成命令
```shell
goctl rpc protoc ./rpc/pay.proto --go_out=./rpc/types --go-grpc_out=./rpc/types --zrpc_out=./rpc
```

```shell
 go run user.go -f etc/pay.yaml Starting rpc server at 127.0.0.1:9003...
 go run user.go -f etc/pay.yaml Starting server at 0.0.0.0:8003...
```

- 查看docker容器ip
```shell
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 容器hash
```