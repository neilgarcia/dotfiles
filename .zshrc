set -o vi
set -o emacs

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U promptinit; promptinit
prompt pure

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/Users/neilgarcia/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

export EDITOR='vim'

alias vim='nvim'
alias ss='mux start serviceseeking && mux start elasticredis'

## Command history configuration
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

git-branch-current() {
  if ! command git rev-parse 2> /dev/null; then
    print "$0: not a repository: $PWD" >&2
    return 1
  fi

  local ref="$(command git symbolic-ref HEAD 2> /dev/null)"

  if [[ -n "$ref" ]]; then
    print "${ref#refs/heads/}"
    return 0
  else
    return 1
  fi
}


alias gst='git status'
alias gp='git push origin "$(git-branch-current 2> /dev/null)"'
alias gP='git pull origin "$(git-branch-current 2> /dev/null)"'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.bin/tmuxinator.zsh

source ~/.fzf/functions.sh

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper f b t r y
unset -f bind-git-helper
