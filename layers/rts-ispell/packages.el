;;; packages.el --- rts-ispell layer packages file for Spacemacs.
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
;; added to `rts-ispell-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rts-ispell/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rts-ispell/pre-init-PACKAGE' and/or
;;   `rts-ispell/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rts-ispell-packages
  '(
    (flyspell)
    ))

  (defun rts-ispell/post-init-flyspell ()

    ;; General settings for ispell
    (setq-default ispell-program-name   "hunspell"
                  ispell-really-hunspell t
                  ispell-check-comments  t
                  ispell-extra-args      '("-i" "utf-8")
                  ispell-dictionary      "en_GB")

    (when (eq system-type 'darwin)
        (setenv "DICTIONARY" "en_GB"))

    ;; Switch between the most used dictionaries in my case
    (defun rts-switch-dictionary ()
      (interactive)
      (let* ((dic ispell-current-dictionary)
             (change (if (string= dic "en_GB") "it_IT" "en_GB")))
        (ispell-change-dictionary change)
        (message "Dictionary switched from %s to %s" dic change)))

    (global-set-key (kbd "<f8>")   'rts-switch-dictionary)
    )

;;; packages.el ends here
