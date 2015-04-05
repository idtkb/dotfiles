#!/bin/sh
dotfiles="$HOME/.dotfiles"
cd $(dirname $0)
 
DOT_FILES=( .screenrc .zshrc .zshrc.local)

echo "Installing/Updating dotfiles...\n"

if [ ! -e $dotfiles/.git ]; then
  echo "Cloning dotfiles\n"
  git clone https://github.com/idtkb/dotfiles.git $dotfiles
else
  echo "Updating dotfiles\n"
  cd $dotfiles && git pull
fi

# Karabinerのvim_emuを設定する
VIMEMU_DIR=/Applications/Karabiner.app/Contents/Resources/include/checkbox/vim_emu

if [ -d ${VIMEMU_DIR} ]; then
  sudo ln -Fs "./vim_emu/vim_emu_copy_cut.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_ck.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_disable.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_emu.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_lb.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_rep.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_reset.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_rm.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_settings.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_settings.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_key_click_wrap.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_key_wrap.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_move.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_move_up.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_repeat.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_repeat_macro.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_replace.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_replacementdef.xml" ${VIMEMU_DIR} 
  sudo ln -Fs "./vim_emu/vim_emu_core_ydc_mode.xml" ${VIMEMU_DIR} 
  ln -Fs "./vim_emu/private.xml" "${HOME}/Library/Application Support/Karabiner"
  echo "Karabiner vim_emu was successfully installed.\n"
fi

# vimの設定をする
if [ ! -d $HOME/.vim/bundle ]; then
  echo "creating vim bundle directory.\n"
  mkdir -p ~/.vim/bundle
fi

if [ ! -d $HOME/.vim/bundle/neobundle.vim ]; then
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

#vimのプラグインをインストールする
#vim +NeoBundleInstall +qall

#for file in ${DOT_FILES[@]}
#do
#  ln -Fis "$PWD/$file" $HOME
#done

# jenkins
# ln -Fis "$PWD/.jenkins/userContent/myjenkins.css" $HOME/.jenkins/userContent
# ln -Fis "$PWD/.jenkins/userContent/myjenkins.js" $HOME/.jenkins/userContent

# ssh
#ln -Fis "$PWD/.ssh/config" $HOME/.jenkins/userContent

# for dotfile in .?*
# do
#     if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
#     then
#         ln -Fis "$PWD/$dotfile" $HOME
#     fi
# done

