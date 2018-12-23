# README

## 各个服务

redis + pg + api
都是使用docker启动，单独启动，没有使用docker-compose.

### 构建最新的api镜像
> make build_base

### 启动pg数据库

在 .env 配置对应的数据持久化路径、端口等
> make run_pg

### 启动redis

在 .env 配置对应的数据持久化路径、端口等
> make run_redis

### 启动api

在 .env 配置对应的环境变量
> make run_api

### 部署流程
* 拉代码
* make build_base ==> 构建最新代码的镜像
* make run_api  ==> 重新启动

## 注意点

### pg 打开日志收集。
> logging_collector = on
