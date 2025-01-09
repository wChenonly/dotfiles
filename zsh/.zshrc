# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# ZSH_THEME="random"


plugins=(git fzf-tab zsh-syntax-highlighting zsh-autosuggestions you-should-use)

source $ZSH/oh-my-zsh.sh

show_and_execute() {
  local GREEN='\033[0;32m'
  local NO_COLOR='\033[0m'
  echo "command:${GREEN} $@${NO_COLOR}"
  command "$@"
}

# git

alias gp="show_and_execute git pull origin --prune"
alias gd="show_and_execute git branch | grep -v 'master' | xargs git branch -D"
alias gst="show_and_execute git stash"


# npm
alias nlist="show_and_execute npm list -g --depth 0"
alias nplist="show_and_execute pnpm list -g --depth 0"

alias nrm="nnrm"

# ni
alias b="nr build"
alias bf="nr build:force"
alias t="nr test || nr vitest"
alias trun="nr test run || nr vitest run"
alias nid="ni -D"
alias bb="nr build:all || nr all:build"
alias d="nr dev"
alias release="nr release"


# update
alias deps="show_and_execute bunx taze latest -w -r -i"


alias clean="show_and_execute sudo mac-cleanup -f"


delete-n_m() {
  start_time=$(date +%s) # 记录开始时间

  # 记录所有 node_modules 目录的数量
  all_node_modules_count=$(find . -name "node_modules" -type d | wc -l)

  if [[ $all_node_modules_count -eq 0 ]]; then
    printf "\n\033[0;32m项目中没有找到 node_modules 目录 🙈 \033[0m\n"
    ask_for_reinstall
    return
  fi

  top_level_count=0 # 初始化顶层计数器
  total_files_deleted=0 # 初始化文件删除计数器
  total_size_to_delete=0 # 初始化待删除的总大小计数器

  # 函数：使用 dust 计算目录大小
  calculate_dir_size() {
    local dir=$1
    local size_mb=$(du -sm "$dir" | cut -f1)
    local size=$((size_mb * 1024 * 1024))
    echo $size
  }

  # 查找顶层 node_modules 目录并统计大小和文件数量
  find . -name "node_modules" -type d -prune -print0 | while IFS= read -r -d $'\0' dir; do
    num_files=$(find "$dir" -type f | wc -l) # 统计该目录下的文件数量
    dir_size=$(calculate_dir_size "$dir") # 统计该目录的总大小（以字节为单位）

    top_level_count=$((top_level_count + 1))  # 顶层计数器加一
    total_files_deleted=$((total_files_deleted + num_files))  # 累加删除的文件数量
    total_size_to_delete=$((total_size_to_delete + dir_size))  # 累加待删除的总大小

    # 删除顶层 node_modules 目录
    printf "\033[0;37m删除 ⌛️ %s \033[0m\n" "${dir}"
    rm -rf "$dir" # 删除目录
  done

  # 删除锁文件并统计大小
  lock_files=("pnpm-lock.yaml" "package-lock.json" "yarn.lock" "bun.lock")
  for lock_file in "${lock_files[@]}"; do
    while IFS= read -r -d $'\0' file; do
      file_size=$(calculate_dir_size "$file" 2>/dev/null) # 注意这里应该用 calculate_file_size，但 dust 通常用于目录
      if [[ -n "$file_size" ]]; then
          printf "\n\033[0;36m删除 🔐 %s \033[0m\n" "${file}"
          rm -f "$file"
          total_size_to_delete=$((total_size_to_delete + file_size)) # 累加待删除的总大小
      fi
    done < <(find . -name "$lock_file" -type f -print0)
  done

  end_time=$(date +%s) # 记录结束时间
  elapsed_time=$((end_time - start_time)) # 计算耗时

  total_size_deleted_mb=$(echo "scale=2; $total_size_to_delete / 1024 / 1024" | bc) # 转换为 MB

  printf "\n\033[0;32m删除完成 👍. 删除了 %d 个顶层的 node_modules 目录, %d 个文件, 占用约 %.2f MB, 耗时 %d 秒 \033[0m\n" "$top_level_count" "$total_files_deleted" "$total_size_deleted_mb" "$elapsed_time"
  printf "\n\033[0;32m项目中共有 %d 个 node_modules 目录 \033[0m\n" "$all_node_modules_count"

  # 提示是否需要重新安装依赖
  ask_for_reinstall
}

ask_for_reinstall() {
  printf "\n\033[1;33m是否需要重新安装依赖 🤔 ？(默认是) [Y/n]: \033[0m"
  read reinstall_choice
  reinstall_choice=${reinstall_choice:-Y}  # 如果用户未输入任何内容，默认为 Y

  if [[ $reinstall_choice =~ ^[Yy]$ ]]; then
    # 开始安装依赖
    printf "\n\033[0;34m开始安装依赖 📦 ...\033[0m\n\n"
    reinstall_start_time=$(date +%s) # 记录重新安装依赖的开始时间
    ni
    reinstall_end_time=$(date +%s) # 重新安装依赖的结束时间
    reinstall_elapsed_time=$((reinstall_end_time - reinstall_start_time)) # 重新安装依赖的耗时
    printf "\n\033[0;34m安装依赖完成 ✅ 耗时 %d 秒 \033[0m\n" "$reinstall_elapsed_time"
  else
    printf "\n\033[31m取消安装依赖 😤\033[0m\n"
  fi
}



# system
alias ls="show_and_execute  eza -l --no-user --no-permissions --git-repos --git --time-style="relative" --icons -F"
alias lssi="show_and_execute dust -d 1 -R -i"
alias lss="show_and_execute dust -d 1 -R"
alias cat="show_and_execute bat --tabs=2 --theme=ansi"

alias download="axel -n 40 -a -o /Users/wchenonly/Downloads"



export PATH=/opt/homebrew/bin:$PATH



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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Suppress last login message
if [ -f ~/.hushlogin ]; then
  :
fi





# pnpm
export PNPM_HOME="/Users/wchenonly/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

CARGO_UNSTABLE_SPARSE_REGISTRY=true



# eval "$(fnm env --use-on-cd --shell zsh)"

# fnm
FNM_PATH="/Users/wchenonly/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/wchenonly/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi



