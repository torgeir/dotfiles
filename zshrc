if [ -n "${INSIDE_EMACS+1}" ]; then
  # don't
else
  cat ~/.cache/wal/sequences
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/dotfiles/source/aliases
source $HOME/dotfiles/source/functions

case $(uname) in
  Linux)
    export NVM_DIR="/usr/share/nvm/nvm.sh"
    ;;
  Darwin)
    export NVM_DIR="$HOME/.nvm"
    ;;
esac
#  20211106 reinstalled, too slow
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm

case $(uname) in
  Linux)
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    ;;
esac

#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $HOME/Code/powerlevel10k/powerlevel10k.zsh-theme

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
    xmodmap ~/.Xmodmap

    # movement bindings in Thunar, like in os x Finder
    thunar -q
    echo '(gtk_accel_path "<Actions>/ThunarWindow/open-parent" "BackSpace")' >> $HOME/.config/Thunar/accels.scm
    echo '(gtk_accel_path "<Actions>/ThunarWindow/open-parent" "<Alt>Up")' >> $HOME/.config/Thunar/accels.scm
    echo '(gtk_accel_path "<Actions>/ThunarLauncher/open" "<Alt>Down")' >> $HOME/.config/Thunar/accels.scm
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
    zstyle ':completion:*:*:git:*' script /usr/local/Cellar/git/2.31.1/share/zsh/site-functions/git-completion.bash
    # load completions from brew
    fpath=(~/.zsh $fpath)
    fpath=($(brew --prefix)/share/zsh/5.8/site-functions $fpath)
    ;;
esac

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
esac

# https://github.com/akermu/emacs-libvterm#directory-tracking-and-prompt-tracking
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }