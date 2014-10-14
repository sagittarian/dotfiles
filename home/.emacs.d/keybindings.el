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
(global-set-key (kbd "C-x o") 'save-buffer-other-window)

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
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-c %") 'replace-string)
(global-set-key (kbd "C-c M-%") 'replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-x j") 'auto-fill-mode)

;; js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

(provide 'keybindings)
;;; keybindings ends here
