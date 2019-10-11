>**This is DNS服务器 StudyNote.**

# DNS资源纪录(Resource Record)

* 资源记录，简称rr，常用的七大记录类型是：`SOA`,`A`,`AAAA`,`PTR`,`MX`,`CNMAE`和`NS`

  * >（1）`SOA`：名叫起始授权机构记录，SOA记录说明了在众多NS记录里那一台才是主要的服务器
    >
    >（2）`A`：记录除了进行域名**IPv4**对应以外，还有一个高级用法，可以作为低成本的负载均衡的解决方案，同一站点可以创建多个A记录，对应多台物理服务器的IP地址，可以实现基本的流量均衡
    >
    >（3）`AAAA`：和`A`记录类似，但采用`IPv6`地址来记录
    >
    >（4）`PTR`：PTR记录也被称为指针记录，PTR记录是A记录的逆向记录，作用是把IP地址解析为域名
    >
    >（5）`MX`：全称是邮件交换记录，在使用邮件服务器的时候，MX记录是无可或缺的。优先级：0-99，数字越小优先级越高
    >
    >（6）`CNMAE`：别名记录
    >
    >（7）`NS`：NS记录和SOA记录是任何一个DNS区域都不可或缺的两条记录，NS记录也叫名称服务器记录，用于说明这个区域有哪些DNS服务器负责解析

* 个别常用rr的配置文件语法

  * >* SOA
    >
    >```
    >ZONE_NAME   IN  SOA     nameserver.example.com.  example.email.com. (
    >20191010            ; serial number 区域数据库的序列号，更新时使用
    >3600 <2H>        ; refresh   [1h] 表示slave dns服务器找master dns服务器更新区域数据文件的时间间隔
    >600 <10M>         ; retry   [10m] 表示slave dns服务器找master dns服务器更新区域数据文件时，如果联系不上master，则等待多久再重试联系，该值一般比refresh时间短，否则该值表示的重试就失去了意义
    >86400 <1W>        ; expire  [1d] 表示slave dns服务器上的区域数据文件多久过期
    >3600 <1D>  )       ; min TTL   [1h] 表示客户端找dns服务器解析时，否定答案的缓存时间长度
    >```
    >
    >* NS
    >
    >```shell
    >example.com. TTL IN NS ns.example.com.
    >```
    >
    >* PTR
    >
    >```shell
    >4.3.2.1.in-addr.arpa.  IN PTR example.com.
    >```
    >
    >* CNAME
    >
    >```shell
    >web.example.com. IN CNAME www.example.com.
    >```
    >
    >* MX
    >
    >```shell
    >example.com.	IN 	MX	10	mx1.example.com.
    >```
    >
    >---
    >
    >注意：
    >
    >（1）TTL可以从全局配置继承
    >
    >（2）@表示当前区域名称
    >
    >（3）相邻的两条记录其ZONE_NAME相同时，可以省略
    >
    >（4）对于正向解析区域来说，各个MX或者NS等类型记录的值应该为`FQDN`，并且此FQDN应该有一个A记录

#  BIND(Berkeley Internet Name Domain)

* BIND所含程序包

  * >bind-libs：被bind程序和bind-utils包所用到库文件
    >
    >bind-utils：bind客户端程序集，例如dig，host和nslookup等
    >
    >
    >
    >bind：提供dns服务程序
    >
    >bind-chroot：将bind运行于jail环境之下

* 安装bind

  * ```bash
    # CentOS7环境下安装
    yum install bind
    ```

  * 官网地址：https://www.isc.org/bind/



