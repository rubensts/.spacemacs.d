;;; packages.el --- my-org layer packages file for Spacemacs.
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

;; org-protocol intercepts calls from emacsclient to trigger
;; custom actions without external dependencies. Only one protocol
;; has to be configured with your external applications or the
;; operating system, to trigger an arbitrary number of custom
;; actions.
;; to use it to capture web urls and notes from Firefox, install
;; this Firefox plugin, http://chadok.info/firefox-org-capture/

;;; Code:

(defconst my-org-packages
  '(
    (org-protocol :location built-in)
    )
  )

(defun my-org/init-org-protocol ()
  (use-package org-protocol
    :config
    (progn
      (setq org-protocol-default-template-key "w")
      (setq org-capture-templates
            '(("w" "Web bookmarks"
               entry (file+headline "~/org/www.org" "Bookmarks")
               "* %u %?%c %^g\n %i")

              ("t" "TODO"
               entry (file+headline "~/org/tasks.org" "Tasks")
               "* TODO %^{Task}  %^G\n   %?\n  %a")

              ("j" "Journal"
               entry (file+datetree "~/org/journal.org")
               "* %U %^{Title}\n  %?%i\n  %a")

              ("n" "Notes"
               entry (file+headline "~/org/notes.org" "Notes")
               "* %^{Header}  %^G\n  %u\n\n  %?")))))
  )

;;; packages.el ends here
