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

;;;;;;;;;;;;;;;;;;;;;;;;;;;; old keybindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; some things...
;; (global-set-key (kbd "C-o") 'other-window)
;; (global-set-key (kbd "C-+") 'other-window)

;; iy-go-to-char
;; (require 'iy-go-to-char)
;; (global-set-key (kbd "M-n") 'iy-go-to-char)
;; (global-set-key (kbd "M-p") 'iy-go-to-char-backward)

;; (global-set-key (kbd "C-x o") 'save-buffer-other-window)

;; Join the following line to this one
;; (global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

;; (global-set-key (kbd "C-* p") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-* n") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-* h") 'mc/mark-sgml-tag-pair)
;; (global-set-key (kbd "C-* w") 'mc/mark-all-dwim)
;; (global-set-key (kbd "C-* <mouse-1>") 'mc/add-cursor-on-click)

;; (global-set-key (kbd "C-c <SPC>") 'ace-jump-mode)

;; ;; smex
;; ;(global-set-key (kbd "M-x") 'smex)
;; (define-key (current-global-map)
;;   [remap execute-extended-command] 'smex)
;; (global-set-key (kbd "C-x M-x") 'smex-major-mode-commands)

;; trying flex-isearch
;; (global-set-key (kbd "C-s") 'isearch-forward-regexp)
;; (global-set-key (kbd "C-r") 'isearch-backward-regexp)
;; (global-set-key (kbd "C-M-s") 'isearch-forward)
;; (global-set-key (kbd "C-M-r") 'isearch-backward)

;; (bind-key "C-c f" (lambda () (interactive) (sp-beginning-of-sexp 2)) smartparens-mode-map)
;; (bind-key "C-c b" (lambda () (interactive) (sp-beginning-of-sexp -2)) smartparens-mode-map)

;; (global-set-key (kbd "C-M-<backspace>") 'sp-splice-sexp)

;;;; miscelaneous stuff collected from the internets to go through and
;;;; see if there's anything interesting there some time

;;;;;; source: https://github.com/steinn/emacs-prelude/blob/master/core/prelude-global-keybindings.el


;; ;; Font size
;; (global-set-key (kbd "C-+") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)

;; ;; Window switching. (C-x o goes to the next window)
;; (global-set-key (kbd "C-x O") (lambda ()
;;                                 (interactive)
;;                                 (other-window -1))) ;; back one

;; ;; Indentation help
;; (global-set-key (kbd "C-x ^") 'join-line)

;; ;; Start eshell or switch to it if it's active.
;; (global-set-key (kbd "C-x m") 'eshell)

;; ;; Start a new eshell even if one is active.
;; (global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; ;; Start a regular shell if you prefer that.
;; (global-set-key (kbd "C-x M-m") 'shell)

;; ;; If you want to be able to M-x without meta
;; (global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; ;; A complementary binding to the apropos-command (C-h a)
;; (define-key 'help-command "A" 'apropos)

;; (global-set-key (kbd "C-h C-f") 'find-function)
;; (global-set-key (kbd "C-h C-k") 'find-function-on-key)
;; (global-set-key (kbd "C-h C-v") 'find-variable)
;; (global-set-key (kbd "C-h C-l") 'find-library)

;; ;; a complement to the zap-to-char command, that doesn't eat up the target character
;; (autoload 'zap-up-to-char "misc" "Kill up to, but not including ARGth occurrence of CHAR.")
;; (global-set-key (kbd "M-Z") 'zap-up-to-char)

;; ;; Activate occur easily inside isearch
;; (define-key isearch-mode-map (kbd "C-o")
;;   (lambda () (interactive)
;;     (let ((case-fold-search isearch-case-fold-search))
;;       (occur (if isearch-regexp
;;                  isearch-string
;;                (regexp-quote isearch-string))))))

;; ;; toggle fringe visibility
;; (global-set-key (kbd "<f11>") 'fringe-mode)

;; ;; toggle menu-bar visibility
;; (global-set-key (kbd "<f12>") 'menu-bar-mode)

;; (global-set-key (kbd "C-x g") 'magit-status)
;; (global-set-key (kbd "C-c C-b") 'magit-blame-mode)

;; (global-set-key (kbd "C-=") 'er/expand-region)

;; (global-set-key (kbd "<f10>") 'toggle-debug-on-quit)

;; ;; make C-x C-x usable with transient-mark-mode
;; (define-key global-map
;;   [remap exchange-point-and-mark]
;;   'prelude-exchange-point-and-mark)

;; (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;; (global-set-key (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; (provide 'prelude-global-keybindings)

;; ;;; prelude-global-keybindings.el ends here
