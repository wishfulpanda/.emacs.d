;; ------------------------------------------------------------------------
;; mail settings
;; ------------------------------------------------------------------------

(require 'mu4e)
(require 'smtpmail)

;;; list the mail accounts here
(defvar my-mu4e-account-alist
  '(("Gmail"
     ( mu4e-drafts-folder "/Gmail/[Gmail].Drafts" )
     ( mu4e-sent-folder "/Gmail/[Gmail].Sent Mail" )
     ( mu4e-trash-folder "/Gmail/[Gmail].Trash" )
     ( user-mail-address "gokhankici@gmail.com" )
     ( user-full-name "Gökhan Kıcı" )
     ( message-signature "Gokhan" )
     ( smtpmail-default-smtp-server "smtp.gmail.com" )
     ( smtpmail-smtp-server "smtp.gmail.com" )
     ( smtpmail-smtp-service 587 ))
    ("Boun"
     ( mu4e-drafts-folder "/Boun/Taslaklar" )
     ( mu4e-sent-folder "/Boun/Sent" )
     ( mu4e-trash-folder "/Boun/Trash" )
     ( user-mail-address "gokhan.kici@boun.edu.tr" )
     ( user-full-name "Gökhan Kıcı" )
     ( message-signature "Gokhan" )
     ( message-send-mail-function 'smtpmail-send-it )
     ( smtpmail-stream-type 'starttls )
     ( smtpmail-default-smtp-server "smtp.boun.edu.tr" )
     ( smtpmail-smtp-server "smtp.boun.edu.tr" )
     ( smtpmail-smtp-service 587 ))))

;;; Set the default mail account
(setq my-mail-default-mail-account "Gmail")

;;; Load the default mail account's parameters
(let ((account-vars 
       (cdr (assoc my-mail-default-mail-account my-mu4e-account-alist))))
  (mapc #'(lambda (var) (set (car var) (cadr var))) account-vars))

;;; Set the default mail account's shortcuts
(defun my-mail-set-shortcuts (account)
  (if (string= account "Gmail")
      (setq mu4e-maildir-shortcuts '( ("/Gmail/INBOX"               . ?i)
                                      ("/Gmail/[Gmail].Sent Mail"   . ?s)
                                      ("/Gmail/[Gmail].Trash"       . ?t)
                                      ("/Gmail/[Gmail].All Mail"    . ?a))
            message-send-mail-function 'smtpmail-send-it
            smtpmail-stream-type 'starttls)
    (setq mu4e-maildir-shortcuts '( ("/Boun/INBOX"  . ?i)
                                    ("/Boun/Sent"   . ?s)
                                    ("/Boun/Trash"  . ?t))
          message-send-mail-function 'smtpmail-send-it
          smtpmail-stream-type 'starttls)))

(my-mail-set-shortcuts "Gmail")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 300
      mu4e-headers-auto-update t)

;;; new mail notification
(require 'notifications)
(add-hook 'mu4e-index-updated-hook 
          (defun my-new-mail-notification () 
            (notifications-notify :title "mu4e" :body "New update!")))

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;;; view html files
(setq mu4e-html2text-command "html2text -utf8 -width 72")

(setq mu4e-view-show-images t)

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (interactive)
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (progn 
          (mapc #'(lambda (var) (set (car var) (cadr var))) account-vars) 
          (my-mail-set-shortcuts account))
      (error "No email account found"))))

;;; check for current mail settings when sending an email
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

(provide 'my-mail)
