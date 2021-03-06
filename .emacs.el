
;
; ~/.emacs.el
;
; Last-Modified: 2016/10/10 09:38:31
;
;
(require 'tramp)
; (setq tramp-default-method "ssh")
; (add-to-list 'tramp-remote-path "/usr/bin")

(line-number-mode 1)
(column-number-mode 1)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default 'buffer-file-coding-system 'utf-8-with-signature)

;; Dired の表示を "ls -aoFLt" にする。
; (setq dired-listing-switches "-aoFL")

;; 日付が日本語だと、file を読み込む際に
;;  No file on this line と怒られるので 回避する。
(add-hook 'dired-mode-hook  '(lambda ()(setenv "LANG" "C")))

(if window-system (progn
(set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
(set-face-foreground 'font-lock-string-face  "purple")
(set-face-foreground 'font-lock-keyword-face "blue")
(set-face-foreground 'font-lock-function-name-face "blue")
(set-face-bold-p 'font-lock-function-name-face t)
(set-face-foreground 'font-lock-variable-name-face "black")
(set-face-foreground 'font-lock-type-face "LightSeaGreen")
(set-face-foreground 'font-lock-builtin-face "purple")
(set-face-foreground 'font-lock-constant-face "black")
(set-face-foreground 'font-lock-warning-face "blue")
(set-face-bold-p 'font-lock-warning-face nil)
))

;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 85))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 85)

(add-to-list 'default-frame-alist '(alpha . (100 70)))

(set-frame-parameter nil 'alpha '(100 70)) 
(set-frame-parameter nil 'alpha '(0.8 nil)) 
(set-frame-parameter nil 'alpha nil) 

(setq visible-bell t)

(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 20)
(setq recentf-exclude '("^/[^/:]+:"))
(recentf-mode 1)

(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "Last-Modified: ")
(setq time-stamp-format "%04y/%02m/%02d %02H:%02M:%02S")
;(setq time-stamp-end " \\|$")
(setq time-stamp-end "$")

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;(require 'autoinsert)
;(setq auto-insert-directory "~/lib/")
;(setq auto-insert-alist
;      (nconc '( ("\\.c$" . "template.c")
;                ("\\.f$" . "template.f")
;                ) auto-insert-alist))
;
;(add-hook 'find-file-not-found-hooks 'auto-insert)

(setq compilation-window-height 10)

(set-language-environment "Japanese")

;(require 'emacs-keybind)


