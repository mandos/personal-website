;;; helper.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Marek Maksimczyk
;;
;; Author: Marek Maksimczyk <marek.maksimczyk@mandos.net.pl>
;; Maintainer: Marek Maksimczyk <marek.maksimczyk@mandos.net.pl>
;; Created: października 24, 2025
;; Modified: października 24, 2025
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/mandos/helper
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defun my/set-or-update-org-lastmod-date ()
  "Set or update the #+lastmod: property in the current Org buffer."
  (save-excursion
    (goto-char (point-min))
    (if (re-search-forward "^#\\+lastmod:.*" nil t)
        (replace-match (format "#+lastmod: %s" (format-time-string "[%Y-%m-%d %H:%M]")))
      ;; Otherwise, insert at the end of the initial #+ lines
      ;; (let ((end-of-metadata (point-min)))
      (while (looking-at "^#\\+")
        (forward-line 1))
      (insert (format "#+lastmod: %s\n" (format-time-string "[%Y-%m-%d %H:%M]"))))))


;; (provide 'helper)
;;; helper.el ends here
