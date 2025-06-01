# https://htr3n.github.io/2018/07/faster-zsh/
# profiling
#zmodload zsh/zprof
# type zprof when the shell has loaded

# emacs tramp mode
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# -z True if the length of string is zero.
# -n True if the length of string is non-zero.

# man [
if [[ -n "$INSIDE_EMACS" ]]; then
  # don't
else
  # TODO try catppuccin-mocha
  # [[ -f "$HOME/.cache/wal/sequences" ]] && cat ~/.cache/wal/sequences
fi

source "$HOME/.config/dotfiles/source/aliases"

# default owner rw
DEFAULT_UMASK=77
umask $DEFAULT_UMASK
# umask -S
#   u=rwx,g=,o=

# make gpg from emacs prompt in shell (may need to open emacs from command line)
# linux likes this.
# Note, needs to happen before powerlevel10 instant prompt, it redirects too /dev/null
# so tty says "not a tty" if it happens after.
# https://github.com/romkatv/powerlevel10k#how-do-i-export-gpg_tty-when-using-instant-prompt
export GPG_TTY=$TTY

# load zsh plugins
for plug in \
  $HOME/.local/state/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh \
  $HOME/.local/state/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh \
  $HOME/.local/state/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh;
do
  if [[ -f $plug ]]; then
    #echo "Loading plugin $plug"
    source $plug
  fi
done

folder=$(fzf-share 2> /dev/null)
if [ -d "$folder" ]; then
   source "$folder"/completion.zsh
   source "$folder"/key-bindings.zsh
fi

