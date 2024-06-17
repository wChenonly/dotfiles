# Q pre block. Keep at the top of this file.
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# ZSH_THEME="random"

# fzf-tab暂时移除，因为安装了CodeWhisperer

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
alias nplist="pnpm list -g --depth 0"

alias nrm="nnrm"

# ni
alias b="nr build"
alias t="nr test || nr vitest "
alias nid="ni -D"
alias bb="nr build:all || nr all:build"
alias d="nr dev"
alias release="nr release"


# update
alias deps="bunx taze latest -w -r -i"


alias clean="sudo mac-cleanup -f"



delete-n_m() {
  find . -name "node_modules" -type d -print0 | while IFS= read -r -d $'\0' dir; do
    printf "\033[1;33m删除⌛️ %s ...\033[0m\n" "${dir: -30}"
    rm -rf "$dir"
  done
  printf "\n\033[1;32m删除完成👍.\033[0m\n"
}


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


# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# cd 时在右侧预览目录内容
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# tabtab source for packages
# uninstall by removing these lines
# [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Q post block. Keep at the bottom of this file.
