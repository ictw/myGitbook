> **This is Linux配置文件 StudyNote.**  

*  客户端网络配置文件：`/etc/sysconfig/network-scripts/[ ifcfg-eth ]`,配置完后使用/etc/init.d/network restart 来使配置生效

*  客户端租约所记录的DHCP信息文件：`/var/lib/dhclient/dhclient*`

*  DNS配置文件：`/etc/resolv.conf`

*  自启挂载卷配置文件：`/etc/fstab`

   *  > 六个字段
      >
      > 1. 设备文件(device file)/UUID/Label
      > 2. 设备挂载点(Mount_point)，注意交换分区应该标注swap
      > 3. 文件系统
      > 4. 挂载选项，defaults,acl,noexec等等
      > 5. 转储频率 0代表从不备份，1代表每天备份，2代表隔一天备份一次
      > 6. 自检次序 0代表不自检，1代表首先自检，一般rootfs专用，其他级别依次递减
   

* SElinux开关配置文件：`/etc/selinux/config`

  

  

  





