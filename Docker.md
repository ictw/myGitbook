> **This is Docker StudyNote**
# Docker 安装与配置（[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)）

---

docker RPM源：https://download.docker.com/linux/centos/7/x86_64/stable/Packages/

```bash
# 获取最新的docker
wget -qO- https://getdockercom/ | sh
# 为普通用户添加docker使用权限,重新登录后生效
sudo usermod -aG docker [用户名称]
```

```bash
# 为docker镜像加速
配置文件地址：/etc/docker/daemonjson
例如：
{
  "registry-mirrors": ["http://hub-mirrorc163com"]
}
```

# Docker基础命令参数

---

-  `docker search` 搜索镜像

-  `docker login` 登录docker

-  `docker pull` 下载镜像

-  `docker images `查看已经存在的镜像

-  `docker ps` 查看容器状态，`docker ps -l`列出当前运行的最新镜像信息，`docker ps -a`列出所有镜像信息，包含已关闭的

-  `docker inspect [短ID/镜像/容器名称]`获取容器/镜像的元数据

 inspect参数列表：

   -  > **-f :**指定返回值的模板文件
     >
     >  **-s :**显示总的文件大小
     >
     >  **--type :**为指定类型返回JSON

 docker -event \(类似命令还有docker -logs\)参数列表：

   - > **-f ：**根据条件过滤事件
     >
     > **--since ：**从指定的时间戳后显示所有事件;
     >
     > **--until ：**流水时间显示到指定的时间为止
     >
     > --tail : 仅列出最近几条的日志信息  

例子：`docker -event -f "iamges"="hello-world" --since  "对应时间戳"`也可以直接使用时间

-  ` docker run -d centos /bin/bash -c " command"`后台运行docker容器并运行一条命令
-  `docker run --name [name]`可以指定docker名，类似的命令还有docker create [name]创建一个容器但不启动他
-  `docker stop [容器名称/短ID]`来停止正在运行的容器，类似命令docker kill，docker kill -s 向容器放出警告
-  `docker start [容器名称]`启动容器，类似命令docker restart
-  `docker pause [容器名称]`暂停容器，类似命令还有unpause
-  `docker rename [原容器名称] [新容器名称]`
-  `docker rm [容器名称]` 删除一个容器，`docker rmi [镜像名称]`删除镜像
-  `docker rm -f强制删除 -v $\(docker ps -aq -f status=exited\)`删除所有已经退出的docker
-  `docker attach [容器id]`进入容器内部
-  `docker exec -it [短ID] bash`进入相关容器的bash，it参数代表以交互模式打开bash，也可以`docker exec [容器ID或者长短ID] [命令 如：ls /home]`

docker镜像的导入和导出

>`docker export `
>
>`docker save  ubuntu > ubuntu.tar`   `docker  load -i ubuntu.tar`
>
>* save 、 load 和 export 、 import区别：
>
>前者保存整个容器，可以单独使用，后者只保存容器层数据

## WEB

-  设置端口映射，docker run -d -p 80 httpd运行docker的web服务，修改端口使用docker run -d -p 80:80 http
-  docker -P代表以80端口启动docker
-  docker run -p 127001:80:45163将容器的45162端口映射到本机的80端口
-  docker port [容器名称]查看端口映射情况

##  docker 搭建LNMP环境（例：WordPress）

```bash
#  指定mysql容器，并天剑环境变量
docker run -itd --name lnmp_mysql -p 3308:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
#  连接mysql并登陆，创建一个wordpress的数据库，名称为wordpress
docker exec lnmp_mysql -sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "creata database wordpress;"'
# 检查数据库是否成功创建
docker exec lnmp_mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "show databases;"'
# 拉取nginx-php相关镜像
docker pull richarvey/nginx-php-fpm
```

##  docker修改端口映射

   -  > 1) 停止容器
	> 2) 停止docker服务(systemctl stop docker)
	> 3) 修改这个容器的hostconfig.json文件中的端口（原帖有人提到，如果config.v2.json里面也记录了端口，也要修改）
	>
	> `cd /var/lib/docker/3b6ef264a040*` #这里是CONTAINER ID
	> `vi hostconfig.json`
	> 如果之前没有端口映射, 应该有这样的一段:
	> `"PortBindings":{}`
	> 增加一个映射, 这样写:
	> `"PortBindings":{"3306/tcp":[{"HostIp":"","HostPort":"3307"}]}`
	> 前一个数字是容器端口, 后一个是宿主机端口. 
	> 而修改现有端口映射更简单, 把端口号改掉就行.

