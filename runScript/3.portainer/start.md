# portainer-docker仪表盘
>Portainer是Docker的图形化管理工具，提供状态显示面板、应用模板快速部署、容器镜像网络数据卷的基本操作（包括上传下载镜像，创建容器等操作）、事件日志显示、容器控制台操作、Swarm集群和服务等集中管理和操作、登录用户管理和控制等功能。功能十分全面，基本能满足中小型单位对容器管理的全部需求。
 

> 启动
```
    docker run -d -p 9000:9000 \
        -v /etc/timezone:/etc/timezone \
        -v /etc/localtime:/etc/localtime:ro \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /data/docker/portainer_s1:/data \
        --name prtainer_s1 \
        --hostname prtainer_s1 \
        portainer/portainer
```

> 2.关闭 全部运行中的portainer容器
```
    docker container ls \ 
    --filter name=portainer \
    --filter status=running \ 
    --quiet |xargs docker stop
```
 
 ---

>3.删除 全部portainer容器
```
    docker container ls \
    --filter name=portainer \
    --filter status=exited \
    --quiet |xargs docker rm 
```