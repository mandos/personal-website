;;; package --- publish
;;; Commentary:
;;; Generate html files from org documents

;;; Code:
(require 'ox-publish)
(setq org-publish-project-alist '(
                                  ("mandos.net.pl"
                                   :base-directory "./org"
                                   :base-extension "org"
                                   :publishing-directory "./jekyll"
                                   :recursive t
                                   :publishing-function org-html-publish-to-html
                                   :body-only t
                                   )))
(setq org-publish-timestamp-directory "./.org-publish-cache/")
;; NOTE: uncomment if you want regenerate full website
(org-publish-remove-all-timestamps)
(org-publish "mandos.net.pl")

;;; publish.el ends here
