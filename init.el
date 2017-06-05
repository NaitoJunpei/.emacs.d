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
  (package-initialize))

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

;; anything Emacs実践入門P125
;;(when (require 'anything nil t)
;;  (setq
   ;; 候補を表示するまでの時間。
   




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (adwaita))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )