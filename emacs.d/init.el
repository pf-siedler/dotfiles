
;; 言語設定
(set-language-environment 'Japanese)
;; Special setup for various symbols and some rarely used characters
;; covered well by Symbola.
(dolist (symbol-subgroup '((#x0250 . #x02AF)   ;; IPA Extensions
                           (#x0370 . #x03FF)   ;; Greek and Coptic
                           (#x0500 . #x052F)   ;; Cyrillic Supplement
                           (#x2000 . #x206F)   ;; General Punctuation
                           (#x2070 . #x209F)   ;; Superscripts and Subscripts
                           (#x20A0 . #x20CF)   ;; Currency Symbols
                           (#x2100 . #x214F)   ;; Letterlike Symbols
                           (#x2150 . #x218F)   ;; Number Forms
                           (#x2190 . #x21FF)   ;; Arrows
                           (#x2200 . #x22FF)   ;; Mathematical Operators
                           (#x2300 . #x23FF)   ;; Miscellaneous Technical
                           (#x2400 . #x243F)   ;; Control Pictures
                           (#x2440 . #x245F)   ;; Optical Char Recognition
                           (#x2460 . #x24FF)   ;; Enclosed Alphanumerics
                           (#x25A0 . #x25FF)   ;; Geometric Shapes
                           (#x2600 . #x26FF)   ;; Miscellaneous Symbols
                           (#x2700 . #x27bF)   ;; Dingbats
                           (#x27C0 . #x27EF)   ;; Misc Mathematical Symbols-A
                           (#x27F0 . #x27FF)   ;; Supplemental Arrows-A
                           (#x2900 . #x297F)   ;; Supplemental Arrows-B
                           (#x2980 . #x29FF)   ;; Misc Mathematical Symbols-B
                           (#x2A00 . #x2AFF)   ;; Suppl. Math Operators
                           (#x2B00 . #x2BFF)   ;; Misc Symbols and Arrows
                           (#x2E00 . #x2E7F)   ;; Supplemental Punctuation
                           (#x4DC0 . #x4DFF)   ;; Yijing Hexagram Symbols
                           (#xFE10 . #xFE1F)   ;; Vertical Forms
                           (#x10100 . #x1013F) ;; Aegean Numbers
                           (#x102E0 . #x102FF) ;; Coptic Epact Numbers
                           (#x1D000 . #x1D0FF) ;; Byzanthine Musical Symbols
                           (#x1D200 . #x1D24F) ;; Ancient Greek Musical Notation
                           (#x1F0A0 . #x1F0FF) ;; Playing Cards
                           (#x1F100 . #x1F1FF) ;; Enclosed Alphanumeric Suppl
                           (#x1F300 . #x1F5FF) ;; Misc Symbols and Pictographs
                           (#x1F600 . #x1F64F) ;; Emoticons
                           (#x1F650 . #x1F67F) ;; Ornamental Dingbats
                           (#x1F680 . #x1F6FF) ;; Transport and Map Symbols
                           (#x1F700 . #x1F77F) ;; Alchemical Symbols
                           (#x1F780 . #x1F7FF) ;; Geometric Shapes Extended
                           (#x1F800 . #x1F8FF))) ;; Supplemental Arrows-C
  (set-fontset-font "fontset-default" symbol-subgroup "Symbola"))
;; Box Drawing and Block Elements
(set-fontset-font "fontset-default" '(#x2500 . #x259F) "FreeMono")

;; 文字コード設定
(prefer-coding-system 'utf-8)

;;visible bell
(setq visible-bell t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;画面サイズ
(setq initial-frame-alist
      (append
       '((top . 0)    ; フレームの Y 位置(ピクセル数)
	 (left . 0)    ; フレームの X 位置(ピクセル数)
	 (width . 100)    ; フレーム幅(文字数)
	 (height . 56)   ; フレーム高(文字数)
	)
       initial-frame-alist))

;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
	      "/Library/TeX/texbin"
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

;; shell の存在を確認
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      ;; (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;; (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

;;設定ファイルテスト用
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;El-Getインストール設定
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle auto-complete)
(el-get-bundle org)
(el-get-bundle org-mode)
(el-get-bundle open-junk-file)
(el-get-bundle multi-term)

(setq load-path (append '("~/.emacs.d/conf") load-path))

(load "org")
(load "interface")
