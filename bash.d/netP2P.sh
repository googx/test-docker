#!/bin/bash
#--------------------------------------------------
# File Name: ${FILE_NAME}
# Author: hanxu
# AuthorSite: https://www.thesunboy.com/
# Created Time: 2018-07-18 上午11:15
#---------------------说明--------------------------
# 创建p2p点到点的连接
#---------------------------------------------------
#https://yeasy.gitbooks.io/docker_practice/content/advanced_network/ptp.html

docker run -it --rm --net=none --name=peer1 alpine /bin/sh
docker run -it --rm --net=none --name=peer2 alpine /bin/sh


docker container inspect --format '{{.State.Pid}}' peer1
docker container inspect --format '{{.State.Pid}}' peer2

sudo mkdir -p /var/run/netns

pid_peer1=$(docker container inspect --format '{{.State.Pid}}' peer1);
sudo ln -s /proc/${pid_peer1}/ns/net /var/run/netns/${pid_peer1}

pid_peer2=$(docker container inspect --format '{{.State.Pid}}' peer2);
sudo ln -s /proc/${pid_peer2}/ns/net /var/run/netns/${pid_peer2}

#创建一对 peer 接口，然后配置路由
sudo ip link add A type veth peer name B

sudo ip link set A netns ${pid_peer1}
sudo ip link set B netns ${pid_peer2}

sudo ip netns exec ${pid_peer1} ip addr add 10.1.1.1/32 dev A
sudo ip netns exec ${pid_peer1} ip link set A up
sudo ip netns exec ${pid_peer1} ip route add 10.1.1.2/32 dev A
sudo ip netns exec ${pid_peer2} ip addr add 10.1.1.2/32 dev B
sudo ip netns exec ${pid_peer2} ip link set B up
sudo ip netns exec ${pid_peer2} ip route add 10.1.1.1/32 dev B

# 可以成功。

#现在这 2 个容器就可以相互 ping 通，并成功建立连接。点到点链路不需要子网和子网掩码。
#
#此外，也可以不指定 --net=none 来创建点到点链路。这样容器还可以通过原先的网络来通信。
#
#利用类似的办法，可以创建一个只跟主机通信的容器。但是一般情况下，更推荐使用 --icc=false 来关闭容器之间的通信



