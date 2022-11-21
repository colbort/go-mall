package config

import (
	"github.com/zeromicro/go-zero/core/stores/cache"
	"github.com/zeromicro/go-zero/zrpc"
)

type Config struct {
	zrpc.RpcServerConf
	MySql struct {
		Host string
	}
	CacheRedis cache.CacheConf
	Salt       string
}
