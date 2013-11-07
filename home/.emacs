;; run as an emacs server
;; we're now starting the server in headless mode in .profile
;; (server-start)

;; look for files to load in ~/.emacs.d
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))

;; Set elnode not to use port 8000
(setq elnode-init-port 3000)

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
(load custom-file)

(setq-default tab-width 4)
(setq-default sentence-end-double-space nil)
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

(require 'js2-refactor)

;; expand-region
(load "expand-region/expand-region.el")
(global-set-key (kbd "C-=") 'er/expand-region)

;; Flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)

;; use org-mode for files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; we like js2-mode
(add-hook 'after-init-hook
		  '(lambda ()
			 (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))
;; (setq auto-mode-alist (cons '("\\.js$" . js2-mode) auto-mode-alist))

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
  (unless (member yas-keymap (current-active-maps))
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
(global-set-key (kbd "C-c m") 'iy-go-to-char)
(global-set-key (kbd "C-c M-m") 'iy-go-to-char-backward)

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

;; enable rebase-mode in magit
(require 'git-rebase-mode)

;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

;; yasnippets
(require 'yasnippet)
;; define these using customize:
;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
;; (yas-global-mode 1)
(define-key yas-keymap (kbd "\e") 'yas-exit-snippet)

;; quick and easy way to run magit-status
(global-set-key (kbd "C-M-g") 'magit-status)

;; cycle through buffers
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)

;; quick command to commit changes in the current buffer
(defun commit-buffer (msg)
  "Commit the current state of the current buffer (using magit)."
  (interactive "MCommit message: ")
  (stage-buffer)
  (magit-run-git "commit" "-m" msg "--" (buffer-file-name)))
(global-set-key (kbd "C-c s") 'commit-buffer)

;; quick command to stage the current file
(defun stage-buffer ()
  "Stage the current state of the current buffer (using magit)."
  (interactive)
  (full-auto-save)
  (magit-run-git "add" "--" (buffer-file-name)))
(global-set-key (kbd "C-c a") 'stage-buffer)

;; quick command to commit all changes in the working tree
(defun commit-all-changes (msg)
  "Commit all changes in the working tree (i.e. git commit -a, using magit)."
  (interactive "MCommit message: ")
  (full-auto-save)
  (magit-run-git "commit" "-am" msg))
(global-set-key (kbd "C-c S") 'commit-all-changes)


;; sometimes we want to know the full path of the current file
(global-set-key (kbd "C-c f")
				(lambda ()
				  (interactive)
				  (message (buffer-file-name))))

;; Join the following line to this one
;; (global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

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
(require 'erc)

;; some nice minor modes
(show-paren-mode)
(electric-pair-mode)
(setq-default show-paren-style 'expression)

;; keybindings
(global-set-key (kbd "C-!") 'flycheck-next-error)
(global-set-key (kbd "C-M-!") 'flycheck-previous-error)

(provide '.emacs)
;;; .emacs ends here
