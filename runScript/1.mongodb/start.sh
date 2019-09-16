#!/usr/bin/env bash
#--------------------------------------------------
# File Name: start.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-3-17-下午6:12
#---------------------说明--------------------------
#
#---------------------------------------------------
#https://hub.docker.com/_/mongo 参考相关启动参数变量
docker stop mongodb_s1
docker rm mongodb_s1

docker run -d -p 27017:27017 \
--name mongodb_s1 \
--hostname mongodb_s1 \
-v /etc/timezone:/etc/timezone \
-v /etc/localtime:/etc/localtime:ro \
-v /data/docker/mongodb_s1/configdb:/data/configdb \
-v /data/docker/mongodb_s1/db/:/data/db \
-e MONGO_INITDB_ROOT_USERNAME=root \
-e MONGO_INITDB_ROOT_PASSWORD=hxadmin1 \
mongo:4


导出:
mongoexport -u root -p hxadmin1 --authenticationDatabase=admin --db pytest --collection=AmazonBookPages -o AmazonBookPages.json

导入:
mongoimport -u root -p hxadmin1 --authenticationDatabase=admin --db pytest --collection=AmazonBookPages --file= AmazonBookPages.json
