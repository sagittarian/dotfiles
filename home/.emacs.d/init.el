;;; Code:

;; look for files to load in ~/.emacs.d/load
(add-to-list 'load-path (expand-file-name "~/.emacs.d/load/"))

;; custom variables
(setq custom-file "~/.emacs.d/custom.el")
(add-hook 'after-init-hook (lambda () (load custom-file)))

(require 'package)
;; marmalade
;; marmalade is less up to date, let's just not use it
;; (add-to-list 'package-archives
;;     '("marmalade" .
;;       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; automatically delete trailing whitespace on all lines when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace-except-before-point)

;; show the full path in the title bar
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
			'(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; macro for easily making anki clozes
(fset 'make-cloze
   (lambda (&optional arg)
	 "Turn the selection into an Anki cloze"
	 (interactive "p")
	 (kmacro-exec-ring-item
	  (quote ("{{c1::}}" 0 "%d")) arg)))

;; use ibuffer to list buffers by default
(defalias 'list-buffers 'ibuffer)

;; yasnippets
(eval-after-load "yasnippet"
  '(progn
	 (define-key yas-keymap (kbd "\e") 'yas-exit-snippet)
	 (define-key yas-keymap (kbd "C-n") 'yas-next-field-or-maybe-expand)
	 (define-key yas-keymap (kbd "C-p") 'yas-prev-field)))

;; w3m
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; some nice minor modes
(show-paren-mode)
(setq-default show-paren-style 'expression)
;; (electric-pair-mode) ;; superceded by smartparens

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; python stuff
(add-hook 'python-mode-hook (lambda () (set-variable 'tab-width 4)))
;; (add-hook 'python-mode-hook 'anaconda-mode)
(elpy-enable)

;; no menu bars
(menu-bar-mode 0)

;; beeminder
(load "beeminder")
(load "beeminder-config" t)

;; smex
(smex-initialize)

;; theme
(load-theme 'spolsky t nil)

;; magit-svn (why do people use sucky software, grumble grumble
;; grumble)
;; (add-hook 'magit-mode-hook 'magit-svn-mode)

;; fill-column-indicator
(add-hook 'text-mode-hook 'fci-mode)
(add-hook 'js2-mode-hook 'fci-mode)
(add-hook 'js-mode-hook 'fci-mode)
(add-hook 'python-mode-hook 'fci-mode)
(add-hook 'ruby-mode-hook 'fci-mode)
(add-hook 'haskell-mode-hook 'fci-mode)
(add-hook 'c-mode-hook 'fci-mode)

;; js-doc
(setq js-doc-mail-address "adam@mesha.org"
      js-doc-author (format "Adam Mesha <%s>" js-doc-mail-address)
      js-doc-url "http://www.mesha.org"
      js-doc-license "MIT")

;; enable winnow-mode globally
(add-hook 'compilation-mode-hook 'winnow-mode)

;; enable ivy mode globally
(ivy-mode 1)

(put 'set-goal-column 'disabled nil)

;; (add-hook 'ibuffer-hook
;;     (lambda ()
;;       (ibuffer-projectile-set-filter-groups)
;;       (unless (eq ibuffer-sorting-mode 'alphabetic)
;;         (ibuffer-do-sort-by-alphabetic))))


(load "functions")
(load "keybindings")


(provide 'init)
;;; init ends here
