#!/usr/bin/env bash
#--------------------------------------------------
# File Name: build.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-3-14-上午9:53
#---------------------说明--------------------------
#
#---------------------------------------------------

docker build --file withBash.df --tag hx940929/alpine-bash:v1.0 .
docker tag hx940929/alpine-bash:v1.0 hx940929/alpine-bash:latest


#docker build --file withBashGit.df --tag hx940929/alpine-bash-git:v1.0 .
#docker tag hx940929/alpine-bash-git:v1.0 hx940929/alpine-bash-git:latest

#docker build --file withMake.df --tag hx940929/alpine-fastdfs-gcc:v1.0 .
#
#docker build --file withMake.df --tag hx940929/alpine-fastdfs:v1.0 .
#docker tag hx940929/alpine-fastdfs:v1.0 hx940929/alpine-fastdfs:latest