;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; iy-go-to-char
;; (require 'iy-go-to-char)
;; (global-set-key (kbd "M-n") 'iy-go-to-char)
;; (global-set-key (kbd "M-p") 'iy-go-to-char-backward)

;; macro to make an anki cloze
(global-set-key (kbd "C-c c") 'make-cloze)

;; magit
;;(global-set-key (kbd "C-M-g") 'magit-status)
(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g b") 'magit-blame-mode)

;; custom commands
(global-set-key (kbd "C-M-&") 'shell-command-as-kill)
(global-set-key (kbd "C-c s") 'commit-buffer)
;; XXX set this up to be run with commit-buffer above with prefix arg
(global-set-key (kbd "C-c A") 'amend-buffer)
(global-set-key (kbd "C-c a") 'stage-buffer)
(global-set-key (kbd "C-c S") 'commit-all-changes)
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c t") 'insert-timestamp)
(global-set-key (kbd "C-c o") 'switch-to-minibuffer)
(global-set-key (kbd "C-x M-e") 'eval-and-replace)
(global-set-key (kbd "C-c f") 'current-buffer-file-name)

;; use my own function that saves the file when you switch windows
(define-key (current-global-map) [remap other-window] 'save-buffer-other-window)
;; (global-set-key (kbd "C-x o") 'save-buffer-other-window)

;; Join the following line to this one
;; (global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

(global-set-key (kbd "C-* p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-* n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-* h") 'mc/mark-sgml-tag-pair)
(global-set-key (kbd "C-* w") 'mc/mark-all-dwim)
(global-set-key (kbd "C-* <mouse-1>") 'mc/add-cursor-on-click)

;; (global-set-key (kbd "C-c <SPC>") 'ace-jump-mode)

;; flycheck
(global-set-key (kbd "C-!") 'flycheck-next-error)
(global-set-key (kbd "C-M-!") 'flycheck-previous-error)
(global-set-key (kbd "C-c >") 'sgml-close-tag)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-`") 'bury-buffer)
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)
(global-set-key (kbd "M-/") 'hippie-expand)

;; trying flex-isearch
;; (global-set-key (kbd "C-s") 'isearch-forward-regexp)
;; (global-set-key (kbd "C-r") 'isearch-backward-regexp)
;; (global-set-key (kbd "C-M-s") 'isearch-forward)
;; (global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-c %") 'replace-string)
(global-set-key (kbd "C-c M-%") 'replace-regexp)
(global-set-key (kbd "C-x j") 'auto-fill-mode)

;; js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

;; ;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; ;; Start proced in a similar manner to dired
(global-set-key (kbd "C-x p") 'proced)


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

;; ;; use hippie-expand instead of dabbrev
;; (global-set-key (kbd "M-/") 'hippie-expand)

;; ;; replace buffer-menu with ibuffer
;; (global-set-key (kbd "C-x C-b") 'ibuffer)

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



(provide 'keybindings)
;;; keybindings ends here
