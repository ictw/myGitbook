>  **This is Linux基础 StudyNote.**

*   `nohup`将命令放于后台执行，常用于脚本类，例如：` nohup sh test.sh &`，执行命令的同时，在家目录会生成一个nohup.out的文件来接收返回结果，所以可以使用`tail -f nohup.out`来实时查看输出内容

*   `screen`命令：

    *   >（1）打开screen：`screen`
        >
        >（2）拆除分解screen：使用快捷键`Ctrl+a，d`
        >
        >（3）列出当前正在运行的screen：`screen -ls`
        >
        >（4）连接至screen：`screen -r SCREEN_ID`
        >
        >（5）关闭当前screen：`exit`

* 解压缩

  * > 1、*.tar 用 tar –xvf 解压
    >
    > 2、*.gz 用 gzip -d或者gunzip 解压
    >
    > 3、*.tar.gz和*.tgz 用 tar –xzf 解压
    >
    > 4、*.bz2 用 bzip2 -d或者用bunzip2 解压
    >
    > 5、*.tar.bz2用tar –xjf 解压
    >
    > 6、*.Z 用 uncompress 解压
    >
    > 7、*.tar.Z 用tar –xZf 解压

*   scp命令：加密传输-本地主机-远程主机(具体参见<https://wangchujiang.com/linux-command/c/scp.html>或者man pages)

  * ```bash
    # 从远处复制文件到本地目录
    scp root@centos:/root/anaconda-ks.cfg .
    
    # 上传本地文件到远程机器指定目录
    scp /home/suofeiya/Shell_Study/control_progress_status/prepare.txt root@centps:/root
    # 指定端口 2222
    scp -rp -P 2222 /home/suofeiya/Shell_Study/control_progress_status/prepare.txt root@centps:/root
    
    # 上传本地目录到远程机器指定目录
    scp -r /home/suofeiya/Shell_Study/control_progress_status/test root@centos:/root/test
    ```
  
*   find实用命令

    *   ```bash
        find  ./ -perm /002  -exec mv {} {}.bak \;
        #  查找没有属组属主的文件，并一个个询问是否要更改权限
        find ./ -nouser -a -nogroup -ok chmod root:root {} \;
        ```

*   rename重命名

    *   ```bash
        rename 
        ```

*   curl命令

    *   ```bash
        curl -o [local_dir] remote_url  # 指定远端文件目录和本地文件目录
        curl "https://www.{baidu,douban}.com" -o "site_#1.txt"  #  后面的#1代表前面的参数
        
        #  FTP文件上传
        curl -T local_files ftp://user:passwd@remote_ip:port/data
        #  或者使用curl -T local_files user:passwd ftp://remote_ip:port/data
        ```

*   `anacron`定时任务

*   打开关闭交换空间，`swapon` `swapoff`

*   挂载卸载设备

    *   ```bash
        #  查看当前已挂载的设备
        mount
        cat /etc/mtab
        cat /proc/mounts
        
        #  挂载设备
        mount -o loop /PATH/TO/DIR MOUNT_POINT # 挂在本地回环设备，-o指定挂载选项，其中有sync、nosync、atime、noatime、diratime、nodiratime、remont(常用，无需卸载)
        mount -r /dev/cdrom MOUNT_POINT # 挂载只读光盘文件
        
        #  将一个目录绑定至另一个目录
        mount -bind SOURCE_DIR DISTIN_DIR
        
        # 卸载设备
        #  查看设备被那些进程所占用
        lsof MOUNT_POINT
        fuser -v MOUNT_POINT
        fuser -km MOUNT_POINT  #  强行终止正在访问某挂载点的进程 
        ```

---

#  更新yum源(CentOS 6/7)

* ```bash
  # 下载repo源，建议选择国内源(163，aliyun)
  wget .../*.repo
  # 备份原来的基础源
  mv /etc/yum.repo.d/*.Base.repo *.bak
  # 替换源
  mv ...
  # 执行yum源的更新
  yum clean all	# 清除yum缓存
  yum makeclean	# 重建yum缓存
  yum update
  ```

* ```bash
  # 增加epel源
  wget https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  rpm -ivh ... # 安装rpm
  # 安装yum-priorities源优先级工具
  yum install yum-priorities
  ```

##  RHEL系后端包管理工具rpm的使用

* >安装：
  >
  >​	rpm -ivh(-i 安装包 -v verbose详细信息 -h hash值来表示进度条每一个#代表2%)PackageName
  >
  >​	--nodeps 忽略依赖性检查	--replacepkgs 重新安装
  >
  >卸载：
  >
  >​	rpm -e(erase) PackageName
  >
  >​	--nodeps
  >
  >升级：
  >
  >​	rpm -Uvh、-Fvh 前者如果之前未安装过则会直接安装该包，后者则不会
  >
  >查询：
  >
  >​	rpm -qa 、-qf、-qi、-qc、-q --scripts(安装之前preinstall安装之后postinstall卸载之前preuninstall卸载之后postuninstall的脚本信息)、-q provides(该包安装后会提供那些服务或者工具)、-q --requires(查询包安装依赖)
  >
  >校验：
  >
  >​	rpm -V
  >
  >	*	导入GPG秘钥文件：rpm --import GPG秘钥文件 
  >	*	rpm -K 用于手动检查包的来源安全性和文件完成性信息，可选选项--nodigest(不检查完整性)--nosignature(不检查来源安全性签名)
  >
  >数据库重建：
  >
  >​	rpm --initdb、--rebuilddb

* 

---

  

*   `ntsysv`命令：图形化显示所要启动的服务

*   修改`/etc/init/start-ttys.conf`关闭不必要的tty，修改这个位置，即可关闭不必要的tty

  `env ACTIVE_CONSOLES=/dev/tty[1-6]  `

*   `echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf`可以加强对抗syn flood的能力，使用`sysctl -p`生效

* 修改history的记录数量，使用source /etc/profile即可生效

*   安装ntp ，为用户加入`crontab (-e)计划/usr/sbin/ntpdate ntp.api.bz`，可以使用`dig ntp.api.bz `来查看(dig在centos中所属bind-tools包)

#  完全禁用ipv6

* ```bash
  # 查看ipv6是否被启用，r
  lsmod(查看系统内核)| gerp ipv6
  echo "install ipv6 /bin/true" > /etc/modprobe.d/disable-ipv6.conf	#用来禁用ipv6服务
  echo "IPV6INIT=no" >> /etc/sysconfig/network-script/ifcfg-eth0
  ```

---









