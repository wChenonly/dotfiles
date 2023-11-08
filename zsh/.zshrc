# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# ZSH_THEME="random"


plugins=(git fzf-tab zsh-syntax-highlighting zsh-autosuggestions you-should-use)

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
alias ls="eza -l --no-user --no-permissions --git-repos --git --time-style="relative" --icons -F"
alias lssi="dust -d 1 -R -i"
alias lss="dust -d 1 -R"
alias cat="bat --tabs=2 --theme=ansi"

alias download="axel -n 40 -a -o /Users/wchenonly/Downloads"



export PATH=/opt/homebrew/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/


eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"

eval "$(mcfly init zsh)"
export MCFLY_RESULTS=50
export MCFLY_PROMPT="🔍"



export STARSHIP_CONFIG=/Users/wchenonly/.config/starship/starship.toml

# bun completions
[ -s "/Users/wchenonly/.bun/_bun" ] && source "/Users/wchenonly/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/

