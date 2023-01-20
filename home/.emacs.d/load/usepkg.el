;;; Commentary:
;; This file is a collection of use-package delarations

;; https://github.com/jwiegley/use-package

;;; Code:

(use-package python
  :config
  ;; (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'importmagic-mode)
  (add-hook 'python-mode-hook
            (lambda () (set-variable parens-require-spaces nil t)))
  (add-hook 'python-mode-hook
            (lambda nil (setq fill-column 95))))


;; (add-hook 'python-mode-hook (lambda () (set-variable 'tab-width 4)))
;; (elpy-enable)
(use-package elpy
  :ensure t
  :hook python-mode
  :init
  (elpy-enable))

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

(use-package swiper)

(use-package powerline
  :init
  (powerline-default-theme))

(use-package powerline-evil
  :after (powerline)
  :init
  ;; (powerline-evil-vim-color-theme)
  (powerline-evil-center-color-theme))


(use-package flycheck :init (global-flycheck-mode))

(use-package flycheck-pos-tip
  :after (flycheck)
  :init (flycheck-pos-tip-mode 1))

;; (use-package flycheck-grammarly
;;   :after (flycheck)
;;   :init (flycheck-grammarly-setup))

(use-package diminish
  :init
  (diminish 'hi-lock-mode)
  (diminish 'scroll-lock-mode)
  (diminish 'evil-collection-unimpaired-mode)
  (diminish 'which-key-mode)
  (diminish 'counsel-mode)
  (diminish 'ivy-mode)
  (diminish 'importmagic-mode "imp")
  (diminish 'auto-revert-mode)
  (diminish 'smartparens-mode)
  (diminish 'git-gutter+-mode)
  (diminish 'flycheck-mode))


(provide 'usepkg)
