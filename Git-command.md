> **This is Git命令 StudyNote.**

全局配置文件：~/.gitconfig
### git pull 撤销误操作

本来想把github上的newpbft合并到本地的newpbft分支上，由于没有查看当前分支，直接运用git pull origin newpbft，结果将newpbft合并到了master分支中。
解决方法：  
1、运行git reflog命令查看你的历史变更记录  
2、然后用git reset --hard HEAD@{n}，（n是你要回退到的引用位置）回退。