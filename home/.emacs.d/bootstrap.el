(setq package-list
      '(flx flx-ido flx-isearch yasnippet projectile magit
            git-timemachine wc-mode js2-mode js2-refactor
            ;; uniquify saveplace
            flycheck flycheck-ghcmod flycheck-haskell flymake-easy
            flymake-hlint flymake-jshint flymake-json flymake-yaml
            elpy smex smartparens sublime-themes expand-region
            yaml-mode ansible-doc ggtags jinja2-mode
            json-mode json-reformat
            pyvenv which-key))

;; some others
;; json-snatcher magit-annex matlab-mode multiple-cursors noxml-fold

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))