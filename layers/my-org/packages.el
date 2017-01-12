;;; packages.el --- my-org layer packages file for Spacemacs.
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
;; added to `my-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-org/pre-init-PACKAGE' and/or
;;   `my-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-org-packages
  '(org
    org-bullets
    (org-protocol :location built-in)
    ))

(defun my-org/post-init-org ()

  ;; org-clock - clocking work time
  (org-clock-persistence-insinuate)                ; resume clocking task when emacs is restarted
  (setq org-clock-persist t                        ; save all clock history when exiting Emacs, load it on startup
        org-clock-persist-query-resume nil         ; do not prompt to resume an active clock
        org-clock-history-length 10                ; show lot of clocking history from where choose items
        org-clock-in-resume t                      ; resume clocking task on clock-in if the clock is open
        org-clock-into-drawer "CLOCKING"           ; clocking goes into specfic drawer
        org-clock-report-include-clocking-task t)  ; include current clocking task in clock reports

  ;; org-agenda
  (setq org-agenda-files (list "todo.org"
                               "tasks.org"))

  ;; org-capture
  (setq org-default-notes-file (concat
                                org-directory "/notes.org"))

  (setq org-capture-templates
        '(("w" "Web bookmarks" entry
           (file+headline "www.org" "Bookmarks")
           "* %?%c %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n%i\n"
           :empty-lines 1
           :immediate-finish)

          ("t" "Tasks" entry
           (file+headline "tasks.org" "Tasks")
           "* ☛ TODO %^{Task} %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?%i"
           :empty-lines 1)

          ("n" "Notes" entry
           (file+headline "notes.org" "Notes")
           "* %^{Header} %^G\n %u\n %?")

          ("j" "Journal" entry
           (file+datetree "journal.org")
           "* %U %^{Title}\n %?%i\n %a")

          ("a" "Articles" entry
           (file+headline "articles.org" "Articles")
           "* %^{Title} %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?%i\n"
           :empty-lines 1
           :immediate-finish)

          ("r" "Redmine" entry
           (file+datetree "clockin.org")
           "* [[https://redmine.2ndquadrant.it/issues/%^{Ticket}][%^{Description}]] :redmine:%^g\n%?"
           :clock-in t
           :clock-keep t
           :empty-lines 1)

          ("s" "RT - Support" entry
           (file+datetree "clockin.org")
           "* [[https://support.2ndquadrant.com/rt/Ticket/Display.html?id=%^{Ticket}][%^{Description}]] :support:%^g\n%?"
           :clock-in t
           :clock-keep t
           :empty-lines 1)

          ("b" "RT - RDBA" entry
           (file+datetree "clockin.org")
           "* [[https://support.2ndquadrant.com/rt/Ticket/Display.html?id=%^{Ticket}][%^{Description}]] :rdba:%^g\n%?"
           :clock-in t
           :clock-keep t
           :empty-lines 1)
         ))

  ;; project management
  (setq org-todo-keywords
        '("☛ TODO(t)" "⚑ WAIT(w@)" "|" "✔ DONE(d)" "✘ CANCEL(c@)"))

  (setq org-todo-keyword-faces
        '(("☛ TODO"  :foreground "#ff4500" :weight bold)
          ("✔ DONE"   :foreground "#00ff7f" :weight bold)
          ("⚑ WAIT"   :foreground "#ffff00" :weight bold)
          ("✘ CANCEL" :foreground "#00bfff" :weight bold)
          ))

  ;; General org settings
  (setq org-tags-column 90                      ; column to which the tags have to be indented
        org-ellipsis "⤵"                        ; ⬎, ⤷, ⤵, ⚡
        org-fontify-whole-heading-line t        ; fontify the whole line for headings
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-startup-indented t
        org-hide-emphasis-markers t             ; hide markup elements, e.g. * *, / /, _ _
        org-cycle-include-plain-lists t
        org-list-allow-alphabetical t
        org-latex-create-formula-image-program 'imagemagick   ; preview latex fragments

        ;; Code blocks to play nicelly on org-babel
        org-edit-src-content-indentation 0      ; number of whitespaces added to the code block indentation (after #begin)
        org-src-tab-acts-natively t             ; TAB acts natively as it was in the language major mode
        org-src-preserve-indentation t          ; preserve indentation when exporting blocks
        org-src-fontify-natively t              ; highlights code-blocks natively
        org-src-window-setup 'current-window    ; open code-blocks in the current window
        org-confirm-babel-evaluate nil          ; don't ask for confirmation when compiling code-blocks
        )

  ;; org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((calc . t)
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
  )

(defun my-org/post-init-org-bullets ()
  (setq org-bullets-bullet-list
        '("☯" "☉" "∞" "◉" "⊚" "☀" "☾" "☥")))

(defun my-org/init-org-protocol ()
  (use-package org-protocol))


;;; packages.el ends here
