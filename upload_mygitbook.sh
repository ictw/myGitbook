#!/bin/bash
# Program:
#   上传mygitbook到github
# author:
#   suofeiya
# Time:
#   2019年05月20日

cd /home/suofeiya/NEW_SPACE/myGitbook
echo -e "======当前位置:`pwd`======="

current_branch=`git status | grep 位于分支`

echo -e "${current_branch}"

if [[ "${current_branch}" =~ "gh-pages" ]]
then
    echo -e "\n当前位于gh-pages分支,为您切换至master分支~"
    $(git add . ; git commit -m "update" ; git checkout master > /dev/null)
fi

$(git status)

read -p "以上文件已发生改变,请输入提交信息:" pushMes

$(git add . ;git commit -m "$pushMes")

echo -e "正在进行推送到master分支..."

$(git push -u origin master) > /dev/null

# 复制master分支的_book目录下的所有文件到../TMP文件夹

$(rm -rf ../TMP/* ; cp -r _book/* ../TMP/ )

# 切换到gh-pages分支
echo -e "\n正在切换到gh-pages分支"

$(git checkout gh-pages) > /dev/null

current_branch2=`git status | grep 位于分支`
echo -e "${current_branch2}"

$(rm -rf * ; cp -r ../TMP/* .)

read -p "请输入gh-pages提交信息:" pushMes_gh

$(git add . ; git commit -m "$pushMes_gh")

echo -e "\n========END========"
