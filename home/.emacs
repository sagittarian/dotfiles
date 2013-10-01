;; run as an emacs server
;; we're now starting the server in headless mode in .profile
;; (server-start)

;; look for files to load in ~/.emacs.d
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))

;; Set elnode not to use port 8000
(setq elnode-init-port 3000)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-files nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default tab-width 4)
(setq-default sentence-end-double-space nil)
(setq-default isearch-allow-scroll t)
(setq-default column-number-mode t)
(setq-default show-trailing-whitespace t)

;; marmalade
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

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
(add-hook 'after-change-major-mode-hook 'auto-org-trello-mode)
;;; (print after-change-major-mode-hook)
(remove-hook 'after-change-major-mode-hook 'auto-org-trello-mode)

;;(load "sass-mode")
;;(load "scss-mode")

(require 'git-rebase-mode)

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
  (let ((save (when (and
					 (looking-at "\\s-*$")
					 (looking-back "\\s-+" (line-beginning-position) t))
                (match-string 0))))
    (delete-trailing-whitespace start end)
    (when save (insert-before-markers save))))

;; automatically delete trailing whitespace on all lines when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace-except-before-point)

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

;; interactive name completion for describe-function, describe-variable, etc.
(icomplete-mode t)

;; use ibuffer to list buffers by default
(defalias 'list-buffers 'ibuffer)

;; ido
(require 'ido)
(ido-mode t)
(setq-default ido-enable-flex-matching t)
(defadvice ido-switch-buffer (before save-buffer-ido-switch-buffer activate)
  "Save the current buffer before switching to a new one"
  (full-auto-save))

;; enable rebase-mode in magit
(require 'git-rebase-mode)


;; Join the following line to this one
;; (global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

;; nxhtml mode
(load "nxhtml/autostart.el")
;; multiple major modes
(autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil)
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))
(show-paren-mode)
(setq-default show-paren-style 'expression)