## 容器rootfs命令

docker commit 参数列表：

   -  > - **-a :**提交的镜像作者
      > - **-c :**使用Dockerfile指令来创建镜像
      > - **-m :**提交时的说明文字
      > - **-p :**在commit时，将容器暂停

例：将容器a404c6c174a2 保存为新的镜像,并添加提交人信息和说明信息：`docker commit -a "" -m "" [原镜像名称]  [新镜像名称:verison]`

-  docker cp

```
docker cp /www/suofeiya <容器ID>:/容器中的目标目录
docker cp <容器ID>:/容器中的目标目录 <本机目录>
```

-  docker diff ubtuntu\_test 查看docker容器中所提交的更改

-  docker tag [元镜像名:版本] [新镜像名:版本] 标记镜像并为其添加标注,tag



-  **docker history :**查看指定镜像的创建历史

##  Docker容器的数据卷（data volume），数据卷容器

```bash
# 将宿主机的/container_data共享给容器的/data   ××容器数据卷××
sudo docker run -v ~/container_data:/data[添加只读权限] -it ubuntu /bin/bash
# ××数据卷容器，也就是包含数据卷的容器××
docker run -itd -v /data --name dvt0 ubuntu
docker run -itd --name dvt1 --volume-from dvt0 ubuntu
```

#  DOCKERFILE文件以及构建

