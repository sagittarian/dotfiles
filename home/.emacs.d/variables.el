;; No splash screen
(setq inhibit-startup-screen t)

;; Set elnode not to use port 8000
;; (setq elnode-init-port 3000)

(setq x-select-enable-clipboard t
	  x-select-enable-primary t
	  save-interprogram-paste-before-kill t
	  apropos-do-all t
	  mouse-yank-at-point t
	  save-place-file (concat user-emacs-directory "places")
	  backup-directory-alist `(("." . ,(concat user-emacs-directory
											   "backups"))))

(setq-default tab-width 4)
(setq-default sentence-end-double-space t)
(setq-default isearch-allow-scroll t)
(setq-default column-number-mode t)
(setq-default show-trailing-whitespace t)
(setq-default warning-minimum-level :error)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)


