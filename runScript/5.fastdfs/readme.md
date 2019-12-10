

## Run as a tracker

```shell
docker run -d \
    --name trakcer \
    --hostname trakcer_s1 \
    -v /data/docker/fastdfs/tracker:/fastdfs/tracker/data \
    --net=host \
    season/fastdfs tracker
```


## Run as a storage 

```shell
    docker run -d \
    --name storage_group1 \
    --hostname storage_group1 \
    -v /data/docker/fastdfs/storage_data:/fastdfs/storage/data \
    -v /data/docker/fastdfs/storage_group1:/fastdfs/store_path \
    --net=host \
    -e TRACKER_SERVER=宿主机ip:22122 \
    season/fastdfs storage
```


docker stop trakcer; docker stop storage_group1
docker rm trakcer; docker rm storage_group1