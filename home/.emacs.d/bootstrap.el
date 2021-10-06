(setq package-list
      '(;; flx
        ;; flx-ido
        ;; flx-isearch ;; seems broken
        yasnippet projectile magit
        ;; ido-completing-read+
        git-timemachine wc-mode js2-mode js2-refactor js-doc
        ;; uniquify saveplace
        flycheck flycheck-ghcmod flycheck-haskell flymake-easy
        flymake-hlint flymake-jshint flymake-json flymake-yaml
        elpy smex smartparens sublime-themes expand-region
        yaml-mode ansible-doc ggtags jinja2-mode
        json-mode json-reformat ag winnow swiper
        fill-column-indicator
        ;; undo-tree
        docker marcopolo dockerfile-mode docker-tramp docker-api
        ;; isearch+
        hydra move-text undo-tree git-ps1-mode
        avy ;; ace-jump-mode ace-jump-buffer ace-window
        dired-subtree
        ;; dired-sidebar
        ;; pylint
        ;; wiki-summary i3wm
        git-gutter+ git-gutter-fringe+
        traad
        string-inflection
        smartscan
        annoying-arrows-mode
        w3m
        pyimport
        markdown-mode
        use-package
        idle-highlight-in-visible-buffers-mode
        ;; format-all blacken elpygen importmagic indent-tools pygent
        ;; idle-highlight-mode
        pyvenv which-key))

;; some others
;; json-snatcher magit-annex matlab-mode multiple-cursors noxml-fold

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
