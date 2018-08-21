#!/bin/bash
#--------------------------------------------------
# File Name: ${FILE_NAME}
# Author: hanxu
# AuthorSite: https://www.thesunboy.com/
# Created Time: 2018-07-17 下午4:53
#---------------------说明--------------------------
#  
#---------------------------------------------------

docker network create \
--subnet 10.193.3.0/24 \
--gateway 10.193.3.1 \
--driver bridge --opt \
com.docker.network.bridge.name=mydocker0 mynetwork0