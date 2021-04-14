
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r; my_history"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# curl -Ls https://gist.githubusercontent.com/ArikDavidov/969a279852cb9e387831a42f67a02b48/raw/381359cd8a2dc175720a8af79ee309f692f60628/dotfiles_install.sh
# curl -Ls https://git.io/JYSyg
# git clone --bare git@bitbucket.org:ArikDavidov/dotfiles.git $HOME/.dotfiles
# dot config --local status.showUntrackedFiles no
# alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'


alias sudo='sudo ' # https://askubuntu.com/a/22043
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias brc=". ~/.bashrc"
alias gdf='git diff'
alias grom='git rebase origin master'
alias br='git branch'
alias pick='git cherry-pick'
alias gpu='git push -u origin HEAD'
alias gf='getfattr --no-dereference --absolute-names -dm ".*" -R --'
alias ft='git fetch; lg_ ..origin/master'
alias aap='git add -u && git ci --amend && git push -f'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash
export FZF_DEFAULT_OPTS="--reverse --ansi --height 70%"
FORGIT_LOG_GRAPH_ENABLE="false"
FORGIT_COPY_CMD='xclip -selection clipboard'
FORGIT_LOG_FORMAT='%C(yellow)%h%Creset %s %C(bold blue)%an%Creset %Cgreen(%cr)'
source $HOME/forgit/forgit.plugin.sh
source $HOME/.bash-git-prompt/gitprompt.sh

lg_(){ git log --pretty=format:'%C(yellow)%h%Creset %s %C(bold blue)%an%Creset %Cgreen(%cr)' "$@"; }
lg(){ lg_ -10 "$@"; }

int(){
    if [[ $# -eq 0 ]] ; then
        if ! selected_log_line=$(lg_ -15 --color=always | fzf); then
            return 1
        fi
        commit_number=$(echo "$selected_log_line" | cut -d' ' -f1)
        git rebase -i "$commit_number"
    else
        git rebase -i "$@"
    fi
}
brd(){
    if [[ $# -eq 0 ]] ; then
        branch_name="$(git br --color=always \
                        | fzf --multi --preview 'echo {} | xargs git show --color=always' --preview-window 'right:70%' \
                        | sed 's/^[* ]*//g')"
        if [[ -z "$branch_name" ]]; then
            return 1
        fi
        echo "${branch_name[@]}" | xargs git br -D
    else
        git br -D "$@"
    fi
}
co(){
    if [[ $# -eq 0 ]] ; then
        branch_name=$(git br --color=always | sed '/^ *_/d' | fzf | sed 's/^[* ]*//g')
        if [[ -z "$branch_name" ]]; then
            return 1
        fi
        git checkout "$branch_name"
    else
        git checkout "$@"
    fi
}

# git config --global alias.co checkout
# git config --global alias.br branch
# git config --global alias.ci commit
# git config --global alias.st status

# git config --global alias.cm 'commit -m'
# git config --global help.autocorrect 20