---
-  DOCKERFILE文件选项，例子：[http://www.ityouknow.com/docker/2018/03/15/docker-dockerfile-command-introduction.html#dockerfile-%E4%BD%BF%E7%94%A8%E7%BB%8F%E9%AA%8C](http://www.ityouknow.com/docker/2018/03/15/docker-dockerfile-command-introduction.html#dockerfile-使用经验)，https://www.jianshu.com/p/cbce69c7a52f

   -  > • FROM 
      >
      > • MAINTAINER  
      >
      > • RUN 
      >
      > • CMD
      >
      > • EXPOSE
      >
      > • ENV
      >
      > • ADD
      >
      > • COPY
      >
      > • ENTRYPOINT
      >
      > • VOLUME
      >
      > • USER
      >
      > • WORKDIR
      >
      > • ONBUILD

-  docker build用于使用 Dockerfile 创建镜像，下面是参数列表

   -  > - **--build-arg=\[\] :**设置镜像创建时的变量
      >
      > - **--cpu-shares :**设置 cpu 使用权重
      >
      > - **--cpu-period :**限制 CPU CFS周期
      >
      > - **--cpu-quota :**限制 CPU CFS配额
      >
      > - **--cpuset-cpus :**指定使用的CPU id
      >
      > - **--cpuset-mems :**指定使用的内存 id
      >
      > - **--disable-content-trust :**忽略校验，默认开启
      >
      > - **-f :**指定要使用的Dockerfile路径
      >
      > - 
      >   docker build -f /path/to/a/Dockerfile .
      >   
      > - **--force-rm :**设置镜像过程中删除中间容器
      > 
      > - **--isolation :**使用容器隔离技术
      > 
      > - **--label=\[\] :**设置镜像使用的元数据
      > 
      > - **-m :**设置内存最大值
      > 
      > - **--memory-swap :**设置Swap的最大值为内存+swap，"-1"表示不限swap
      > 
      > - **--no-cache :**创建镜像的过程不使用缓存
      > 
      > - **--pull :**尝试去更新镜像的新版本
      > 
      > - **--quiet, -q :**安静模式，成功后只输出镜像 ID
      > 
      > - **--rm :**设置镜像成功后删除中间容器
      > 
      > - **--shm-size :**设置/dev/shm的大小，默认值是64M
      > 
      > - **--ulimit :**Ulimit配置
      > 
      > - **--tag, -t:**镜像的名字及标签，通常 name:tag 或者 name 格式可以在一次构建中为一个镜像设置多个标签
      > 
      > - **--network:**默认 default在构建期间设置RUN指令的网络模式
      > 

* Dockerfile 示例

  * Docker本地私有仓库
  
    * ```shell
    # 建立相关数据卷：
      /root/registry
      ```
      
    * 
    
  * 构建tomcat服务
  
    * ```shell
      FROM centos
      MAINTAINER suofeiya " suofeiyaxx@gmail.com"
      ADD jdk-11.0.4_linux-x64_bin.tar.gz /usr/local
      ENV JAVA_HOME  /usr/local/jdk-11.0.4
      ADD apache-tomcat-9.0.24.tar.gz /usr/local
      WORKDIR /usr/local/apache-tomcat-9.0.24/bin
      EXPOSE 8080
    CMD ["catalina.sh", "run"]
      # 构建容器
      docker run -d -p 8080:8080 --name tomcat tomcat:test
      ###########################################
      tomcat的默认server status等服务允许访问的网段是127.。。
      解决方法：
      	在conf/tomcat-users.xml下添加：
      	<role rolename="manager-gui"/>
      	<role rolename="admin-gui"/>
      	<user username="tomcat" password="s3cret" roles="manager-gui,admin-gui"/>
      	修改./host-manager/META-INF/context.xml和./manager/META-INF/context.xml文件：
      	allow="192.168.1.*" />
      重启tomcat服务即可
      ```
  
  * PHP环境搭建
  
    * ```shell
      FROM centos:6
      MAINTAINTER suofeiya "suofeiyaxx@gmial.com"
      RUN yum install -y httpd php php-gd php-mysql mysql mysql-server
      ENV MYSQL_ROOT_PASSWORD 123456
      RUN echo "<?php phpinfo()?>"  > /var/www/html/index.php
      ADD start.sh /start.sh
      RUN chmod +x start.sh
      COPY wordpress/*  /var/www/html
      VOLUME ["/var/lib/mysql"]
      CMD /start.sh
      EXPOSE 80 3306
      # start.sh内容
      service httpd start
      service mysqld start
      mysqladmin -uroot password $MYSQL_ROOT_PASSWORD
      tail -f
      ```
  
    * 

#  Docker容器可视化监控中心搭建cadviser+influxdb+grafana

---
*  分别从hub.docker拉取
	* > 1. cadvisor：负责收集容器的随时间变化的数据
	  > 2. influxdb：负责存储时序数据
	  > 3. grafana：负责分析和展示时序数据

* 部署**Influxdb**服务

  * ```bash
    # 创建镜像并使其后台运行
    docker run -d --name influxdb -p 8086:8086 \
          -v influxdb:/var/lib/influxdb \
          influxdb
    
    # 进入influxdb容器内部，并执行influx命令：
    docker exec -it influxdb influx
    
    # 进入influxdb的shell后创建数据库test和root用户用于本次试验测试
    CREATE DATABASE "test"
    CREATE USER "root" WITH PASSWORD '123456' WITH ALL PRIVILEGES
    SHOW DATABASES  # 验证数据库是否成功创建
    ```

*  部署**cAdvisor**服务

   *  ```bash
      # 创建镜像并使其后台运行
       docker run -d  \
        --volume=/:/rootfs \
        --volume=/var/run:/var/run \
        --volume=/sys:/sys \
        --volume=/var/lib/docker/:/var/lib/docker \
        --link=influxdb:influxdb   --name cadvisor   google/cadvisor:latest  \
        -storage_driver=influxdb \
        -storage_driver_host=influxdb:8086 \
        -storage_driver_db=test  \
        -storage_driver_user=root  \
       -storage_driver_password=123456  
       
      # 注意：
      #  设置为true之后，容器内的root才拥有真正的root权限，可以看到host上的设备，并且可以执行mount；否者容器内的root只是外部的一个普通用户权限。由于cadvisor需要通过socket访问docker守护进程，在CentOs和RHEL系统中需要这个这个选项。 --volume=/cgroup:/cgroup:ro对于CentOS和RHEL系统的某些版本（比如CentOS6），cgroup的层级挂在/cgroup目录，所以运行cadvisor时需要额外添加–volume=/cgroup:/cgroup:ro选项。
      ```

*  部署**Grafana**服务

   *  ```bash
      # 创建镜像并使其后台运行
      docker run -d -p 6000:3000 -v ~/grafana:/var/lib/grafana --link=influxdb:influxdb --name grafana grafana/grafana
      ```


