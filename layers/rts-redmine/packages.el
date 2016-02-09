;;; packages.el --- rts-redmine layer packages file for Spacemacs.
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
;; added to `rts-redmine-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rts-redmine/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rts-redmine/pre-init-PACKAGE' and/or
;;   `rts-redmine/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rts-redmine-packages
  '(org-redmine)
  )

(defun rts-redmine/init-org-redmine ()
  (use-package org-redmine
    :ensure t
    :config
    (progn
      (setq org-redmine-uri "https://redmine.2ndquadrant.it")
      (setq org-redmine-auth-netrc-use nil)))
  )

;;; packages.el ends here
