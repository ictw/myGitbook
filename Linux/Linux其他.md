>  **This is Linux其他 StudyNote.**

* ###  `curl cheat.sh`	简洁的命令说明

* ```bash
  # 将manpage转换成html或者是pdf格式,以便学习(中文翻译)
  
  # 安装man2html,转换为html,结合whereis和find命令找到manpage位置
  man2html [该命令的manpage文件路径] > [重定向到目标html文件]
  # 使用ps2pdf转换成pdf文件
  man -t [命令名称] | ps2pdf - [文件路径.pdf]
  ```
  
* ###  使用`systemd-analyze blame` 命令来查看Linux系统启动各部分所需要的时间


