;; this loads the package manager
(require 'package)

;;; windows-specific settings
(if (eq system-type 'windows-nt) 
    (progn
      (setq package-user-dir "C:/Users/gokhan/.emacs.d/elpa"
            visible-bell 1)
      (set-default-font "Consolas-13")))

;; set the package archive URLs
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/") 
                         ("org" . "http://orgmode.org/elpa/")))

(defun add-to-loadpath (&rest dirs)
  (dolist (dir dirs load-path)
    (add-to-list 'load-path (expand-file-name dir) nil #'string=)))

;; converts a relative path (w.r.t. $HOME) to full path
(defun relative-to-init (path)
  (expand-file-name path (getenv "HOME")))

;; add the config folder to the load path
(add-to-loadpath (relative-to-init ".emacs.d/config")
		 (relative-to-init ".emacs.d/plugins/mu4e"))

;; loads packages and activates them
(package-initialize)

;; install the following packages if they aren't already
(dolist (package '(ace-jump-mode
                   ag
                   auctex
                   babel
                   bookmark+
                   cider
                   clojure-mode
                   cmake-mode
                   color-theme-sanityinc-solarized
                   color-theme-sanityinc-tomorrow
                   dired+
                   ecb
                   evil-leader
                   evil
                   evil-nerd-commenter
                   evil-numbers
                   flx-ido
                   flx
                   flycheck
                   f
                   goto-chg
                   goto-last-change
                   hackernews
                   helm-ag
                   helm-projectile
                   helm
                   icicles
                   java-snippets
                   key-chord
                   mark-multiple
                   matlab-mode
                   org
                   org-pandoc
                   org-plus-contrib
                   pandoc-mode
                   paredit
                   projectile
                   pkg-info
                   epl
                   dash
                   s
                   smex
                   sr-speedbar
                   surround
                   undo-tree
                   yasnippet
                   zenburn-theme))
  (unless (package-installed-p package)
    (package-install package)))

;; define the setting files
(defvar my-setting-files '(
                           better-defaults
                           helm-find-files-in-project
                           my-alarm-clock
                           my-clock
                           my-cpp-project
                           my-dictionary
                           my-fullscreen
                           my-functions
                           my-google
                           my-mail
                           ))


