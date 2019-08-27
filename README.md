# 使用DockerCompose构建部署Yapi

## OverView

YApi 是一个可本地部署的、打通前后端及QA的、可视化的接口管理平台 https://hellosean1025.github.io/yapi

## 配置阿里云MongoDB用户及数据库

```
use <db_name>;
db.createUser({user:"<db_user>",pwd:"<db_password>", roles: [{ role: "readWrite", db: "<db_name>" }] });
```

## 构建镜像

利用dockerfile构建镜像

- 下载 Yapi

    ```
    ./download.sh 1.8.3
    ```
- 连接阿里云MongoDB的config.json
    ```
	{
    "port": "3000",
	"adminAccount": "***@***.***",
    "db": {
	  "connectString": "mongodb://<db_user>:<db_password>@<db_connect1>:<db_port>,<db_connect2>:<db_port>/<db_user>?replicaSet=<*****>&authSource=<db_name>"
    }
 }
	```
  
- 构建镜像 \# 构建镜像前请根据Dockerfile文件修改

    ```
    docker-compose build
    ```

- Push 镜像

    ```
    docker tag skycitygalaxy/yapi:latest <私有仓库地址>/<仓库名称>:<版本号>
    docker push <私有仓库地址>/<仓库名称>:<版本号>
    ```


- 启动服务

    ```
    docker run -d -p 3001:3000 --name yapi <私有仓库地址>/<仓库名称>:<版本号>
    ```

- 修改配置

    进入容器，修改配置为自己的配置。

    ```
    docker exec -ti yapi bash
    cd /api/
    vim config.json
    ```

- 重启服务

    ```
    docker restart yapi
    ```

- 访问 http://127.0.0.1:3001/


