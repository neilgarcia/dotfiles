export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

fpath=(/usr/local/share/zsh-completions $fpath)
fpath+=('/home/neil/.npm-global/lib/node_modules/pure-prompt/functions')

autoload -U promptinit; promptinit
prompt pure
#
# Setting path for java_home
export JAVA_HOME=$(/usr/libexec/java_home -v '1.8*')
export ANDROID_HOME=/Users/neil/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Gtags
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=new-ctags

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/Users/neilgarcia/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

export EDITOR='nvim'

alias vim='nvim'
alias ss='mux start serviceseeking && mux start elasticredis'
# alias tmux='tmux -u'

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

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

bindkey -e
bindkey -r '^Q'
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^F' forward-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^T' transpose-chars
bindkey -M viins '^Y' yank

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

if [ -f ~/.zsh_alias ]; then
  source $HOME/.zsh_alias
fi

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
