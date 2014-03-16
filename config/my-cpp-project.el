(require 'cc-mode)

(global-set-key [(f11)] 'compile)  ; compile with F11

(c-toggle-hungry-state 1)               ; delete all whitespace

;; Turns on syntax highlighting.
(global-font-lock-mode t)
;; Sets the syntax highlighting to the maximum amount of colorization.
(setq font-lock-maximum-decoration t)

;; In versions of Emacs greater than 23.2, do the following
(when (or (> emacs-major-version 23)
          (and (= emacs-major-version 23)
               (>= emacs-minor-version 2)))
  ;; Use the GDB visual debugging mode
  (setq gdb-many-windows t)
  ;; Turn Semantic on
  (semantic-mode 1)
  ;; Try to make completions when not typing
  (global-semantic-idle-completions-mode 1)
  ;; Use the Semantic speedbar additions
  (add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb))))

;; Treat .h files as C++ files (instead of C)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Return adds a newline and indents
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(provide 'my-cpp-project)
