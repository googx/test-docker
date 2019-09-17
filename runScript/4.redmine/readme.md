## redmine启动

1. 下载镜像
```
    docker pull redmine:latest
```

2. 我的启动脚本
> 数据库默认使用sqlite,如果有需要,可以在系统里在另外配置数据库吧
```
    docker run -d \
    --name redmine_s1 \
    --hostname redmine_s1 \
    -p 3000:3000 \
    -v /data/docker/redmine_s1:/usr/src/redmine/files \
    -v /etc/timezone:/etc/timezone \
    -v /etc/localtime:/etc/localtime:ro \
    redmine:latest
```



## 环境变量参数

|index|参数名|含义|取值范围|是否必须|
|:---:|:---:|:---:|:---:|:---:|
|1|REDMINE_DB_POSTGRES|使用postages数据库,如果两种都没设置,默认使用sqlite|-|-|
|2|REDMINE_DB_MYSQL   |mysql数据库|-|-|
|3|REDMINE_DB_PORT|-|-|-|
|4|REDMINE_DB_DATABASE|-|-|-|
|5|REDMINE_DB_ENCODING| 字符编码| mysql:UTF-8, PostgreSQL:utf8, SQLite:utf8|
|6|REDMINE_DB_USERNAME|-|-|-|
|7|REDMINE_DB_PASSWORD|-|-|-| 
|8|REDMINE_NO_DB_MIGRATE|This variable allows you to control if rake db:migrate is run on container start. Just set the variable to a non-empty string like 1 or true and the migrate script will not automatically run on container start. db:migrate will also not run if you start your image with something other than the default CMD, like bash. See the current docker-entrypoint.sh in your image for details.|-|-|-|
|9|REDMINE_PLUGINS_MIGRATE|This variable allows you to control if `rake redmine:plugins:migrate` is run on container start. Just set the variable to a non-empty string like `1` or `true` and the migrate script will be automatically run on every container start. It will be run after `db:migrate`.`redmine:plugins:migrate` will not run if you start your image with something other than the default CMD, like bash. See the current docker-entrypoint.sh in your image for details.|-|-|-|
|10|REDMINE_SECRET_KEY_BASE|This variable is used to create an initial `config/secrets.yml` and set the `secret_key_base ` value, which is "used by Rails to encode cookies storing session data thus preventing their tampering. Generating a new secret token invalidates all existing sessions after restart" (session store). If you do not set this variable or provide a `secrets.yml` one will be generated using rake `generate_secret_token` .|-|-|-|

#### Docker Secrets 
> 介于上面使用环境变量会传输一些敏感信息, 可以使用在环境变量后面配置_file,来使用文件传输
> As an alternative to passing sensitive information via environment variables, _FILE may be appended to the previously listed environment variables, causing the initialization script to load the values for those variables from files present in the container. In particular, this can be used to load passwords from Docker secrets stored in /run/secrets/<secret_name> files. For example:
```
     docker run -d --name some-redmine -e REDMINE_DB_MYSQL_FILE=/run/secrets/mysql-host -e REDMINE_DB_PASSWORD_FILE=/run/secrets/mysql-root redmine:tag
```

## 其他版本的docker镜像

1. redmine:<version>-alpine (官方推荐,体积要小的多,不过可能要注意的问题就是某些软件因为libc问题可能会不兼容)
2. redmine:<version>


## 镜像声明的挂载点
```
    -v /data/docker/redmine_s1:/usr/src/redmine/files
```

## 默认用户权限

   Currently, the default user and password from upstream is `admin/admin` (logging into the application).
