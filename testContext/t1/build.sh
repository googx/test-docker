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

function init(){
    echo "假设已经有一个可以访问localhost:/5001/down接口的镜像已经启动."
    imageName=$1
    docker build --file dockerfile.df --label version="init" -t "hx940929/test-py-docker:vinit" .
#    runNewContainer "testDocker"
    docker run -d --name testDocker -p 5001:5001 hx940929/test-py-docker:vinit
    return 0;
}

function buildDocker() {
    imageName=$1
    imageVersion=$2
    versionCode="${imageName}:${imageVersion}"
    versionLatest="${imageName}:latest"
    docker build --file dockerfile.df --label version=${imageVersion} -t ${versionCode} .
    resu=$?
    docker tag ${versionCode} ${versionLatest}

    exit $?
}

function runNewContainer() {
    containerName=$1
    docker run -d --name ${containerName} -p 5001:5001 hx940929/test-py-docker:latest
}

function stopLastContainer() {
    containerName=$1
#    labelName=""
#    if [ -n ${labelName} ]; then
#        labelName="test-docker-py"
#    fi
#    --filter label=name=${labelName} \
#    --filter status=running \
#    resumsg=$(docker container ls --all \
    resumsg=$(docker container ls --all --quiet \
    --filter name=${containerName} \
    | xargs docker stop
    )
    echo $resumsg
}

function rmLastContainer() {
    containerName=$1

#    labelName=$1
#    if [ -n ${labelName} ]; then
#        labelName="test-docker-py"
#    fi
#    --filter label=name=${labelName} \
    resumsg=$(docker container ls --all --quiet \
    --filter name=${containerName} \
    --filter status=exited \
    |xargs docker rm)
    echo ${resumsg}
}

function saveImage(){
    imageName="hx940929/test-py-docker"
    imageVersion=$1
    imagetag="${imageName}:${imageVersion}"
    docker save ${imagetag} > "/data/docker/tarDocker/testDocker:${imageVersion}.tar"
}
function main(){
#    1.先构建并启动一个初始的镜像,没有ADD http://localhost:5001/down /data/file.txt 语句的. TODO 如何使用多阶段构建实现?
#   loop:start
#    2.构建新版本的镜像, 通过访问已运行的容器,获取最新的日志记录,来搭建本次版本的镜像(模拟平常开发迭代的不同版本)
#    3.结束stop上一个容器,并rm删除上一个容器.
#    4.开启新建立的容器
#    loop:end.
    imageName="hx940929/test-py-docker"
#    init ${imageName}
    for (( i = 1; i <10; ++i )); do
        imageVersion="v1.${i}"
        resu=$(buildDocker ${imageName} ${imageVersion})
        resucode=$?
        echo "构建消息:${resu},Exit(${resucode})"
        saveImage ${imageVersion}
# TODO 需要根据上一个状态来决定执行
        stopLastContainer 'testDocker'
        rmLastContainer 'testDocker'
        runNewContainer 'testDocker'
        sleep 3
#        echo "新版本镜像名称:${imgtag}"
    done

#    buildDocker

}
main
#echo "stop: $(stopLastContainer 'testDocker')"
#echo "rm: $(rmLastContainer 'testDocker')"
