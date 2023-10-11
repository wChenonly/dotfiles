# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# ZSH_THEME="random"


plugins=(git zsh-syntax-highlighting zsh-autosuggestions you-should-use)

source $ZSH/oh-my-zsh.sh


# git

alias gp="git pull origin --prune"
alias gd="git branch | grep -v 'master' | xargs git branch -D"
alias gst="git stash"

# npm

alias ncu="ncu -i --format group"
alias ncu-ws="ncu -i --format group -ws"

alias nlist="npm list -g --depth 0"

alias nrm="nnrm"

# ni
alias b="nr build"
alias d="nr dev"
alias release="nr release"

alias clean="sudo mac-cleanup -f"


# system

alias ls="exa -l --no-user --no-permissions"
alias lssi="dust -d 1 -R -i"
alias lss="dust -d 1 -R"
alias cd="z"
alias cat="bat --tabs=2 --theme=ansi"

alias download="axel -n 40 -a -o /Users/wchenonly/Downloads"



export PATH=/opt/homebrew/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/


eval "$(zoxide init zsh)"
eval "$(starship init zsh)"


export STARSHIP_CONFIG=/Users/wchenonly/.config/starship/starship.toml

# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
