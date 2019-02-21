#!/usr/bin/env bash
#--------------------------------------------------
# File Name: 1.etcd.sh
# Author: hanxu
# AuthorSite: http://www.thesunboy.com/
# GitSource: https://github.com/hx940929/linuxShell
# Created Time: 2019-2-19-下午5:46
#---------------------说明--------------------------
# etcd服务镜像的运行配置.
#---------------------------------------------------

NODE1=192.168.1.21
objname="etcd_s1"
mountData="/data/docker/${objname}"

#ETCD参数说明
#
#这里只列举一些重要的参数，以及其用途。
#
#    —data-dir 指定节点的数据存储目录，这些数据包括节点ID，集群ID，集群初始化配置，Snapshot文件，若未指定—wal-dir，还会存储WAL文件；
#    —wal-dir 指定节点的was文件的存储目录，若指定了该参数，wal文件会和其他数据文件分开存储。
#    —name 节点名称
#    —initial-advertise-peer-urls 告知集群其他节点url.
#    — listen-peer-urls 监听URL，用于与其他节点通讯
#    — advertise-client-urls 告知客户端url, 也就是服务的url
#    — initial-cluster-token 集群的ID
#    — initial-cluster 集群中所有节点

function run(){
docker run -d --name=${objname} --hostname=${objname} \
    -p 2379:2379 \
    -p 2380:2380 \
    -p 4001:4001 \
    -p 7001:7001 \
    --volume=${mountData}:/data \
    elcolio/etcd:latest
}

function test() {
    test1=""
    if [ -z ${test1+x} ]; then
        echo "yes"
    else
        echo "no"
    fi
}

case $1 in
"run")
    run;
   ;;
"t1")
    echo $(test ss);
    ;;
"*")
    run;
    ;;
esac
#    --volume=${mountData}:/etcd-data \
#    quay.io/coreos/etcd:latest \
#    /usr/local/bin/etcd \
#    --data-dir=/etcd-data --name node1 \
#    --initial-advertise-peer-urls http://${NODE1}:2380 --listen-peer-urls http://0.0.0.0:2380 \
#    --advertise-client-urls http://${NODE1}:2379 --listen-client-urls http://0.0.0.0:2379 \
#    --initial-cluster node1=http://${NODE1}:2380