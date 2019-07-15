#!/usr/bin/env bash
#--------------------------------------------------
# File Name: build.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-7-15-下午3:54
#---------------------说明--------------------------
# 启动一个构建容器, 在run时-挂载golang的依赖目录到容器中,容器中设置好相关环境变量.
#---------------------------------------------------

docker build -f builderdf.df --tag dfbuild:latest .