> **This is Mysql StudyNote.**

# MySQL安装（CentOS）

* ```bash
  # 获取官网RPM文件
  wget http://repo.mysql.com/[mysql80-community-release-el7-3.noarch.rpm]
  # 校验rpm文件
  rpm -ivh mysql-community-release-el7-5.noarch.rpm
  # 更新下载
  yum update
  # 安装MySQL服务
  yum install mysql-server
  # 权限设置
  chown mysql:mysql -R /var/lib/mysql
  # 初始化Mysql
  mysqld --initialize
  # 启动mysql服务
  systemctl start mysqld
  #　查看mysql版本
  mysqladmin --version
  
  # 创建root默认密码
  mysqladmin -u root password "your_new_passwd";
  ```

* `MariaDB` 数据库管理系统是 MySQL 的一个分支

# 添加用户

* ####  mysql添加用户方法

* ####  建立数据库gamesp

* ####  create database gamesp;

* ####  添加用户

* ####  grant all on 数据库名.\* to 用户名@localhost identified by '密码';

* ####  grant all on gamesp.\* to newuser@localhost identified by 'password';

* ####  添加一个远程用户，名为username密码为password

* ####  GRANT ALL PRIVILEGES ON \*.\* TO username@"%" IDENTIFIED BY 'password'

####  说明：

* ####  （1）grant all 赋予所有的权限

* ####  （2）gamesp.\* 数据库 gamesp 中所有的表

* ####  （3）newuser 用户名

* ####  （4）@localhost 在本地电脑上的 mysql server 服务器

* ####  （5）identfified by 'password' 设置密码

  ##  用户登录

  ```bash
  mysql -u[用户名称] -p[passwd]
  ```

  



