;;; packages.el --- rts-twittering layer packages file for Spacemacs.
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
;; added to `rts-twittering-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rts-twittering/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rts-twittering/pre-init-PACKAGE' and/or
;;   `rts-twittering/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rts-twittering-packages
  '(
    twittering-mode
    ))

(defun rts-twittering/init-twittering-mode ()
  (use-package twittering-mode
    :ensure t
    :config
    (progn
      (setq twittering-icon-mode t)
      ;; the default size is 48 which I find too large
      ;; this requires imagemagick to be installed
      (setq twittering-convert-fix-size 32)
      ;; This requires gzip. The icons are saved on ~/.twittering-mode-icons.gz,
      ;; which can be changed by the variable twittering-icon-storage-file
      (setq twittering-use-icon-storage t)
      ;; requires GnuPG to be installed
      (setq twittering-use-master-password t)))
    )


;;; packages.el ends here
