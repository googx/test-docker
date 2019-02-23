#!/usr/bin/env bash
#--------------------------------------------------
# File Name: build.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-2-23-下午2:52
#---------------------说明--------------------------
# 批量构建测试的docker镜像.
#---------------------------------------------------

function buildDocker() {
    nodeName=$1

    docker build --file dockerfile.df -t hx940929/test-py-docker:latest .
    
    exit $?
}

function runNewContainer() {
    docker run -d -name testDocker -p 5001:5001 hx940929/test-py-docker:latest
}

function stopLastContainer() {
    labelName=$1
    if [ -n ${labelName} ]; then
        labelName="test-docker-py"
    fi
    docker container ls --all --quiet --filter  label=name=${labelName} |xargs docker stop
}

function rmLastContainer() {
    labelName=$1
    if [ -n ${labelName} ]; then
        labelName="test-docker-py"
    fi
    docker container ls --all --quiet --filter  label=name=${labelName} |xargs docker rm
}

