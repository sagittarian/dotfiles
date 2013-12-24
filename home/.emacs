;; run as an emacs server
;; we're now starting the server in headless mode in .profile
;; (server-start)

;; look for files to load in ~/.emacs.d
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))

;; Set elnode not to use port 8000
(setq elnode-init-port 3000)

;; XXX need to set this to nil for non-healarium project files
(setq-default indent-tabs-mode t)

(setq x-select-enable-clipboard t
	  x-select-enable-primary t
	  save-interprogram-paste-before-kill t
	  apropos-do-all t
	  mouse-yank-at-point t
	  save-place-file (concat user-emacs-directory "places")
	  backup-directory-alist `(("." . ,(concat user-emacs-directory
											   "backups"))))

;; pending-delete-mode
(pending-delete-mode t)

;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (equal emacs-major-version 24)
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; wow mumamo has some serious issues
(when (and (equal emacs-major-version 23)
           (equal emacs-minor-version 3))
  (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
  ;; tramp-compat.el clobbers this variable!
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function)))

;; custom variables
(setq custom-file "~/.emacs.d/custom.el")
(add-hook 'after-init-hook (lambda () (load custom-file)))

(setq-default tab-width 4)
(setq-default sentence-end-double-space t)
(setq-default isearch-allow-scroll t)
(setq-default column-number-mode t)
(setq-default show-trailing-whitespace t)
(setq-default warning-minimum-level :error)

;; marmalade
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; undo-tree
(require 'undo-tree)
;; (global-undo-tree-mode) ;; undo-tree is throwing errors

;; expand-region
(add-to-list 'load-path "~/.emacs.d/expand-region")
(load "expand-region.el")
(global-set-key (kbd "C-=") 'er/expand-region)

;; Flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)

;; use org-mode for files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; org-trello
(require 'org-trello)
;;(add-to-list 'auto-mode-alist '("\\.trello.org$" . org-trello-mode))
(defun auto-org-trello-mode ()
  "Automatically enable org-trello-mode for files ending in .trello.org"
  (let ((fname (buffer-file-name)))
	(when (and fname (string-match "\\.trello\\.org$" fname))
	  (org-trello-mode t))))
;; (add-hook 'after-change-major-mode-hook 'auto-org-trello-mode)
;;; (print after-change-major-mode-hook)
;; (remove-hook 'after-change-major-mode-hook 'auto-org-trello-mode)

;; orgmode-mediawiki (export capability)
;; (require 'ox-mediawiki)

;;(load "sass-mode")
;;(load "scss-mode")

;; Don't give me none of that C-x C-s nonsense, young man!
;; Some ideas from the real-auto-save at
;; http://www.litchie.net/programs/real-auto-save.el
;; (defun full-auto-save ()
;;   (interactive)
;;   (message "full-auto-save")
;;   (save-excursion
;; 	(dolist (buf (buffer-list))
;; 	  (set-buffer buf)
;; 	  (if (and (buffer-file-name) (buffer-modified-p))
;; 		  (basic-save-buffer)))))
(defun full-auto-save ()
  (interactive)
  ;;(message "full-auto-save-one-file")
  (save-excursion
	  (if (and (buffer-file-name) (buffer-modified-p))
		  (save-buffer))))
(add-hook 'auto-save-hook 'full-auto-save)

(defun delete-trailing-whitespace-except-before-point (&optional start end)
  "Delete trailing whitespace between start and end, but leave it just before the point"
  (interactive "p")
  (unless (and (boundp 'yas-keymap) (member yas-keymap (current-active-maps)))
	(let ((save (when (and
					   (looking-at "\\s-*$")
					   (looking-back "\\s-+" (line-beginning-position) t))
				  (match-string 0))))
	  (delete-trailing-whitespace start end)
	  (when save (insert-before-markers save)))))
;; automatically delete trailing whitespace on all lines when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace-except-before-point)

;; iy-go-to-char
(require 'iy-go-to-char)
(global-set-key (kbd "M-n") 'iy-go-to-char)
(global-set-key (kbd "M-p") 'iy-go-to-char-backward)

;; ack-and-a-half
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; smart-tabs-mode
(autoload 'smart-tabs-mode "smart-tabs-mode"
  "Intelligently indent with tabs, align with spaces!")
(autoload 'smart-tabs-mode-enable "smart-tabs-mode")
(autoload 'smart-tabs-advice "smart-tabs-mode")
(autoload 'smart-tabs-insinuate "smart-tabs-mode")
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
					  'ruby 'nxml)

;; save the buffer when switching to another window
(defun save-buffer-other-window (count &optional all-frames)
  "Save the buffer before switching to another window"
  (interactive "p")
  (full-auto-save)
  (other-window count all-frames))
(global-set-key (kbd "C-x o") 'save-buffer-other-window)

;; (setq-default auto-save-visited-file-name t)
(setq-default auto-save-interval 100)
(setq-default auto-save-timeout 5)

;; modes
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq-default scss-compile-at-save nil)
(autoload 'sass-mode "sass-mode")
(add-to-list 'auto-mode-alist '("\\.sass\\'" . sass-mode))

(blink-cursor-mode)

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

;; interactive name completion for describe-function,
;; describe-variable, etc.
(icomplete-mode t)

;; use ibuffer to list buffers by default
(defalias 'list-buffers 'ibuffer)

;; ido
(require 'ido)
(ido-mode t)
(defadvice ido-switch-buffer (before save-buffer-ido-switch-buffer
									 activate)
  "Save the current buffer before switching to a new one"
  (full-auto-save))

;; flx-ido
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; projectile
;; the keymap prefix has to be set before we require 'projectile
(setq projectile-keymap-prefix (kbd "C-c C-p"))
(require 'projectile)

;; enable rebase-mode in magit
(require 'git-rebase-mode)

;; tramp
(require 'tramp)
;; (setq tramp-default-method "ssh")

;; yasnippets
;; (require 'yasnippet)
;; define these using customize:
;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
;; (yas-global-mode 1)
(eval-after-load "yasnippet"
  '(progn
	 (define-key yas-keymap (kbd "\e") 'yas-exit-snippet)
	 (define-key yas-keymap (kbd "C-n") 'yas-next-field-or-maybe-expand)
	 (define-key yas-keymap (kbd "C-p") 'yas-prev-field)))

;; quick and easy way to run magit-status
(global-set-key (kbd "C-M-g") 'magit-status)

(defun shell-command-as-kill (cmd)
  "Execute the given shell command and put its output into the kill ring"
  (interactive "MShell command: ")
  (let ((output (shell-command-to-string cmd)))
	(message output)
	(kill-new output)))
(global-set-key (kbd "C-M-&") 'shell-command-as-kill)

;; cycle through buffers
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)

;; quick command to commit changes in the current buffer
(defun commit-buffer (msg)
  "Commit the current state of the current buffer (using magit)."
  (interactive "MCommit message: ")
  (stage-buffer)
  (magit-run-git "commit" "-m" msg "--" (buffer-file-name))
  (message "committed %s" (buffer-file-name)))
(global-set-key (kbd "C-c s") 'commit-buffer)

(defun amend-buffer ()
  "Amend the last commit to include the current state of the current buffer (using magit)."
  (interactive)
  (stage-buffer)
  (magit-run-git "commit" "--amend" "--no-edit" "--" (buffer-file-name)))
;; XXX set this up to be run with commit-buffer above with prefix arg

;; quick command to stage the current file
(defun stage-buffer ()
  "Stage the current state of the current buffer (using magit)."
  (interactive)
  (full-auto-save)
  (magit-run-git "add" "--" (buffer-file-name))
  (message "staged %s" (buffer-file-name)))
(global-set-key (kbd "C-c a") 'stage-buffer)

;; quick command to commit all changes in the working tree
(defun commit-all-changes (msg)
  "Commit all changes in the working tree (i.e. git commit -a, using magit)."
  (interactive "MCommit message: ")
  (full-auto-save)
  (magit-run-git "commit" "-am" msg)
  (message "committed all changes in working tree"))
(global-set-key (kbd "C-c S") 'commit-all-changes)

;; date and time stamps
(defun insert-date ()
   (interactive)
   (insert (format-time-string "%Y-%m-%d")))
(global-set-key (kbd "C-c d") 'insert-date)

(defun insert-timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))
(global-set-key (kbd "C-c t") 'insert-timestamp)

;; source: https://github.com/magnars/.emacs.d/blob/master/defuns/lisp-defuns.el
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
(global-set-key (kbd "C-x M-e") 'eval-and-replace)

;; sometimes we want to know the full path of the current file
(global-set-key (kbd "C-c f")
				(lambda ()
				  (interactive)
				  (let ((fname (buffer-file-name)))
					(message fname)
					(kill-new fname))))

;; Join the following line to this one
;; (global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

;; wc-mode
(require 'wc-mode)

;; nxhtml mode
(load "nxhtml/autostart.el")
;; multiple major modes
(autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode))
			  auto-mode-alist))
(setq mumamo-background-colors nil)
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;; erc
;; (require 'erc)

;; wrap-region ;; superceded by smartparens
;; (wrap-region-global-mode t)
;; (wrap-region-add-wrappers '(("{% " " %}" "%" 'html-mode)
;; 							("{# " " #}" "#" 'html-mode)))

;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)

;; multiple cursors
(add-to-list 'load-path "~/.emacs.d/multiple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C-* p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-* n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-* h") 'mc/mark-sgml-tag-pair)
(global-set-key (kbd "C-* w") 'mc/mark-all-dwim)
(global-set-key (kbd "C-* <mouse-1>") 'mc/add-cursor-on-click)

;; keyfreq
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; ace jump mode
(autoload 'ace-jump-mode "ace-jump-mode"
  "Emacs quick move minor mode" t)
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))

;; some nice minor modes
(show-paren-mode)
;; (electric-pair-mode) ;; superceded by smartparens
(setq-default show-paren-style 'expression)

;; keybindings
(global-set-key (kbd "C-!") 'flycheck-next-error)
(global-set-key (kbd "C-M-!") 'flycheck-previous-error)
(global-set-key (kbd "C-c >") 'sgml-close-tag)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-`") 'bury-buffer)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; we like js2-mode
;; (add-hook 'after-init-hook
;; 		  '(lambda ()
;; 			 (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")

(require 'uniquify)
(require 'saveplace)

(provide '.emacs)
;;; .emacs ends here
