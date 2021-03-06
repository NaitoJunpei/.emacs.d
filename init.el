;;円記号でなくて、バックスラッシュを標準にする

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(define-key global-map [?¥][?\\])

;; load-pathを追加する関数を定義
(defun add-to-load-path(&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdir-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "elpa")

;; auto-install.el
(when (require 'auto-install nil t)
  ;;インストールディレクトリを設定
  (setq auto-install-directory "~/.emacs.d/elisp")
  ;; "EmacsWikiに登録されているelispの名前を取得
  (auto-install-update-emacswiki-package-name t)
  ;; install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))

;; package.elの設定
(when (require 'package nil t)
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (package-initialize))

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))

;; emacsclientを使えるようにする
;;(server-start)



;;(set-face-background 'default "#ddffdd")

;;透明度を変更するコマンド　M-x set-alpha
(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))

;;ロードパスの設定
;;(setq load-path (append
;;		 '("~/.emacs.d"
;;		   "~/.emacs.d/packages")))

;;スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;;メニューバーを消す
(menu-bar-mode -1)

;;スクロールは一行ごとに
(setq scroll-step 1)
(setq scroll-conservatively 1)

;;バックアップファイルなど
(setq make-backup-files t)

(setq backup-directory-alist '((".*" . "~/.emacs.d/ehist")))

(setq auto-save-default t)
(setq auto-save-timeout 10)
(setq auto-save-inaterval 100)

;;Javascript Indent
(setq js-indent-level 8)


;;LaTex
;;(require 'tex-site)
(setq tex-indent-level 2)

;;M-x compileって打つのめんどくさい
(define-key global-map (kbd "C-c c") 'compile)
;;M-x alignって打つのめんどくさい
(define-key global-map (kbd "C-c a") 'align)
;;C-x o って打つのめんどくさい
(define-key global-map (kbd "C-t") 'other-window)

;; paren-mode 対応するかっこを強調表示 Emacs実践入門P101
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression) ;;かっこ内も強調表示
(set-face-background 'show-paren-match-face "lightgreen")
(set-face-underline-p 'show-paren-match-face "blue")

;;anything Emacs実践入門P125
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間
   anything-idle-delay 0.3
   ;; タイプして再描画するまでの時間
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数
   anything-candidate-number-limit 100
   ;; 候補が多い時に体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するときのコマンド
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
  	     (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindings をAnythingに置き換える
    (descbinds-anything-install))
  )

;; anything-show-killing-ring
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
(define-key global-map (kbd "C-c f") 'anything-for-files)

;; auto-completeの設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
	       "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; ElScreenの設定
(when (require 'elscreen nil t)
  ;; C-z C-zをタイプした場合にデフォルトのC-zを利用する
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))
;; header-lineの先頭に<->を表示しない
(setq elscreen-tab-display-control nil)
(elscreen-start)

;; flymake-python-pyflakesの設定
(when (require 'flymake-python-pyflakes nil t)
  (setq flymake-python-pyflakes-executable "pychecker"))
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

;; Eggの設定
(when (executable-find "git")
  (require 'egg nil t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (adwaita)))
 '(package-selected-packages
   (quote
    (egg flymake-easy flymake-python-pyflakes apel elscreen anything auto-complete package-utils popup))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
