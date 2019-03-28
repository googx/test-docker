## mysql相关命令记录

#### docker 启动相关

> 1.启动一个新的mysql5.7容器
```
    docker run -d -p 3306:3306 \
    --name mysql57_s1 \
    --hostname mysql57_s1 \
    -v /etc/timezone:/etc/timezone \
    -v /etc/localtime:/etc/localtime:ro \
    -v /data/docker/mysql57_s1/:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=hxadmin1 \
    mysql/mysql-server:5.7
```
 
 ---

> 2.关闭 全部运行中的mysql容器
```
    docker container ls \ 
    --filter name=mysql \
    --filter status=running \ 
    --quiet |xargs docker stop
```
 
 ---

> 3.删除 全部mysql容器
```
    docker container ls \
    --filter name=mysql \
    --filter status=exited \
    --quiet |xargs docker rm 
```
