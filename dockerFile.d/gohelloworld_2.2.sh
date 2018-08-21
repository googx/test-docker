#!/bin/bash
#分阶段部署- 普通shell实现，分阶段部署，多个dockFile文件 file 1/3

echo "building go/helloworld:build";

docker build -t gohelloworld:v1.0 -f ./gohelloworld_2.df --build-arg contextDir=/home/hanxu/document/project/code/personal/docker .

docker create --name extract gohelloworld:v1.0

docker cp extract:/go/src/github.com/go/helloworld/app ./app

docker rm -f extract

echo "building gohelloworld:copy";

docker build --no-cache -t gohelloworld:v1.0.1 -f ./gohelloworld_2.1.df .
rm ./app