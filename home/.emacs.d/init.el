;;; Code:

;; look for files to load in ~/.emacs.d/load
(add-to-list 'load-path (expand-file-name "~/.emacs.d/load/"))

;; custom variables
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(add-hook 'after-init-hook (lambda () (load custom-file)))

(require 'package)
;; marmalade
;; marmalade is less up to date, let's just not use it
;; (add-to-list 'package-archives
;;     '("marmalade" .
;;       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 27)
  ;; In emacs 27 package-initialize is called automatically between
  ;; early init and init
  (package-initialize))

;; automatically delete trailing whitespace on all lines when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace-except-before-point)

;; show the full path in the title bar
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
			'(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; macro for easily making anki clozes
;; (fset '-make-cloze-macro
;;    (lambda (&optional arg)
;; 	 "Turn the selection into an Anki cloze"
;; 	 (interactive "p")
;; 	 (kmacro-exec-ring-item
;; 	  (quote ("{{c1::}}" 0 "%d")) arg)))

(defun make-cloze (num)
  "Make cloze numbered NUM out of the current region."
  (interactive "p")
  (let* ((text (if (use-region-p)
                   (progn
                     (kill-region (point) (mark))
                     (car kill-ring-yank-pointer))
                 ""))
         (cloze (format "{{c%d::%s}}" num text)))
    (insert cloze)
    (goto-char (- (point) 2))))

;; use ibuffer to list buffers by default
(defalias 'list-buffers 'ibuffer)

;; yasnippets
(eval-after-load "yasnippet"
  '(progn
	 (define-key yas-keymap (kbd "\e") 'yas-exit-snippet)
	 (define-key yas-keymap (kbd "C-n") 'yas-next-field-or-maybe-expand)
	 (define-key yas-keymap (kbd "C-p") 'yas-prev-field)))

;; w3m
(require 'w3m)
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

;; git-gutter+
(global-git-gutter+-mode)
(require 'git-gutter-fringe+)
(git-gutter+-toggle-fringe)

;; fill-column-indicator
(add-hook 'text-mode-hook 'fci-mode)
(add-hook 'prog-mode-hook (lambda () (setq fill-column 79)))
(add-hook 'prog-mode-hook 'fci-mode)

;; (add-hook 'js2-mode-hook 'fci-mode)
;; (add-hook 'js-mode-hook 'fci-mode)
;; (add-hook 'python-mode-hook 'fci-mode)
;; (add-hook 'ruby-mode-hook 'fci-mode)
;; (add-hook 'haskell-mode-hook 'fci-mode)
;; (add-hook 'c-mode-hook 'fci-mode)
;; (add-hook 'emacs-lisp-mode-hook 'fci-mode)


;; js-doc
(setq js-doc-mail-address "adam@mesha.org"
      js-doc-author (format "Adam Raizen <%s>" js-doc-mail-address)
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

(move-text-default-bindings)

;; (global-git-gutter+-mode)
(git-gutter+-toggle-fringe)

(global-set-key (kbd "C-M-'") (lambda () (interactive) (insert "''") (backward-char)))
(global-set-key (kbd "C-M-\"") (lambda () (interactive) (insert "\"\"") (backward-char)))

(global-smartscan-mode 1)

(add-hook 'inferior-python-mode-hook (lambda () (smartscan-mode 0)))
(add-hook 'shell-mode-hook (lambda () (smartscan-mode 0)))
(add-hook 'python-mode-hook 'idle-highlight-mode)

(setq am-todo-filename "~/src/org/inbox.org")
(setq am-project-filename "~/src/org/projects.org")

(setq host-config (format "%s-config" (system-name)))

(message "Host config is %s" host-config)
(load host-config)

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/src/org/inbox.org" "Tasks")
         "* TODO %?\n  %i")
        ("l" "lrn todo" entry (file+headline "~/src/org/lrn.org" "Sort")
         "* TODO %?\n  %i")
        ("g" "work todo" entry (file+headline "~/src/genie/todo.org" "Tasks")
         "* TODO %?\n  %i")))

(require 'expand-region)
(require 'f)

(eval-after-load "org"
  '(require 'ox-md nil t))

(advice-add 'magit-stage-file :after (lambda (&rest r) (git-gutter+-refresh)))
(advice-add 'magit-unstage-file :after (lambda (&rest r) (git-gutter+-refresh)))

(which-function-mode)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))
                " "
                (:eval
                 (replace-regexp-in-string
                  ;; (getenv "HOME")
                  ;; "~"
                  (concat "^" (projectile-project-root))
                  ""
                  (or buffer-file-name "")))
                " in "
                (:eval (projectile-project-root))))



;; (setq mode-line-misc-info
;;             ;; We remove Which Function Mode from the mode line, because it's mostly
;;             ;; invisible here anyway.
;;             (assq-delete-all 'which-func-mode mode-line-misc-info))

;; all-the-icons
(add-hook 'dired-mode-hook
          (lambda () (all-the-icons-dired-mode)))
;; (all-the-icons-ibuffer-mode)

(load "functions")
(load "keybindings")
;; (load "linum-off")

(setq org-todo-keywords '((sequence "TODO" "(*) TODO" "|" "DONE" "DELETED")))
;; bullet character: •

;; (server-start)

(provide 'init)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; init ends here
