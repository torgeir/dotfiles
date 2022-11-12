if [ -n "${INSIDE_EMACS+1}" ]; then
  # don't
else
  [[ -f "$HOME/.cache/wal/sequences" ]] && cat ~/.cache/wal/sequences
fi

source $HOME/dotfiles/source/aliases
source $HOME/dotfiles/source/functions

# default owner rw
umask 77

# make gpg from emacs prompt in shell (may need to open emacs from command line)
# linux likes this.
# Note, needs to happen before powerlevel10 instant prompt, it redirects too /dev/null
# so tty says "not a tty" if it happens after.
export GPG_TTY=$(tty)

# helps emacs vterm display the prompt
echo

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# nvm use x is too slow for every shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
# default is set by hand in exports

case $(uname) in
  Linux)
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    ;;
esac

#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# manually
[[ -d "$HOME/Code/powerlevel10k" ]] && source $HOME/Code/powerlevel10k/powerlevel10k.zsh-theme
# arch
[[ -d "/usr/share/zsh-theme-powerlevel10k" ]] && source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# jump around like z
case $(uname) in
  Linux)
    [[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh
    ;;
  Darwin)
    [ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh
    ;;
esac

case $(uname) in
  Linux)
    if command -v xmodmap &> /dev/null
    then
      xmodmap ~/.Xmodmap
    fi

    # movement bindings in Thunar, like in os x Finder
    [[ -f "$HOME/.config/Thunar/" ]] && echo '(gtk_accel_path "<Actions>/ThunarWindow/open-parent" "BackSpace")' >> $HOME/.config/Thunar/accels.scm
    [[ -f "$HOME/.config/Thunar/" ]] && echo '(gtk_accel_path "<Actions>/ThunarWindow/open-parent" "<Alt>Up")' >> $HOME/.config/Thunar/accels.scm
    [[ -f "$HOME/.config/Thunar/" ]] && echo '(gtk_accel_path "<Actions>/ThunarLauncher/open" "<Alt>Down")' >> $HOME/.config/Thunar/accels.scm
    ;;
  Darwin)
    ;;
esac

# complete directories
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

autoload -U select-word-style
select-word-style bash

case $(uname) in
  Darwin)
    # zsh git completion needs git-completion.bash
    zstyle ':completion:*:*:git:*' script /usr/local/Cellar/git/$(git --version | awk '{print $3}')/share/zsh/site-functions/git-completion.bash
    # load completions from brew
    fpath=(~/.zsh $fpath)
    fpath=($(brew --prefix)/share/zsh/5.8/site-functions $fpath)
    ;;
esac

# allow bash style comments in interactive shells
setopt interactivecomments

# dont store space prefixex commands in history
setopt HIST_IGNORE_SPACE

autoload -Uz compinit && compinit -u
# enable ctrl-x-e to edit command line
autoload -U edit-command-line

# emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# peder sin gauth
# source $HOME/Code/gauth/gauth.sh

case $(uname) in
  Darwin)
    # The next line updates PATH for the Google Cloud SDK.
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    # The next line enables zsh completion for gcloud.
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    ;;
  Linux)
    if command -v ssh-agent &> /dev/null
    then
      # launch ssh agent before ssh-add
      eval `ssh-agent -s` > /dev/null 2>&1
    fi
    ;;
esac

# don't type the password on every git pull
ssh-add -K ~/.ssh/id_rsa > /dev/null 2>&1

# https://github.com/akermu/emacs-libvterm#directory-tracking-and-prompt-tracking
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
