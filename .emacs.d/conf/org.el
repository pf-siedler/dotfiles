(require 'org-install)

;;orgで使われるディレクトリを指定
(setq org-directory "~/Dropbox/org")

;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)

;;キーバインド
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-default-notes-file (concat org-directory "~/Dropbox/org/notes.org"))

;;captureのテンプレート
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/org/task.org" "Tasks")
     "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/Dropbox/org/journal.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
	("t" "Idea" entry (file+headline "~/Dropbox/org/note.org" "Idea")
     "* %?\n  %i\n  %a")))

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t!)" "WAIT(w)" "|" "DONE(d!)" "SOMEDAY(s)" "CANCEL(c!)")))
;; DONEの時刻を記録
(setq org-log-done 'time)

;; アジェンダ表示の対象ファイル
(setq org-agenda-files (list org-directory "~/org/junk/"))
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-structure-template-alist
   (quote
    (("time" "#+TODO: TOMATO(t) | TROWN(T)
* 8:00
* 8:30
* 9:00
* 9:30
* 10:00
* 10:30
* 11:00
* 11:30
* 12:00
* 12:30
* 13:00
* 13:30
* 14:00
* 14:30
* 15:00
* 15:30
* 16:00
* 16:30
* 17:00
* 17:30
* 18:00
* 18:30
* 19:00
* 19:30
* 20:00
* 20:30
* 21:00
* 21:30
* 22:00
* 22:30
* 23:00
* 23:30
")
     ("s" "#+BEGIN_SRC ?

#+END_SRC")
     ("e" "#+BEGIN_EXAMPLE
?
#+END_EXAMPLE")
     ("q" "#+BEGIN_QUOTE
?
#+END_QUOTE")
     ("v" "#+BEGIN_VERSE
?
#+END_VERSE")
     ("V" "#+BEGIN_VERBATIM
?
#+END_VERBATIM")
     ("c" "#+BEGIN_CENTER
?
#+END_CENTER")
     ("l" "#+BEGIN_EXPORT latex
?
#+END_EXPORT")
     ("L" "#+LaTeX: ")
     ("h" "#+BEGIN_EXPORT html
?
#+END_EXPORT")
     ("H" "#+HTML: ")
     ("a" "#+BEGIN_EXPORT ascii
?
#+END_EXPORT")
     ("A" "#+ASCII: ")
     ("i" "#+INDEX: ?")
     ("I" "#+INCLUDE: %file ?"))))
 '(package-selected-packages (quote (org))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
