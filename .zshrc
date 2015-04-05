#export GIT_PROXY_COMMAND="/usr/local/bin/git-proxy"

#fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
#autoload -U compinit ; compinit

#source ~/.zsh/plugin/incr-0.2.zsh

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'


s(){
    if [ $# -eq 0 ]; then
        cat > /tmp/tmux.tmp && tmux split-window -h "less /tmp/tmux.tmp"
    else
        tmux split-window -h "$*"
    fi
}

bindkey ^f forward-word
bindkey ^b backward-word

DIRSTACKSIZE=100
setopt AUTO_PUSHD

# z
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
   z --add "$(pwd -P)"
}


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history


function google() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

ICON=$'\U2601'

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
# 一般ユーザ時
#tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt="%{${fg[cyan]}%}$ICON %n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}%1(v|%F{green}%1v%f|)[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

alias ls='ls -GF'

# 最後に打ったコマンドステータス行に
if [ "$TERM" = "screen" ]; then
        chpwd () { echo -n "_`dirs`\\" }
        preexec() {
                # see [zsh-workers:13180]
                # http://www.zsh.org/mla/workers/2000/msg03993.html
                emulate -L zsh
                local -a cmd; cmd=(${(z)2})
                case $cmd[1] in
                        fg)     if ; then
                                        cmd=(builtin jobs -l %+)
                                else
                                        cmd=(builtin jobs -l $cmd[2])
                                fi
                                ;;
                        %*)
                                cmd=(builtin jobs -l $cmd[1])
                                ;;
                        cd)                                if ; then
                                        cmd[1]=$cmd[2]
                                fi
                                ;&
                        *)
                                echo -n "k$cmd[1]:t\\"
                                return
                                ;;
                esac

                local -A jt; jt=(${(kv)jobtexts})

                $cmd >>(read num rest
                        cmd=(${(z)${(e):-\$jt$num}})
                        echo -n "k$cmd[1]:t\\") 2>/dev/null
        }
        chpwd
fi

