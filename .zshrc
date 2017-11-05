# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
source ~/.zsh_aliases
xinput disable "ELAN Touchscreen"

export VISUAL='vim'
export EDITOR=$VISUAL
export PAGER='less'

export GDK_SCALE=1.5

export PATH=$HOME/bin/scripts:$PATH
export BOOST_PATH=$HOME/utils/boost
export LD_LIBRARY_PATH=$HOME/bin/codecharacter-simulator/simulator/lib

export MPD_HOST=$HOME/.config/mpd/socket

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent` > /dev/null
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

export clang_library_path="/usr/lib:/usr/lib/clang/5.0.0/lib/linux"
export TERM=xterm
export QT_STYLE_OVERRIDE=breeze