if [[ -f $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  # debug these codes with cat -v
  bindkey "^[p" history-substring-search-up
  bindkey "^[n" history-substring-search-down
fi

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
if [[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  # toggle off with <s-tab> - no, s-tab to complete backwards is useful
  bindkey "^T" autosuggest-toggle

  # no good: bindkey "^I" autosuggest-accept _files
  # tab is a bad idea, it prevents triggering complete of directories
  # you should learn to use right arrow or c-e instead
fi

# e.g. C-o describe-key-briefly <ret>
bindkey '^O' execute-named-cmd
bindkey '^H' describe-key-briefly

# up and down dir with cmd-<up|down>
bindkey "^[^[[A" cd_parent
bindkey "^[^[[B" cd_undo

# prompt install
if [[ ! -d "$HOME/powerlevel10k" ]]; then
  pushd $HOME
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
  source $HOME/powerlevel10k/powerlevel10k.zsh-theme
  p10k configure
  popd
fi

# gpg
function gpg_sign_something_to_check_cached_key_presens() {
  # alternatively,
  # if gpg --pinentry-mode error --local-user 922E681804CA8D82F1FAFCB177836712DAEA8B95 -aso /dev/null <(echo 1234) 2> /dev/null; then
  echo "1234" | gpg --local-user 922E681804CA8D82F1FAFCB177836712DAEA8B95 -as -
}
function gpg_restart_agent() {
  killall gpg-agent && gpg-connect-agent reloadagent /bye
}
function gpg_reload_agent() {
  echo RELOADAGENT | gpg-connect-agent > /dev/null
}
function gpg_cache_test() {
  if ! timeout 0.3s gpg -q --batch -d ~/.authinfo.gpg; then
     echo "could not decrypt, password was not preset in gpg"
     return 1
  fi
}
# Preset gpg passphrase from 1password. Try signing with it first, only preset it if it fails.
# https://stackoverflow.com/questions/11381123/how-to-use-gpg-command-line-to-check-passphrase-is-correct
function gpg_cache () {
  if gpg_cache_test; then
    return 0
  fi
  if [[ "Linux" = "$(uname)" ]]; then
    if ! op item get keybase.io 1>/dev/null; then
      eval $(op signin --account my)
    fi
  fi
  $(gpgconf --list-dirs libexecdir)/gpg-preset-passphrase \
    -c \
    -P "$(op item get keybase.io --format json | jq -j '.fields[] | select(.id == "password") | .value')" \
    $(gpg --fingerprint --with-keygrip torgeir@keybase.io | awk '/Keygrip/ {print $3}' | tail -n 1)
  # I don't get this, but the first time around, after the gpg_cache_test in the previous step, I need to actually use the key to make the agent cache it. Decrypt an encrypted file to make it stick.
  gpg_cache_test > /dev/null
}


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# gradle autocomplete
fpath=($HOME/.zsh/gradle-completion $fpath)

# register autoloads
fpath=($HOME/.zsh/autoloads $fpath)
for f in $(ls $HOME/.zsh/autoloads); do
  autoload $f
done

[[ -d "$HOME/powerlevel10k" ]] && source $HOME/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# https://thevaluable.dev/zsh-completion-guide-examples/
# find new executables in $PATH automatically
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' file-list all
zstyle ':completion:*' group-name ''

# cd fuzzy
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*'

zstyle ':completion:*:options' list-colors '=^(-- *)=34'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

autoload -U select-word-style
select-word-style bash
# export WORDCHARS="*?._-=[]~/&;!#$%^(^(){}<>"
export WORDCHARS=""

# allow bash style comments in interactive shells
setopt interactivecomments

# faster compinit
autoload -Uz compinit
if [ $(date +'%j') != $(date -r ${ZDOTDIR:-$HOME}/.zcompdump +'%j') ]; then
  compinit
else
  compinit -C
fi

# faster compdump
{
  # Compile zcompdump, if modified, to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
  # Execute code in the background to not affect the current session
} &!

# enable ctrl-x-e to edit command line
autoload -U edit-command-line
# emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

case $(uname) in
  Darwin)
    if [[ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]]; then
      # Update PATH for the Google Cloud SDK.
      source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
      # Enable zsh completion for gcloud.
      source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    fi
    
    # don't type the password on every git pull
    # only add keys if theyre not already added
    if [ -z "$(ssh-add -l)" ]; then
      ssh-add -K ~/.ssh/id_ed25519 &>/dev/null
    fi
    ;;
  Linux)

    # if you use multiple terminals simultaneously and want gpg-agent to
    # ask for passphrase via pinentry-curses from the same terminal
    # TODO does this mess up reusing the gpg agent?
    #gpg-connect-agent updatestartuptty /bye &>/dev/null

    # arch needs
    #  sudo ln -sf /usr/bin/pinentry-tty /usr/local/bin/pinentry-tty
    #  sudo ln /usr/bin/ksshaskpass /usr/lib/ssh/ssh-askpass

    # don't type the password on every git pull
    # only add keys if theyre not already added
    if [ -z "$(ssh-add -l)" ]; then
      ssh-add
    fi
    ;;
esac

HISTFILE=~/.zsh_history
setopt hist_expire_dups_first
HISTSIZE=1000
SAVEHIST=800
# dont store space prefixed commands in history
setopt hist_ignore_space
# flush to file as commands are written
# read it always so other tabs see it
setopt sharehistory

# debug escape codes with cat
# directory keybindings, c-up and c-down
cd_undo()   { popd     && zle accept-line }
cd_parent() { pushd .. && zle accept-line }
zle -N cd_parent
zle -N cd_undo
bindkey '^[[1;5A' cd_parent
bindkey '^[[1;5B' cd_undo

# vi like completion menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# zsh vim bindings
# set -o vi
# set -o emacs

if [[ -n "$INSIDE_EMACS" ]]; then
  function e () {
    # on mac realpath is from brew coreutils
    vterm_cmd find-file "$(PATH=/usr/local/opt/coreutils/libexec/gnubin/:$PATH realpath "${@:-.}")"
  }
fi

# automatically change java version from .java-version file
_jdk_autoload_hook() {
  if [[ -f .java-version ]]; then
    echo "Found local .java-version in folder, switching to java version $(cat .java-version)"
    jdk "$(cat .java-version)"
  fi
}

# support setting umask for certain folders
_umask_hook() {
  if [[ -n $UMASK ]]; then
    umask $UMASK
  else
    umask $DEFAULT_UMASK
  fi
}

eval "$(direnv hook zsh)"

source $HOME/.fzfrc

# https://github.com/akermu/emacs-libvterm#directory-tracking-and-prompt-tracking
if command -v autoload &> /dev/null
then
  autoload -U add-zsh-hook
  add-zsh-hook -Uz chpwd (){
    _jdk_autoload_hook
    _umask_hook
    vterm_set_directory
    zoxide add "$(pwd)" >/dev/null &!
  }
fi

PROMPT_COMMAND='echo -ne "\033]2;$(whoami)@$(hostname)\033\\"'
precmd() { eval "$PROMPT_COMMAND" }
