
;; 対応する括弧の強調
(show-paren-mode t)

;; 改行でオートインデント
(global-set-key "\C-m" 'newline-and-indent)

;; BSやDel、文字入力でリージョン内の文字を削除
(delete-selection-mode 1)

;; C-k １回で行全体を削除する
(setq kill-whole-line t)

;; M-jを入力すると対応するカッコに飛ぶ
(global-set-key (kbd "M-j") 'match-paren)

;; M-[、M-]でindent-rigidly
(global-set-key (kbd "M-[") 'indent-rigidly-left)
(global-set-key (kbd "M-]") 'indent-rigidly-right)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; 分割ウインドウをShift+カーソルキーで移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; junkファイルを開く
(setq open-junk-file-format "~/org/junk/%Y%m%d-%H%M%S.org")
(global-set-key "\C-xj" 'open-junk-file)