;; ------------------------------------------------------------------------
;; general settings
;; ------------------------------------------------------------------------
(mapc #'require my-setting-files)       ; load all my setting files

(setq inhibit-splash-screen t)          ; remove splash screen
(setq inhibit-startup-message t)        ; remove welcome screen
(tool-bar-mode -1)                      ; remove toolbar

(global-set-key [M-left] 'windmove-left)   ; move to left windnow
(global-set-key [M-right] 'windmove-right) ; move to right window
(global-set-key [M-up] 'windmove-up)       ; move to upper window
(global-set-key [M-down] 'windmove-down)   ; move to downer window

(global-hl-line-mode 1)                 ; highlight current line

(recentf-mode 1)                        ; enable recent files
(setq recentf-max-menu-items 50)        ; set max item count
(global-set-key (kbd "C-x f") 'helm-recentf) ; open recent files
(global-set-key (kbd "C-c f") 'helm-locate) ; open recent files

(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface 
to your recently and most frequently used commands.")
(global-set-key (kbd "M-x") 'smex)      ; open with autocomplete

(load-theme 'zenburn t)                 ; load color theme

(global-set-key (kbd "C-x m") 'ansi-term)      ; open shell
(add-hook 'shell-mode-hook (lambda()           ; disable line numbers
                             (linum-mode -1))) ; in shell mode

(defalias 'yes-or-no-p 'y-or-n-p)       ; shorten yes/no answers

(show-paren-mode 1)
(eldoc-mode 1)

(toggle-diredp-find-file-reuse-dir 1)   ; use the same buffers for dired

(setq dired-omit-files                  ; omit dot files
      (concat dired-omit-files "\\|^\\..+$"))

(blink-cursor-mode -1)


;; ------------------------------------------------------------------------
;; evil settings
;; ------------------------------------------------------------------------
(evil-mode 1)                       ; press Ctrl-Z to toggle evil mode

;; Exit insert mode by pressing k & j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(global-surround-mode 1)

;; remap to evil command to find-tag
(define-key evil-normal-state-map (kbd "M-.")   'find-tag)

(evilnc-default-hotkeys)


;; ------------------------------------------------------------------------
;; c/c++ settings settings
;; ------------------------------------------------------------------------
(defun my-c-mode-common-hook ()        ; enable line numbers in c-mode
  (line-number-mode 1)
  (linum-mode 1)
  (c-toggle-auto-state 1)
  (c-toggle-hungry-state 1)
  (setq c-basic-offset 4                  ; indentation fix
        tab-width 4
        indent-tabs-mode t)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq c-default-style "bsd")			; set the bsd/Allman style

(define-key evil-normal-state-map (kbd ",s")   'sr-speedbar-toggle)
(define-key evil-normal-state-map (kbd ",f")   'imenu)


;; ------------------------------------------------------------------------
;; ace-jump settings (integrated inside evil)
;; ------------------------------------------------------------------------
(define-key evil-normal-state-map (kbd ",w")   'evil-ace-jump-word-mode)
(define-key evil-normal-state-map (kbd ",l")   'evil-ace-jump-line-mode)

;; ------------------------------------------------------------------------
;; mark multiple settings
;; ------------------------------------------------------------------------
(define-key evil-visual-state-map (kbd "M-j") 'mark-next-like-this)
(define-key evil-visual-state-map (kbd "M-k") 'mark-previous-like-this)


;; ------------------------------------------------------------------------
;; ido support
;; -----------------------------------------------------------------------
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)   ; disable ido faces to see flx highlights.
;; disable the following buffers
(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
                           "*Messages*" "Async Shell Command"))


;; ------------------------------------------------------------------------
;; snippet settings
;; ------------------------------------------------------------------------
(define-key evil-normal-state-map (kbd "C-c s") 'yas-insert-snippet)
(define-key evil-insert-state-map (kbd "C-c s") 'yas-insert-snippet)
(yas-global-mode 1)                     ; enable YASnippets


;; ------------------------------------------------------------------------
;; helm settings
;; ------------------------------------------------------------------------
(helm-mode 1)
(define-key evil-normal-state-map (kbd "SPC SPC")   'helm-M-x)

(global-set-key (kbd "C-c h") 'helm-mini)
(define-key evil-normal-state-map (kbd ",e")   'helm-find-files)

(define-key evil-normal-state-map (kbd "C-p")   'helm-find-files-in-project)


;; ------------------------------------------------------------------------
;; elisp settings
;; ------------------------------------------------------------------------
(define-key emacs-lisp-mode-map
  (kbd "M-.") 'find-function-at-point)

(defun my-lisp-mode-common-hook ()
  (paredit-mode 1)                      ; enable paredit mode in elisp
  )
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-common-hook)


;; ------------------------------------------------------------------------
;; org-mode settings
;; ------------------------------------------------------------------------
(org-babel-do-load-languages ; babel, for executing 
 'org-babel-load-languages   ; code in org-mode.
 '((sh . t)
   (emacs-lisp . t)
   (C . t)
   (ditaa . t)))
(setq org-src-fontify-natively t)

(setq org-ditaa-jar-path "/home/gokhan/Downloads/ditaa/DitaaEps.jar")

(require 'ox-latex)

(defun my-org-mode-new-settings ()      ; settings for the new org-export
  (progn 
    (require 'ox-latex)
    (add-to-list 'org-latex-classes
                 '("beamer"
                   "\\documentclass\[presentation\]\{beamer\}"
                   ("\\section\{%s\}" . "\\section*\{%s\}")
                   ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
                   ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

    (defun my-beamer-bold (contents backend info)
      (when (eq backend 'beamer)
        (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))
    (add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)

    (require 'ox-beamer)))

(if (not (string< org-version "8.0"))   ; check the version of org-mode
    (my-org-mode-new-settings))

;;; open pdfs with evince
(add-hook 'org-mode-hook
          '(lambda ()
             (delete '("\\.pdf\\'" . default) org-file-apps)
             (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))))


;; ------------------------------------------------------------------------
;; auctex settings
;; ------------------------------------------------------------------------
(setq TeX-auto-save t
      TeX-parse-self t
      reftex-plug-into-AUCTeX t
      TeX-PDF-mode t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; ------------------------------------------------------------------------
;; other settings
;; ------------------------------------------------------------------------
(require 'helm-find-files-in-project)	; like "Goto Anything"
(require 'my-alarm-clock)               ; add an alarm clock functionality
(setenv "PAGER" "/bin/cat")             ; for better shell support

(add-hook 'term-mode-hook               ; enable tab support for ansi-term
          (lambda() (setq yas-dont-activate t)))

(setq ecb-options-version "2.40")

(set-default-font "Meslo LG S-10")

;; Make the GUI version gets the right path
;; read in PATH from .bashrc
(if (not (getenv "TERM_PROGRAM"))
    (progn
      (setenv "PATH" 
              (shell-command-to-string "source $HOME/.bashrc && printf $PATH"))
      (setenv "PIN_HOME" 
              (shell-command-to-string "source $HOME/.bashrc && printf $PIN_HOME"))
      (setenv "PIN_ROOT" 
              (shell-command-to-string "source $HOME/.bashrc && printf $PIN_ROOT"))))
