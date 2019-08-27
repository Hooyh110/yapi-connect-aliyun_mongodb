FROM node:11 as builder

RUN apt-get install -y  git python make openssl tar gcc
ADD yapi.tgz /home/
RUN mkdir /api && mv /home/package /api/vendors
RUN cd /api/vendors && \
    npm install --production --registry https://registry.npm.taobao.org

FROM node:11

MAINTAINER itservice
ENV TZ="Asia/Shanghai" HOME="/"
WORKDIR ${HOME}

COPY --from=builder /api/vendors /api/vendors
COPY config.json /api/
EXPOSE 3000

#WORKDIR /api/vendors
#####首次构建部署时，请将注释打开并对数据库索引和管理员账户进行初始化，管理员账户名在config.json文件中adminAccount配置
#RUN cd /api/vendors && \
#    npm run install-server

#WORKDIR ${HOME}
#### container启动脚本
COPY docker-entrypoint.sh /api/
RUN chmod 755 /api/docker-entrypoint.sh

ENTRYPOINT ["/api/docker-entrypoint.sh"]
