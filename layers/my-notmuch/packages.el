;;; packages.el --- my-notmuch layer packages file for Spacemacs.
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
;; added to `my-notmuch-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-notmuch/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-notmuch/pre-init-PACKAGE' and/or
;;   `my-notmuch/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-notmuch-packages
  '(notmuch
    org
    org-notmuch
    gnus-alias
    ))

(defun my-notmuch/init-notmuch ()
  (use-package notmuch
    :defer t
    :init (progn
            (evil-leader/set-key "an" 'notmuch))
    :config (progn
              ;; notmuch buffers are useful - https://github.com/syl20bnr/spacemacs/issues/6681
              (push "\\*notmuch.+\\*" spacemacs-useful-buffers-regexp)

              (setq notmuch-command "~/my-prj/dotfiles/remote-notmuch.sh"
                    notmuch-search-oldest-first nil          ; set default order newest -> oldest
                    mail-specify-envelope-from t             ; settings to work with msmtp
                    message-sendmail-envelope-from 'header
                    mail-specify-envelope-from 'header
                    message-kill-buffer-on-exit t            ; kill buffer after sending mail
                    notmuch-hello-thousands-separator "."    ; add a thousand separator
                    notmuch-show-all-multipart/alternative-parts nil
                    notmuch-search-line-faces '(("unread" :weight bold)
                                                ("flagged" :inherit 'font-lock-string-face))

                    ;; Format how search results are shown
                    notmuch-search-result-format '(("date"    . "%12s  ")
                                                   ("count"   . "%-7s  ")
                                                   ("authors" . "%-30s ")
                                                   ("subject" . "%s ")
                                                   ("tags"    . "(%s)"))
                    )

              ;; change "unread" into an icon
              (add-to-list 'notmuch-tag-formats
                           '("unread"
                             (notmuch-tag-format-image-data tag
                                                            (notmuch-tag-tag-icon))))

      ;;; Functions to help productivity
      ;; Mark/unmark as deleted on notmuch-search-mode
      (define-key notmuch-search-mode-map "d" (lambda ()
                                                "toggle deleted tag for thread"
                                                (interactive)
                                                (if (member "deleted" (notmuch-search-get-tags))
                                                    (notmuch-search-tag '("-deleted"))
                                                  (notmuch-search-tag '("+deleted" "-inbox" "-unread")))))

      ;; Mark/unmark as deleted on notmuch-show-mode
      (define-key notmuch-show-mode-map "d" (lambda ()
                                              "toggle deleted tag for message"
                                              (interactive)
                                              (if (member "deleted" (notmuch-show-get-tags))
                                                  (notmuch-show-tag '("-deleted"))
                                                (notmuch-show-tag '("+deleted" "-inbox" "-unread")))))

      ;; Mark/unmark as unread on notmuch-search-mode
      (define-key notmuch-search-mode-map "!" (lambda ()
                                                "toggle unread tag for thread"
                                                (interactive)
                                                (if (member "unread" (notmuch-search-get-tags))
                                                    (notmuch-search-tag '("-unread"))
                                                  (notmuch-search-tag '("+unread")))))

      ;; Mark/unmark as archived on notmuch-search-mode
      (define-key notmuch-search-mode-map "a" (lambda ()
                                                "toggle archive"
                                                (interactive)
                                                (if (member "archive" (notmuch-search-get-tags))
                                                    (notmuch-search-tag '("-archive"))
                                                  (notmuch-search-tag '("+archive" "-inbox" "-unread")))))

      ;; Mark/unmark as archived on notmuch-show-mode
      (define-key notmuch-show-mode-map "a" (lambda ()
                                              "toggle archive"
                                              (interactive)
                                              (if (member "archive" (notmuch-show-get-tags))
                                                  (notmuch-show-tag '("-archive"))
                                                (notmuch-show-tag '("+archive" "-inbox" "-unread")))))

      ;; Show only unread messages on notmuch-search-mode
      (define-key notmuch-search-mode-map "u" (lambda ()
                                                "show only unread messages"
                                                (interactive)
                                                (notmuch-search-filter-by-tag "unread")))

      ))

  ;; My personal configuration
  (load "~/my-prj/dotfiles/init-notmuch.el" t)
  )


(defun my-notmuch/init-gnus-alias ()
  (use-package gnus-alias
    :init (add-hook 'message-setup-hook
                    'gnus-alias-determine-identity)
    :config (progn
              (setq notmuch/gnus-alias-identities
                    '(("home" nil
                       "Somebody Someone <somebody@someone.com>" ;; Sender address
                       nil                                       ;; Organization header
                       nil                                       ;; Extra headers
                       nil                                       ;; Extra body text
                       "~/.signature")))

              (setq gnus-alias-identity-alist
                    '(("personal" nil                      ;; does not refer to any other identity
                       "Rubens Souza <rubensts@gmail.com>" ;; sender address
                       nil                                 ;; organization header
                       nil                                 ;; extra headers
                       nil                                 ;; extra body text
                       ;;"~/.signature"
                       )
                      ("work" nil
                       "Rubens Souza <rubens.souza@2ndquadrant.it>"
                       "2ndQuadrant"
                       nil
                       nil
                       ;;"~/.signature.work"
                       )))

              ;; Use "work" identity by default
              (setq gnus-alias-default-identity "work")
              )))

(defun my-notmuch/ini-org-notmuch ()
  (use-package org-notmuch))

(defun my-notmuch/post-init-org ()
  (use-package org
    :config (progn
              (add-hook 'message-mode-hook 'turn-on-orgstruct)
              (add-hook 'message-mode-hook 'turn-on-orgstruct++)
              (add-hook 'message-mode-hook 'turn-on-orgtbl))))


;;; packages.el ends here
