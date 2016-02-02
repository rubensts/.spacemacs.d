;;; packages.el --- rts-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: rubens <rubens@emilia>
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
;; added to `rts-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rts-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rts-org/pre-init-PACKAGE' and/or
;;   `rts-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rts-org-packages
  '(
    org
    (org-protocol :location built-in)
    ))

(defun rts-org/post-init-org ()

  ;; org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (calc . t)
     (clojure . t)
     (ditaa . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (latex . t)
     (ledger . t)
     (octave . t)
     (org . t)
     (makefile . t)
     (plantuml . t)
     (python . t)
     (R . t)
     (ruby . t)
     (sh . t)
     (sql . t)))

  ;; org-capture
  (setq org-default-notes-file (concat org-directory "/notes.org"))

  (setq org-capture-templates
        '(
          ("w" "Web bookmarks" entry
           (file+headline (concat org-directory "/www.org") "Bookmarks")
           "* %?%c %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%i\n" :empty-lines 1)

          ("t" "Tasks" entry
           (file+headline (concat org-directory "/tasks.org") "Tasks")
           "* ☛ TODO %^{Task} %^G\n %?\n %a" :clock-in t :clock-resume t)
          ;;"* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)

          ("j" "Journal" entry
           (file+datetree (concat org-directory "/journal.org"))
           "* %U %^{Title}\n %?%i\n %a")

          ("n" "Notes" entry
           (file+headline (concat org-directory "/notes.org") "Notes")
           "* %^{Header} %^G\n %u\n\n %?")))

  ;; General org settings
  (setq org-tags-column -80)

  ;; project management
  (setq org-todo-keywords
        '((sequence "☛ TODO(t)"
                    "|"
                    "✔ DONE(d)")
          (sequence "⚑ WAIT(w)"
                    "|")
          (sequence "|"
                    "✘ CANCEL(c)")))

  (setq org-todo-keyword-faces
        '(
          ("☛ TODO"  :foreground "#ff4500" :weight bold)
          ("✔ DONE"   :foreground "#00ff7f" :weight bold)
          ("⚑ WAIT"   :foreground "#ffff00" :weight bold)
          ("✘ CANCEL" :foreground "#00bfff" :weight bold)
          ))


  ;; Clocking work time
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  )

(defun rts-org/init-org-protocol ()
  (use-package org-protocol))


;;; packages.el ends here
