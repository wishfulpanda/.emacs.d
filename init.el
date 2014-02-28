;; this loads the package manager
(require 'package)

;; set the package archive URLs
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")
						 ("gnu" . "http://elpa.gnu.org/packages/")))

(defun add-to-loadpath (&rest dirs)
  (dolist (dir dirs load-path)
    (add-to-list 'load-path (expand-file-name dir) nil #'string=)))

;; add the config folder to the load path
(add-to-loadpath "~/.emacs.d/config")

;; loads packages and activates them
(package-initialize)

;; define the setting files
(defvar my-setting-files '(
						   ;; my-color
						   ))

;; ------------------------------------------------------------------------
;; general settings
;; ------------------------------------------------------------------------
(mapc #'require my-setting-files)		          ; load all my setting files

(setq inhibit-splash-screen t)			          ; remove splash screen
(setq inhibit-startup-message t)		          ; remove welcome screen
;; (menu-bar-mode -1)								  ; remove menu bar
(tool-bar-mode -1)								  ; remove tool bar

(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window

(setq-default c-basic-offset 4                    ; indentation fix
			  tab-width 4
              indent-tabs-mode t)

(global-linum-mode t)					          ; enable line numbers
(global-hl-line-mode 1)							  ; highlight current line
(yas-global-mode 1)								  ; enable YASnippets

(recentf-mode 1)								   ; enable recent files
(setq recentf-max-menu-items 25)				   ; set max item count
(global-set-key (kbd "C-x f") 'recentf-open-files) ; open recent files

(global-set-key (kbd "C-x C-b") 'buffer-menu)      ; open recent files


(autoload 'smex "smex"					           ; smex
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface 
to your recently and most frequently used commands.")
(global-set-key (kbd "M-x") 'smex)                 ; open with autocomplete

(load-theme 'zenburn t)					           ; load color theme

(global-set-key (kbd "C-x m") 'shell)			   ; open shell
(add-hook 'shell-mode-hook (lambda()	           ; disable line numbers
							  (linum-mode -1)))	   ; in shell mode

;; ------------------------------------------------------------------------
;; evil settings
;; ------------------------------------------------------------------------
(evil-mode 1)

;; press Ctrl-Z to toggle evil mode

;; Exit insert mode by pressing k & j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)


;; ------------------------------------------------------------------------
;; ace-jump settings (integrated inside evil)
;; ------------------------------------------------------------------------
(define-key evil-normal-state-map (kbd "SPC")     'evil-ace-jump-char-mode)
(define-key evil-normal-state-map (kbd ", , w")   'evil-ace-jump-word-mode)
(define-key evil-normal-state-map (kbd ", , c")   'evil-ace-jump-char-mode)
(define-key evil-normal-state-map (kbd ", , l")   'evil-ace-jump-line-mode)

(define-key evil-operator-state-map (kbd ", , c") 'evil-ace-jump-char-mode)
(define-key evil-operator-state-map (kbd ", , l") 'evil-ace-jump-line-mode)

;; ------------------------------------------------------------------------
;; mark multiple settings
;; ------------------------------------------------------------------------
(define-key evil-visual-state-map (kbd "M-j") 'mark-next-like-this)
(define-key evil-visual-state-map (kbd "M-k") 'mark-previous-like-this)

;; ------------------------------------------------------------------------
;; ido support
;; ------------------------------------------------------------------------
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)   ; disable ido faces to see flx highlights.

;; ------------------------------------------------------------------------
;; snippet settings
;; ------------------------------------------------------------------------
(define-key evil-normal-state-map (kbd "C-c s") 'yas-insert-snippet)
(define-key evil-insert-state-map (kbd "C-c s") 'yas-insert-snippet)


;; ------------------------------------------------------------------------
;; helm settings
;; ------------------------------------------------------------------------
(global-set-key (kbd "C-c h") 'helm-mini)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("a3d519ee30c0aa4b45a277ae41c4fa1ae80e52f04098a2654979b1ab859ab0bf" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
