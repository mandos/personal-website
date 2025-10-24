;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((org-mode .
           ((eval .
                  (progn
                    (let ((dir (locate-dominating-file default-directory ".dir-locals.el")))
                          (when dir
                            (load-file (expand-file-name "emacs/helper.el" dir))
                            (add-hook 'before-save-hook #'my/set-or-update-org-lastmod-date nil t))))
                    ))))
