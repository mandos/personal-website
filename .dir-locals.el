((nil . (
     (org-publish-project-alist .
          (("mandos.net.pl"
               :base-directory "~/org/website/org"
               :base-extension "org"
               ;; Publish to jekyll
               :publishing-directory "~/org/website/jekyll"
               :recursive t
               :publishing-function org-html-publish-to-html
               :body-only t)))
     (org-publish-timestamp-directory . "~/org/website/.org-publish-cache/")
)))
