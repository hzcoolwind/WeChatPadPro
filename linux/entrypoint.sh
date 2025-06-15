#!/bin/sh
set -e

# 启动系统Redis服务
echo "启动系统Redis服务..."
redis-server /etc/redis.conf &

# 等待系统Redis服务启动
echo "等待Redis启动..."
timeout_count=30
while ! redis-cli ping &>/dev/null; do
    sleep 1
    timeout_count=$((timeout_count - 1))
    if [ $timeout_count -eq 0 ]; then
       echo "Redis启动超时！"
       exit 1
    fi
done
echo "Redis已启动"

# 注释：已移除端口6378的Redis服务启动代码，统一使用系统Redis服务（端口6379）
echo "系统将只使用端口6379的Redis服务"

# 启动pad服务（协议服务）
echo "启动wechatpad服务（协议服务）..."
./stay 




