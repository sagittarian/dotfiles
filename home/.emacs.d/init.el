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

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))

(defvar ara/keymap (current-global-map))


(load "usepkg")

(use-package evil
  ;; :init
  ;; (setq evil-want-keybinding nil)
  :config
  ;; (require 'evil)
  (evil-mode 1)
  (evil-collection-init))
  ;; (evil-indent-plus-default-bindings))
;; (setq-default evil-normal-state-cursor 'box)
(setq-default evil-emacs-state-cursor 'hollow)

(defun ara/save-buffer-if-visiting-file ()
  (if (buffer-file-name (current-buffer)) (save-buffer)))

(add-hook 'evil-normal-state-entry-hook 'ara/save-buffer-if-visiting-file)
(add-hook 'evil-normal-state-exit-hook 'ara/save-buffer-if-visiting-file)

;; (setq-default evil-insert-state-cursor '(bar . 2))
;; lsp

;; (use-package lsp-mode
;;   ;; :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   ;; (setq lsp-keymap-prefix "C-c l")
;;   :hook (
;;          (python-mode . lsp)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp
;;   :after (python-mode))
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)


;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; if you are ivy user
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; scroll the buffer when moving up/down
(defvar ara/autoscroll-line-move t)
(defun ara/next-line-scroll-up (arg &optional try-vscroll)
  (if ara/autoscroll-line-move
      (let* ((line-min (line-number-at-pos (window-start)))
             (current-line (line-number-at-pos))
             (current-line-relative (- current-line line-min)))
        ;; (message "cur line %s tot lines %s" current-line-relative lines-in-window)
        (if (> current-line-relative 15)
            (scroll-up-line arg)))))
(defun ara/previous-line-scroll-down (arg &optional try-vscroll)
  (if ara/autoscroll-line-move (scroll-down-line arg)))
(advice-add 'next-line :after 'ara/next-line-scroll-up)
(advice-add 'previous-line :after 'ara/previous-line-scroll-down)

;; keyfreq
(require 'keyfreq)
;; (keyfreq-mode 1)
;; (keyfreq-autosave-mode 1)
;; keyfreq-excluded-commands is not a defcustom for some reason
(setq keyfreq-excluded-commands
      '(self-insert-command
        ;; forward-char
        ;; backward-char
        ;; previous-line
        ;; next-line

        ;; mwheel-scroll
        ;; handle-switch-frame
        org-self-insert-command
        ;; handle-select-window
        ;; mouse-set-point
        ;; mouse-drag-region
        ))

;; automatically delete trailing whitespace on all lines when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace-except-before-point)
(add-hook 'shell-mode-hook (lambda () (setq show-trailing-whitespace nil)))
;; (add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))

;; show the full path in the title bar
;; (setq frame-title-format
;;       (list (format "%s %%S: %%j " (system-name))
;; 			'(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

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
	 (define-key yas-keymap (kbd "C-p") 'yas-prev-field)
     (add-hook 'yas-after-exit-snippet-hook 'evil-normal-state)))

;; w3m
(require 'w3m)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; some nice minor modes
(show-paren-mode)
;; (setq-default show-paren-style 'expression)
;; (electric-pair-mode) ;; superceded by smartparens

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; menu bars
(menu-bar-mode 1)

;; beeminder
(load "beeminder")
(load "beeminder-config" t)

;; smex
(smex-initialize)

;; theme
;; (load-theme 'spolsky t nil)

;; magit-svn (why do people use sucky software, grumble grumble
;; grumble)
;; (add-hook 'magit-mode-hook 'magit-svn-mode)

;; git-gutter+
(global-git-gutter+-mode)
(require 'git-gutter-fringe+)
(git-gutter+-toggle-fringe)

;; fill-column-indicator
;; (add-hook 'text-mode-hook 'fci-mode)
;; (add-hook 'prog-mode-hook (lambda () (setq fill-column 80)))
;; (add-hook 'prog-mode-hook 'fci-mode)
;; (add-hook 'prog-mode-hook 'hs-minor-mode)

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
(add-hook 'prog-mode-hook 'idle-highlight-in-visible-buffers-mode)

(setq am-todo-filename "~/media/src/org/inbox.org")
(setq araizen/todo-lrn-filename "~/media/src/org/lrn.org")
(setq am-project-filename "~/media/src/org/projects.org")

(setq host-config (format "%s-config" (system-name)))

(message "Host config is %s" host-config)
(load host-config)

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/media/src/org/inbox.org" "Tasks")
         "* TODO %?\n  %i")
        ("l" "lrn todo" entry (file+headline "~/media/src/org/lrn.org" "Sort")
         "* TODO %?\n  %i")
        ("w" "work todo" entry (file+headline "~/media/src/org/work-inbox.org" "Tasks")
         "* TODO %?\n  %i")))

(require 'expand-region)
(require 'f)

;; make a shell script executable automatically on save
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; ;; god-mode
;; (require 'god-mode)
;; ;; (god-mode)
;; ;; (global-set-key (kbd "<escape>") 'god-local-mode)
;; ;; (global-unset-key (kbd "<escape>"))
;; ;; (global-set-key (kbd "C-c x") 'god-local-mode)
;; ;; (global-unset-key (kbd "C-c x"))
;; (define-key god-local-mode-map (kbd ".") 'repeat)
;; (define-key god-local-mode-map (kbd "i") 'god-local-mode)
;; (define-key god-local-mode-map (kbd "[") 'backward-paragraph)
;; (define-key god-local-mode-map (kbd "]") 'forward-paragraph)
;; (define-key god-local-mode-map (kbd "M-g") 'avyac-goto-line)
;; (defun god-mode-update-cursor-type ()
;;   "Update the cursor type depending on the active mode."
;;   (setq cursor-type (cond (god-local-mode 'hollow)
;;                           (buffer-read-only 'box)
;;                           (t 'bar))))
;; (add-hook 'post-command-hook 'god-mode-update-cursor-type)
;; (remove-hook 'post-command-hook 'god-mode-update-cursor-type nil)

(add-hook 'dired-mode-hook
          (lambda ()
            (display-line-numbers-mode 0)))

(eval-after-load "org"
  '(require 'ox-md nil t))
(require 'ox-md nil )
(require 'nxml-mode)
(add-hook 'nxml-mode-hook (lambda () (turn-off-smartparens-mode)))

(advice-add 'magit-stage-file :after (lambda (&rest r) (git-gutter+-refresh)))
(advice-add 'magit-unstage-file :after (lambda (&rest r) (git-gutter+-refresh)))

(which-function-mode)

(setq-default
 ara/headerline
 '("  " (which-func-mode ("" which-func-format " "))
   " "
   (:eval
    (let* ((home (getenv "HOME"))
           (replace-prefix
            (lambda (prefix replace str)
              (replace-regexp-in-string
               (concat "^" (regexp-quote prefix)) replace str)))
           (absolute-root (projectile-project-root))
           (root (and absolute-root
                      (funcall replace-prefix home "~" absolute-root)))
           (fname (if buffer-file-name
                      (if absolute-root
                          (funcall replace-prefix
                                   absolute-root "" buffer-file-name)
                        (funcall replace-prefix home "~" buffer-file-name))
                    nil)))
      (if root (if fname (concat fname " in " root) root) fname)))))
(make-variable-buffer-local 'ara/headerline)
(setq-default header-line-format '((t (:eval ara/headerline))))
(add-hook 'lsp-mode-hook (lambda () (setq ara/headerline (list ""))))

;; lsp wants these
(setq read-process-output-max (* 1024 64))
(setq gc-cons-threshold 6400000)

;; pre-commit tries to color its output, which looks bad in an emacs buffer
(setenv "PRE_COMMIT_COLOR" "never")

;; inserting an empty pair of parens isn't useful
(advice-add 'insert-parentheses :before
            (lambda (&optional arg)
              (interactive (list
                            (let ((arg (prefix-numeric-value current-prefix-arg)))
                              (if (= arg 0) 1 arg))))))


;; (setq mode-line-misc-info
;;             ;; We remove Which Function Mode from the mode line, because it's mostly
;;             ;; invisible here anyway.
;;             (assq-delete-all 'which-func-mode mode-line-misc-info))

;; all-the-icons
(add-hook 'dired-mode-hook
          (lambda () (all-the-icons-dired-mode)))
;; (all-the-icons-ibuffer-mode)

;; ace-window
(require 'ace-window)

(defvar ara/url-list
  '("https://news.google.com"
    "https://getpocket.com/explore"
    "https://astralcodexten.substack.com/"
    "https://pycoders.com/issues"
    "https://www.reddit.com/r/dailyprogrammer/"
    "https://weekly.statuscode.com/issues"
    "https://javascriptweekly.com/issues"
    "https://nodeweekly.com/issues"
    "https://golangweekly.com/issues"
    ))

(defun ara/goto-url (url)
  (interactive (list (completing-read "Go to url: " ara/url-list)))
  (w3m-goto-url-new-session url))

;; Enable narrow-to-* commands (disabled by default to avoid confusing users).
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)

(load "functions")
(load "keybindings")
;; (load "linum-off")

(setq org-todo-keywords '((sequence "TODO" "(*) TODO" "|" "DONE" "DELETED")))
;; bullet character: •

(server-start)
(message "Server started.")

(provide 'init)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; init ends here
