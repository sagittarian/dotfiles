;; run as an emacs server
(server-start)

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

;; org-trello
(require 'org-trello)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
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
		  (basic-save-buffer))))
(add-hook 'auto-save-hook 'full-auto-save)

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

;; automatically delete trailing whitespace on all lines when saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
