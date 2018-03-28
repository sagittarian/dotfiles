;;; Code:

(global-set-key (kbd "M-+") 'other-window)
(global-set-key (kbd "C-<return>") 'newline-and-indent)
(global-set-key (kbd "M-<return>") 'am-open-next-line)

;; print screen is where the menu key should be on my thinkpad
(global-set-key (kbd "<print>") 'execute-extended-command)

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; macro to make an anki cloze
(global-set-key (kbd "C-c c") 'make-cloze)

;; magit
(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g b") 'magit-blame)
(global-set-key (kbd "C-c g B") 'magit-blame-popup)
(global-set-key (kbd "C-c g t") 'git-timemachine)

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
(global-set-key (kbd "C-c w") 'current-buffer-file-name)

;; use my own function that saves the file when you switch windows
(define-key (current-global-map) [remap other-window] 'save-buffer-other-window)

;; flycheck
(global-set-key (kbd "C-!") 'flycheck-next-error)
(global-set-key (kbd "C-M-!") 'flycheck-previous-error)
(global-set-key (kbd "C-c >") 'sgml-close-tag)

;; misc
(global-set-key (kbd "<f11>") 'calendar)
(global-set-key (kbd "<f5>") 'revert-buffer)

(defun tabify-buffer ()
  (interactive)
  (message "tabify-buffer")
  (tabify (point-min) (point-max)))
;(global-set-key (kbd "<f6>") 'tabify-buffer)
(global-set-key (kbd "C-`") 'bury-buffer)
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)
(global-set-key (kbd "M-/") 'hippie-expand)

;; swiper
(global-set-key (kbd "C-S-s") 'swiper)
;; (global-set-key (kbd "C-s") 'swiper)


(global-set-key (kbd "C-c %") 'replace-string)
(global-set-key (kbd "C-c M-%") 'replace-regexp)
(global-set-key (kbd "C-x j") 'auto-fill-mode)

;; js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

(add-hook 'js2-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ci"
				'js-doc-insert-function-doc)
              (define-key js2-mode-map "@"
                'js-doc-insert-tag)
              (define-key js2-mode-map (kbd "C-c j f")
                'js-doc-insert-function-doc)
              (define-key js2-mode-map (kbd "C-c j p")
                'js-doc-insert-file-doc)
              (define-key js2-mode-map "@"
                'js-doc-insert-tag)
              (define-key js2-mode-map (kdb "C-c j h")
                'js-doc-describe-tag)))

;; ;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; ;; Start proced in a similar manner to dired
(global-set-key (kbd "C-x p") 'proced)

;; beeminder
(global-set-key (kbd "C-c b a") 'beeminder-add-data)
(global-set-key (kbd "C-c b w") 'beeminder-whoami)
(global-set-key (kbd "C-c b g") 'beeminder-my-goals-org)
(global-set-key (kbd "C-c b r") 'beeminder-refresh-goal)
(global-set-key (kbd "C-c b t") 'beeminder-submit-clocked-time)

;; smartparens
(define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)

(define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
(define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
(define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)

(define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)

(define-key smartparens-mode-map (kbd "C-M-n") 'sp-next-sexp)
(define-key smartparens-mode-map (kbd "C-M-p") 'sp-previous-sexp)

(define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

(define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
(define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key smartparens-mode-map (kbd "<C-S-right>") 'sp-slurp-hybrid-sexp)
(define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

(define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
(define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
(define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
(define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

(define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

(provide 'keybindings)
;;; keybindings ends here
