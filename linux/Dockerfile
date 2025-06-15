# 使用Alpine基础镜像
FROM docker-0.unsee.tech/alpine:latest

# 设置工作目录
WORKDIR /app

# 设置环境变量（时区）
ENV TZ=Asia/Shanghai

# 更换Alpine的源为阿里云
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装所需包：redis, curl, netcat-openbsd (nc), procps (ps命令), net-tools (netstat等)
# 注意：net-tools在Alpine的社区仓库中，需要启用community仓库。或者我们可以使用busybox自带的netstat（但功能有限），或者安装iproute2（提供ss命令）。
# 我们先启用community仓库，然后安装
RUN apk update && \
    apk add --no-cache \
	        redis \
            curl \
	        netcat-openbsd \
	        procps \
	        net-tools

# 设置时区：安装tzdata包，然后设置时区
RUN apk add --no-cache tzdata && \
		cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
	    echo "${TZ}" > /etc/timezone && \
		apk del tzdata

# 清理缓存，不过apk add --no-cache已经不会缓存，所以不需要额外清理

# 复制Redis配置（注意：在Alpine中，redis默认配置文件是/etc/redis.conf）
COPY redis.conf /etc/redis.conf

# 复制应用代码
COPY . .

# 设置权限
RUN chmod -R 755 /app && \
    find /app -type f -name "*.sh" -exec chmod +x {} \;

# 给启动脚本增加执行权限
RUN chmod +x entrypoint.sh
RUN chmod +x stay

# 暴露端口
EXPOSE 8059
EXPOSE 8099

# 启动命令
CMD ["./entrypoint.sh"]
