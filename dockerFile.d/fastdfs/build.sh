#!/usr/bin/env bash
#--------------------------------------------------
# File Name: build.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-3-9-下午10:17
#---------------------说明--------------------------
# 构建fastdfs
#---------------------------------------------------
username="hx940929"
imageName="fastdfs"
versionTag="v1.0"
remoteServer="docker.thesunboy.com:5000"


docker build --file dockerfile.df --tag ${username}/${imageName}:${versionTag} ../build/
echo "打latest标签."

docker tag ${username}/${imageName}:${versionTag} ${username}/${imageName}:latest

docker tag ${username}/${imageName}:${versionTag} ${username}/${imageName}:latest
#docker tag ${username}/${imageName}:${versionTag} ${remoteServer}/${imageName}:latest