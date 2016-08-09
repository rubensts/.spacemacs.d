;;; packages.el --- rts-notmuch layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Rubens Souza <rubensts@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `rts-notmuch-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rts-notmuch/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rts-notmuch/pre-init-PACKAGE' and/or
;;   `rts-notmuch/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rts-notmuch-packages
  '(
    (notmuch)
    (notmuch-labeler)
    (helm-notmuch)
    ))

(defun rts-notmuch/init-notmuch ()
  (use-package notmuch
    :ensure t
    :config
    (progn

(progn
    ;; Setup Names and Directories
    (setq user-mail-address "rubens.souza@2ndquadrant.it"
          user-full-name "Rubens Souza")

    (setq notmuch-search-oldest-first nil          ; set default order newest -> oldest
          mail-specify-envelope-from t             ; settings to work with msmtp
          message-sendmail-envelope-from 'header
          mail-specify-envelope-from 'header
          message-kill-buffer-on-exit t            ; kill buffer after sending mail
          notmuch-fcc-dirs "sent"                  ; where store sent mail
          message-directory "drafts"               ; where store postponed messages
          notmuch-hello-thousands-separator "."    ; add a thousand separator
          notmuch-show-all-multipart/alternative-parts nil)

    ;; Completion selection with helm
    (setq notmuch-address-selection-function
          (lambda (prompt collection initial-input)
            (completing-read prompt
                             (cons initial-input collection)
                             nil t nil 'notmuch-address-history)))

    ;; Customized searches
    (setq notmuch-saved-searches
          '((:key "p"  :name "inbox::personal"    :query "tag:personal")
            (:key "2"  :name "inbox::2ndQ"        :query "tag:2ndQ")
            (:key "ma" :name "monitor"            :query "tag:monitor")
            (:key "mj" :name "monitor::jobrapido" :query "tag:monitor and tag:subito")
            (:key "mn" :name "monitor::navionics" :query "tag:monitor and tag:subito")
            (:key "ms" :name "monitor::subito"    :query "tag:monitor and tag:subito")
            (:key "ba" :name "barman"             :query "tag:barman")
            (:key "bj" :name "barman::jobrapido"  :query "tag:barman and tag:jobrapido")
            (:key "bn" :name "barman::navionics"  :query "tag:barman and tag:navionics")
            (:key "ba" :name "barman::subito"     :query "tag:barman and tag:subito")
            (:key "ra" :name "rt"                 :query "tag:rt")
            (:key "rs" :name "rt::24x7"           :query "tag:rt and tag:24x7")
            (:key "rp" :name "rt::platinum"       :query "tag:rt and tag:platinum")
            (:key "rr" :name "rt:rdba"            :query "tag:rt and tag:rdba")
            (:key "rd" :name "rt::developer"      :query "tag:rt and tag:developer")
            (:key "d"  :name "Deleted"            :query "tag:deleted")
            (:key "F"  :name "Flagged"            :query "tag:flagged")
            (:key "S"  :name "Sent"               :query "folder:sent")
            (:key "D"  :name "Drafts"             :query "folder:draft")
            (:key "u"  :name "unread"             :query "tag:unread")
            ))

    ;; Reading mail settings. Keybindings to tag emails
    (define-key notmuch-show-mode-map "S"
      (lambda ()
        "mark message as spam"
        (interactive)
        (notmuch-show-tag-message "+spam" "-inbox")))

    (define-key notmuch-search-mode-map "S"
      (lambda ()
        "mark messages in thread as spam"
        (interactive)
        (notmuch-search-tag "+spam -inbox")))

    (define-key notmuch-show-mode-map "d"
      (lambda ()
        "toggle deleted tag for message"
        (interactive)
        (notmuch-show-tag-message
         (if (member "deleted" (notmuch-show-get-tags))
             "-deleted" "+deleted"))))

    (define-key notmuch-search-mode-map "d"
      (lambda ()
        "toggle deleted tag for message"
        (interactive)
        (notmuch-search-tag
         (if (member "deleted" (notmuch-search-get-tags))
             "-deleted" "+deleted"))))
    ))


(require 'org-notmuch)

(use-package smtpmail
  :ensure t
  :config
  (progn
    ;; (setq message-send-mail-function 'smtpmail-send-it
    ;;       starttls-use-gnutls t
    ;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
    ;;       smtpmail-auth-credentials
    ;;       '(("smtp.gmail.com" 587 "rubensts@gmail.com" nil))
    ;;       smtpmail-default-smtp-server "smtp.gmail.com"
    ;;       smtpmail-smtp-server "smtp.gmail.com"
    ;;       smtpmail-smtp-service 587)

    ;; alternatively, for emacs-24 you can use:
    (setq message-send-mail-function 'smtpmail-send-it
          smtpmail-stream-type 'starttls
          smtpmail-default-smtp-server "smtp.gmail.com"
          smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 587
          smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg"))

    ;; don't keep message buffers around
    (setq message-kill-buffer-on-exit t)))




      ()))

  )


;;; packages.el ends here
