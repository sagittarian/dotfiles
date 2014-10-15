;; look for files to load in ~/.emacs.d
;; XXX this is not a great idea in general
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))

;; No splash screen
(setq inhibit-startup-screen t)

;; Set elnode not to use port 8000
(setq elnode-init-port 3000)

(setq x-select-enable-clipboard t
	  x-select-enable-primary t
	  save-interprogram-paste-before-kill t
	  apropos-do-all t
	  mouse-yank-at-point t
	  save-place-file (concat user-emacs-directory "places")
	  backup-directory-alist `(("." . ,(concat user-emacs-directory
											   "backups"))))

;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
(when (equal emacs-major-version 24)
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; wow mumamo has some serious issues
;; (when (and (equal emacs-major-version 23)
;;            (equal emacs-minor-version 3))
;;   (eval-after-load "bytecomp"
;;     '(add-to-list 'byte-compile-not-obsolete-vars
;;                   'font-lock-beginning-of-syntax-function))
;;   ;; tramp-compat.el clobbers this variable!
;;   (eval-after-load "tramp-compat"
;;     '(add-to-list 'byte-compile-not-obsolete-vars
;;                   'font-lock-beginning-of-syntax-function)))

;; custom variables
(setq custom-file "~/.emacs.d/custom.el")
(add-hook 'after-init-hook (lambda () (load custom-file)))

(setq-default tab-width 4)
(setq-default sentence-end-double-space t)
(setq-default isearch-allow-scroll t)
(setq-default column-number-mode t)
(setq-default show-trailing-whitespace t)
(setq-default warning-minimum-level :error)

(require 'package)
;; marmalade
;; marmalade is less up to date, let's just not use it
;; (add-to-list 'package-archives
;;     '("marmalade" .
;;       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; undo-tree
;; (require 'undo-tree)
;; (global-undo-tree-mode) ;; undo-tree is throwing errors

;; expand-region
(add-to-list 'load-path "~/.emacs.d/expand-region")
(load "expand-region.el")

;; Flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)

;; use org-mode for files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; org-trello
;; (require 'org-trello)
;;(add-to-list 'auto-mode-alist '("\\.trello.org$" . org-trello-mode))
;; (defun auto-org-trello-mode ()
;;   "Automatically enable org-trello-mode for files ending in .trello.org"
;;   (let ((fname (buffer-file-name)))
;; 	(when (and fname (string-match "\\.trello\\.org$" fname))
;; 	  (org-trello-mode t))))
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
;; smart tabs for javascript
(add-hook 'js2-mode-hook 'smart-tabs-mode-enable)
(smart-tabs-advice js2-indent-line js2-basic-offset)
;; smart tabs for python
(add-hook 'python-mode-hook 'smart-tabs-mode-enable)
(smart-tabs-advice python-indent-line-1 python-indent)

(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
					  'ruby 'nxml)



;; save the buffer when switching to another window
(defun save-buffer-other-window (count &optional all-frames)
  "Save the buffer before switching to another window"
  (interactive "p")
  (full-auto-save)
  (other-window count all-frames))

;; (setq-default auto-save-visited-file-name t)
;; (setq-default auto-save-interval 100)
;; (setq-default auto-save-timeout 5)

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

(require 'magit)

(defun shell-command-as-kill (cmd)
  "Execute the given shell command and put its output into the kill ring"
  (interactive "MShell command: ")
  (let ((output (shell-command-to-string cmd)))
	(message output)
	(kill-new output)))

;; quick command to commit changes in the current buffer
(defun commit-buffer (msg)
  "Commit the current state of the current buffer (using magit)."
  (interactive "MCommit message: ")
  (stage-buffer)
  (magit-run-git "commit" "-m" msg "--" (buffer-file-name))
  (message "committed %s" (buffer-file-name)))

(defun amend-buffer ()
  "Amend the last commit to include the current state of the current buffer (using magit)."
  (interactive)
  (stage-buffer)
  (magit-run-git "commit" "--amend" "--no-edit" "--" (buffer-file-name))
  (message "amended last commit for %s" (buffer-file-name)))

;; quick command to stage the current file
(defun stage-buffer ()
  "Stage the current state of the current buffer (using magit)."
  (interactive)
  (full-auto-save)
  (magit-run-git "add" "--" (buffer-file-name))
  (message "staged %s" (buffer-file-name)))

;; quick command to commit all changes in the working tree
(defun commit-all-changes (msg)
  "Commit all changes in the working tree (i.e. git commit -a, using magit)."
  (interactive "MCommit message: ")
  (full-auto-save)
  (magit-run-git "commit" "-am" msg)
  (message "committed all changes in working tree"))

;; date and time stamps
(defun insert-date ()
   (interactive)
   (insert (format-time-string "%Y-%m-%d")))

(defun insert-timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))

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

;; from emacswiki: http://www.emacswiki.org/emacs/MiniBuffer
(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

;; sometimes we want to know the full path of the current file
(defun current-buffer-file-name ()
  (interactive)
  (let ((fname (buffer-file-name)))
    (message fname)
    (kill-new fname)))

;; wc-mode
(require 'wc-mode)

;; ;; nxhtml mode
;; (load "nxhtml/autostart.el")
;; ;; multiple major modes
;; (autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
;; (setq auto-mode-alist
;;       (append '(("\\.html?$" . django-html-mumamo-mode))
;; 			  auto-mode-alist))
;; (setq mumamo-background-colors nil)
;; (add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

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

;; keyfreq
;; (require 'keyfreq)
;; (keyfreq-mode 1)
;; (keyfreq-autosave-mode 1)

;; ace jump mode
;; (autoload 'ace-jump-mode "ace-jump-mode"
;;   "Emacs quick move minor mode" t)
;; (autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
;; (eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))

;; w3m
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; some nice minor modes
(show-paren-mode)
;; (electric-pair-mode) ;; superceded by smartparens
(setq-default show-paren-style 'expression)

;; we like js2-mode
;; (add-hook 'after-init-hook
;; 		  '(lambda ()
;; 			 (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(require 'js2-refactor)

(require 'uniquify)
(require 'saveplace)

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (full-auto-save)
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (full-auto-save)
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil)
        t))))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(load "keybindings.el")

(provide 'init)
;;; init ends here
