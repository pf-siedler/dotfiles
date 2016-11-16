(require 'org-install)

;;orgで使われるディレクトリを指定
(setq org-directory "~/org")

;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)

;;キーバインド
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-default-notes-file (concat org-directory "~/org/notes.org"))

;;captureのテンプレート
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/task.org" "Tasks")
     "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
	("t" "Idea" entry (file+headline "~/org/note.org" "Idea")
     "* %?\n  %i\n  %a")))

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t!)" "WAIT(w)" "|" "DONE(d!)" "SOMEDAY(s)" "CANCEL(c!)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

;; アジェンダ表示の対象ファイル
(setq org-agenda-files (list org-directory))
;; アジェンダ表示で下線を用いる
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))
(setq hl-line-face 'underline)
;; 標準の祝日を利用しない
(setq calendar-holidays nil)

(setq org-tag-alist
  '(("@OFFICE" . ?o) ("@HOME" . ?h) ("SHOPPING" . ?s)
    ("MAIL" . ?m) ("PROJECT" . ?p)))


;; LaTeX 形式のファイル PDF に変換するためのコマンド
(setq org-latex-pdf-process
      '("lualatex %f" "lualatex %f"))

;; \hypersetup{...} を出力しない
(setq org-latex-with-hyperref nil)
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
             '("thesis"
"\\documentclass{ltjsarticle}
[NO-PACKAGES]
[NO-DEFAULT-PACKAGES]
\\usepackage{graphicx}
\\usepackage{color}
\\usepackage{enumitem}
\\usepackage{siunitx}
\\usepackage{ascmac}
\\usepackage{amsmath}
\\usepackage{url}
\\usepackage[hiragino-pron]{luatexja-preset}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
