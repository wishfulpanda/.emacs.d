(require 'cc-mode)

(setq compilation-finish-function
      (lambda (buf str) 
        (if (not (string-match "exited abnormally" str) ) 
            (progn
              ;;no errors, make the compilation window go away in 0.5 seconds
              (run-at-time 0.5 nil 'delete-windows-on buf)
              (message "NO COMPILATION ERRORS!")))))

(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window (- h 10)))))))

(add-hook 'compilation-mode-hook 'my-compilation-hook)

(global-set-key [(f11)] 'compile)  ; compile with F11

(c-toggle-hungry-state 1)               ; delete all whitespace

;; ;;; use only tabs for indentation
;; (defun my-build-tab-stop-list (width)
;;   (let ((num-tab-stops (/ 80 width))
;;         (counter 1)
;;         (ls nil))
;;     (while (<= counter num-tab-stops)
;;       (setq ls (cons (* width counter) ls))
;;       (setq counter (1+ counter)))
;;     (set (make-local-variable 'tab-stop-list) (nreverse ls))))
;; (defun my-c-mode-common-hook ()
;;   (setq tab-width 4) ;; change this to taste, this is what K&R uses :)
;;   (my-build-tab-stop-list tab-width)
;;   (setq c-basic-offset tab-width))

;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; ;; CEDET
;; (global-ede-mode 'nil)                  ; do NOT use project manager
 
;; (require 'semantic-ia)          ; names completion and display of tags
;; (require 'semantic-gcc)         ; auto locate system include files
;; (require 'semanticdb)

;; (semantic-load-enable-excessive-code-helpers)
;; (global-semanticdb-minor-mode 1)
 
;; (defun my-cedet-hook ()
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-c=" 'semantic-decoration-include-visit)
;;   (local-set-key "\C-cj" 'semantic-ia-fast-jump)
;;   (local-set-key "\C-cq" 'semantic-ia-show-doc)
;;   (local-set-key "\C-cs" 'semantic-ia-show-summary)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;   (local-set-key "\C-c+" 'semantic-tag-folding-show-block)
;;   (local-set-key "\C-c-" 'semantic-tag-folding-fold-block)
;;   (local-set-key "\C-c\C-c+" 'semantic-tag-folding-show-all)
;;   (local-set-key "\C-c\C-c-" 'semantic-tag-folding-fold-all)
;;   )
;; (add-hook 'c-mode-common-hook 'my-cedet-hook)
 
;; (global-semantic-tag-folding-mode 1)
 
;; (require 'eassist)
 
;; ;(concat essist-header-switches ("hh" "cc"))
;; (defun alexott/c-mode-cedet-hook ()
;;   (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-ce" 'eassist-list-methods)
;;   (local-set-key "\C-c\C-r" 'semantic-symref)
;;   )
;; (add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)
 
;; ;; gnu global support
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
 
;; ;; ctags
;; (require 'semanticdb-ectag)
;; (semantic-load-enable-primary-exuberent-ctags-support)
 
;; (global-semantic-idle-tag-highlight-mode 1)

;; ;;; ecb
;; (require 'ecb)
;; (require 'ecb-autoloads)

(provide 'my-cpp-project)
