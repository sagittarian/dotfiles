;; graveyard for old code


;; Workaround the annoying warnings:
;;    Warning (mumamo-per-buffer-local-vars):
;;    Already 'permanent-local t: buffer-file-name
;; (when (equal emacs-major-version 24)
;;   (eval-after-load "mumamo"
;;     '(setq mumamo-per-buffer-local-vars
;;            (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

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

;; ;; Don't give me none of that C-x C-s nonsense, young man!
;; ;; Some ideas from the real-auto-save at
;; ;; http://www.litchie.net/programs/real-auto-save.el
;; ;; (defun full-auto-save ()
;; ;;   (interactive)
;; ;;   (message "full-auto-save")
;; ;;   (save-excursion
;; ;; 	(dolist (buf (buffer-list))
;; ;; 	  (set-buffer buf)
;; ;; 	  (if (and (buffer-file-name) (buffer-modified-p))
;; ;; 		  (basic-save-buffer)))))
;; (defun full-auto-save ()
;;   (interactive)
;;   ;;(message "full-auto-save-one-file")
;;   (save-excursion
;; 	  (if (and (buffer-file-name) (buffer-modified-p))
;; 		  (save-buffer))))
;; (add-hook 'auto-save-hook 'full-auto-save)

;; ;; smart-tabs-mode
;; (autoload 'smart-tabs-mode "smart-tabs-mode"
;;   "Intelligently indent with tabs, align with spaces!")
;; (autoload 'smart-tabs-mode-enable "smart-tabs-mode")
;; (autoload 'smart-tabs-advice "smart-tabs-mode")
;; (autoload 'smart-tabs-insinuate "smart-tabs-mode")
;; ;; smart tabs for javascript
;; (add-hook 'js2-mode-hook 'smart-tabs-mode-enable)
;; (smart-tabs-advice js2-indent-line js2-basic-offset)
;; ;; smart tabs for python
;; (add-hook 'python-mode-hook 'smart-tabs-mode-enable)
;; (smart-tabs-advice python-indent-line-1 python-indent)
;; (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
;; 					  'ruby 'nxml)

;; ;; modes
;; (autoload 'scss-mode "scss-mode")
;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;; (setq-default scss-compile-at-save nil)
;; (autoload 'sass-mode "sass-mode")
;; (add-to-list 'auto-mode-alist '("\\.sass\\'" . sass-mode))

;; ;; interactive name completion for describe-function,
;; ;; describe-variable, etc.
;; (icomplete-mode t)

;; ;; ido
;; (ido-mode t)
;; (defadvice ido-switch-buffer (before save-buffer-ido-switch-buffer
;; 									 activate)
;;   "Save the current buffer before switching to a new one"
;;   (full-auto-save))

;; ;; flx-ido
;; (flx-ido-mode 1)

;; jedi
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys t)                      ; optional
;; (setq jedi:complete-on-dot t)                 ; optional

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
;; (require 'smartparens-config)
;; (smartparens-global-mode t)
;; (smart)

;; multiple cursors
;; (add-to-list 'load-path "~/.emacs.d/multiple-cursors")
;; (require 'multiple-cursors)

;; keyfreq
;; (require 'keyfreq)
;; (keyfreq-mode 1)
;; (keyfreq-autosave-mode 1)

;; ace jump mode
;; (autoload 'ace-jump-mode "ace-jump-mode"
;;   "Emacs quick move minor mode" t)
;; (autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
;; (eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
