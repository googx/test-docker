#!/usr/bin/env bash
#--------------------------------------------------
# File Name: build.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-3-9-下午10:17
#---------------------说明--------------------------
# 构建idea激活程序脚本
#---------------------------------------------------
#上下文只有idea二进制程序.应该从官网下载.
docker build --file ideaServer.df --tag hx940929/ideaserver:v1.0 ../build/