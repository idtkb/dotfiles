#!/bin/sh
cd $(dirname $0)
 
DOT_FILES=( .screenrc .zshrc .zshrc.local)

for file in ${DOT_FILES[@]}
do
  ln -Fis "$PWD/$file" $HOME
done

# jenkins
ln -Fis "$PWD/.jenkins/myjenkins.css" $HOME/.jenkins/userContent
ln -Fis "$PWD/.jenkins/myjenkins.js" $HOME/.jenkins/userContent

# ssh
ln -Fis "$PWD/.ssh/config" $HOME/.jenkins/userContent


# for dotfile in .?*
# do
#     if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
#     then
#         ln -Fis "$PWD/$dotfile" $HOME
#     fi
# done

