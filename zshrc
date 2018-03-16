#------------------------------------------------------
#zshインタフェースの設定
#------------------------------------------------------
#pbcopyを有効化
#set-option -g default-command "reattach-to-user-namespace -l zsh"

# 日本語を使用
export LANG=ja_JP.UTF-8

# パスを追加したい場合
##export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/miniconda3/bin"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export ANDROID_NDK_HOME="$HOME/Development/android/android-ndk-r11b"
export PATH=$PATH:$ANDROID_NDK_HOME
# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

# emacsキーバインド
bindkey -e

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#PowerShell
function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

#エイリアス
alias ls='gls --color=auto'

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# cdの後にlsを実行
chpwd() { gls --color=auto }

# どこからでも参照できるディレクトリパス
cdpath=(~)

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%s:[%b]'
zstyle ':vcs_info:*' actionformats '%s:[%b|%a]'

function precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

RPROMPT="%1(v|%F{yellow}%1v%f|)"
PROMPT="%(?.%F{green}%}.%F{red})%n@%m%f %*
%F{cyan}[%~]%f $ "

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# コマンドを途中まで入力後、historyから絞り込み
# 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end
export PATH="/usr/local/bin:$PATH"
source /usr/local/bin/virtualenvwrapper.sh

export PATH="/usr/local/opt/qt/bin:$PATH"
