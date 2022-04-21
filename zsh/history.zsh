# 履歴をインクリメンタルに追加
setopt INC_APPEND_HISTORY

# 履歴から入力補完を行う関数を読み込ませる
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# カーソルキー上下に登録
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
