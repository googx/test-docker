#!/usr/bin/env bash
#--------------------------------------------------
# File Name: start_express.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-3-17-下午6:21
#---------------------说明--------------------------
# 启动mongodb 管理员端监控
#---------------------------------------------------

# 需要配合docker的network来使用.https://yeasy.gitbooks.io/docker_practice/content/network/port_mapping.html


function stop() {
docker stop mongodb_s1_express
docker rm mongodb_s1_express

}

function getip() {
    interName=$(route -F |grep default|grep -v grep|awk '{print $8}')
     localIp=$(ifconfig ${interName} |grep inet|grep -v grep |awk '{print $2}'|awk -F : '{print $1}'|sed -n '1p'|xargs)
    echo ${localIp}
#    echo "asdf"
}

function start() {
    localIp=$(getip)
    echo ${localIp}
docker run -d \
    --name mongodb_s1_express \
    --hostname mongodb_s1_express \
    -p 27018:8081 \
    -v /etc/timezone:/etc/timezone \
    -v /etc/localtime:/etc/localtime:ro \
    -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_MONGODB_SERVER="${localIp}" \
    -e ME_CONFIG_MONGODB_ENABLE_ADMIN=true \
    -e ME_CONFIG_MONGODB_ADMINUSERNAME=root \
    -e ME_CONFIG_MONGODB_ADMINPASSWORD=hxadmin1 \
    -e ME_CONFIG_BASICAUTH_USERNAME=hanxu \
    -e ME_CONFIG_BASICAUTH_PASSWORD=hxadmin1 \
    mongo-express

}

stop
start