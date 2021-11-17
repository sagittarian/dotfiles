;;; Code:

;; misc
(global-set-key (kbd "C-M-;") (lambda () (interactive) (back-to-indentation) (sp-comment)))
(global-set-key (kbd "C-S-g") 'keyboard-quit)
(define-key ivy-minibuffer-map (kbd "C-S-g") 'minibuffer-keyboard-quit)
(global-set-key (kbd "M-+") 'other-window)
(global-set-key (kbd "C-+") 'other-window)
(global-set-key (kbd "C-M-+")
                (lambda () (interactive)
                  (switch-to-buffer-other-window (current-buffer))))
(global-set-key (kbd "C-<return>") 'newline-and-indent)
;; (global-set-key (kbd "M-<return>") 'am-open-next-line)
(global-unset-key (kbd "M-<return>"))
(global-set-key (kbd "C-M-)") 'make-frame-command)
(global-set-key (kbd "s-;") 'delete-frame)
;; (global-set-key (kbd "C-M-}") 'split-window-right)

;; print screen is where the menu key should be on my thinkpad
(global-set-key (kbd "<print>") 'execute-extended-command)

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-9") 'er/contract-region)

(global-set-key (kbd "C-c C-M-SPC") 'mark-parens)

(global-set-key (kbd "C-c C-S-D") 'ara/duplicate-line-or-region)

;; macro to make an anki cloze
(global-set-key (kbd "C-c C") 'make-cloze)

;; alternative yasnippet expand key
(global-set-key (kbd "C-<tab>") 'yas-expand)

(global-set-key (kbd "C-c c") 'org-capture)

;; more discoverablitity from which-key
(global-set-key (kbd "C-c h") 'which-key-show-full-major-mode)
(global-set-key (kbd "C-c C-h") 'which-key-show-full-minor-mode-keymap)

;; elpy
(require 'elpy)
(define-key elpy-mode-map (kbd "C-.") 'xref-find-definitions-other-window)
(define-key elpy-mode-map (kbd "C-c i") 'pyimport-insert-missing)
;; what?
(define-key python-mode-map (kbd "C-<backspace>") 'backward-kill-word)

;; traad
(define-key elpy-mode-map (kbd "C-c r r") 'traad-rename)
(define-key elpy-mode-map (kbd "C-c r x") 'traad-extract-method)
(define-key elpy-mode-map (kbd "C-c r v") 'traad-extract-variable)
(define-key elpy-mode-map (kbd "C-c r f") 'traad-local-to-field)
(define-key elpy-mode-map (kbd "C-c r i") 'traad-organize-imports)

;; string-inflection
(global-set-key (kbd "C-c _") 'string-inflection-all-cycle)
(global-set-key (kbd "C-c C--") 'string-inflection-all-cycle)
(define-key python-mode-map (kbd "C-c C--") 'string-inflection-python-style-cycle)

;; magit
(require 'magit)
(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-M-g") 'magit-status)
(global-set-key (kbd "C-S-m") 'magit-status)
(global-set-key (kbd "C-c g b") 'magit-blame)
(global-set-key (kbd "C-c g B") 'magit-blame-popup)
(global-set-key (kbd "C-c g t") 'git-timemachine)
(define-key magit-status-mode-map (kbd "s-<return>") 'magit-diff-visit-file-other-window)
(global-set-key (kbd "C-g") 'keyboard-quit)

;; git-gutter+
(define-key git-gutter+-mode-map (kbd "C-c u n") 'git-gutter+-next-hunk)
(define-key git-gutter+-mode-map (kbd "C-c u p") 'git-gutter+-previous-hunk)
;; act on hunks
(define-key git-gutter+-mode-map (kbd "C-c u v =") 'git-gutter+-show-hunk)
(define-key git-gutter+-mode-map (kbd "C-c u r") 'git-gutter+-revert-hunks)
;; stage hunk at point
;; if region is active, stage all hunk lines within the region
(define-key git-gutter+-mode-map (kbd "C-c u s") 'git-gutter+-stage-hunks)
(define-key git-gutter+-mode-map (kbd "C-c u c") 'git-gutter+-commit)
(define-key git-gutter+-mode-map (kbd "C-c u C") 'git-gutter+-stage-and-commit)
(define-key git-gutter+-mode-map (kbd "C-c u C-y") 'git-gutter+-stage-and-commit-whole-buffer)
(define-key git-gutter+-mode-map (kbd "C-c u u") 'git-gutter+-unstage-whole-buffer)

;; custom commands
(global-set-key (kbd "C-M-&") 'shell-command-as-kill)
;; (global-set-key (kbd "C-c s") 'commit-buffer)
;; XXX set this up to be run with commit-buffer above with prefix arg
(global-set-key (kbd "C-c A") 'amend-buffer)
(global-set-key (kbd "C-c a") 'stage-buffer)
(global-set-key (kbd "C-c S") 'commit-all-changes)
(global-set-key (kbd "C-c D") 'insert-date)
(global-set-key (kbd "C-c T") 'insert-timestamp)
(global-set-key (kbd "C-c t") 'find-todo)
(global-set-key (kbd "C-c j") 'find-projects)
(global-set-key (kbd "C-c m") 'switch-to-minibuffer)
(global-set-key (kbd "C-x M-e") 'eval-and-replace)
(global-set-key (kbd "C-c w") 'current-buffer-file-name)

(global-set-key (kbd "C-c s") 'scratch-buffer)

;; use my own function that saves the file when you switch windows
(define-key (current-global-map) [remap other-window] 'save-buffer-other-window)

;; use avy-goto-line instead of goto-line
(define-key (current-global-map) [remap goto-line] 'avy-goto-line)

;; kill this buffer without confirmation
(define-key (current-global-map) [remap kill-buffer] (lambda () (interactive) (kill-buffer nil)))

;; avy
(avy-setup-default)
;; (global-set-key (kbd "C-'") 'avy-goto-char-timer)
(global-set-key (kbd "C-'") 'hydra-nav/avy-goto-char-timer)
(global-set-key (kbd "C-S-SPC") 'avy-goto-char-timer)
;; (global-set-key (kbd "C-;") 'avy-goto-word-1)
(global-set-key (kbd "C-;") 'hydra-nav/avy-goto-word-1)
(global-set-key (kbd "C-:") 'avy-goto-word-0)
;; (global-set-key (kbd "C-c SPC") 'avy-resume)
(global-set-key (kbd "C-c SPC") 'avy-goto-word-1)
(global-set-key (kbd "C-S-n") 'hydra-nav/body)

;; flycheck
(global-set-key (kbd "C-!") 'flycheck-next-error)
(global-set-key (kbd "C-M-!") 'flycheck-previous-error)
(global-set-key (kbd "C-c >") 'sgml-close-tag)

;; misc
(global-set-key (kbd "<f11>") 'calendar)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f12>") 'shell)
(global-set-key (kbd "S-<f12>") 'run-python)


(defun tabify-buffer ()
  (interactive)
  (message "tabify-buffer")
  (tabify (point-min) (point-max)))
;(global-set-key (kbd "<f6>") 'tabify-buffer)
(global-set-key (kbd "C-`") 'bury-buffer)
;; (global-set-key (kbd "<C-tab>") 'bury-buffer)
(global-set-key (kbd "M-/") 'hippie-expand)

;; swiper
;; (global-set-key (kbd "C-S-s") 'isearch-forward)
;; (global-set-key (kbd "C-s") 'swiper)
(define-key (current-global-map) [remap isearch-forward] 'swiper)


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
              (define-key js2-mode-map (kbd "C-c j h")
                'js-doc-describe-tag)))

;; ;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; ;; Start proced in a similar manner to dired
(global-set-key (kbd "C-x p") 'proced)

;; yasnippet
(global-set-key (kbd "C-<tab>") 'yas-expand)

;; beeminder
(global-set-key (kbd "C-c b a") 'beeminder-add-data)
(global-set-key (kbd "C-c b w") 'beeminder-whoami)
(global-set-key (kbd "C-c b g") 'beeminder-my-goals-org)
(global-set-key (kbd "C-c b r") 'beeminder-refresh-goal)
(global-set-key (kbd "C-c b t") 'beeminder-submit-clocked-time)

;; projectile shortcuts
(require 'projectile)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (define-key projectile-mode-map (kbd "C-S-f") 'projectile-find-file)
;; (define-key projectile-mode-map (kbd "C-M-S-f") 'projectile-find-file-other-window)
(defun ar--projectile-find-file-maybe-other-window (other-window)
  "Run projectile-find-file or projectile-find-file-other-window.

If OTHER-WINDOW is nil, run projectile-find-file-other-window,
otherwise projectile-find-file."
  (interactive "P")
  (if other-window
      (projectile-find-file-other-window)
    (projectile-find-file)))
(define-key projectile-mode-map (kbd "C-S-f") 'ar--projectile-find-file-maybe-other-window)
(define-key projectile-mode-map (kbd "C-S-b") 'projectile-switch-to-buffer)
(global-set-key (kbd "C-S-p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "C-S-s") 'projectile-ag)

;; dired-subtree

(define-key dired-mode-map (kbd "C-. i") 'dired-subtree-insert)
(define-key dired-mode-map (kbd "C-. r") 'dired-subtree-remove)
(define-key dired-mode-map (kbd "C-. t") 'dired-subtree-toggle)
(define-key dired-mode-map (kbd "\\") 'dired-subtree-toggle)
(define-key dired-mode-map (kbd "C-. c") 'dired-subtree-cycle)
(define-key dired-mode-map (kbd "C-. v") 'dired-subtree-revert)
(define-key dired-mode-map (kbd "C-. n") 'dired-subtree-narrow)
(define-key dired-mode-map (kbd "C-. u") 'dired-subtree-up)
(define-key dired-mode-map (kbd "C-. d") 'dired-subtree-down)
(define-key dired-mode-map (kbd "C-. n") 'dired-subtree-next-sibling)
(define-key dired-mode-map (kbd "C-. p") 'dired-subtree-previous-sibling)
(define-key dired-mode-map (kbd "C-. ^") 'dired-subtree-beginning)
(define-key dired-mode-map (kbd "C-. $") 'dired-subtree-end)
(define-key dired-mode-map (kbd "C-. m") 'dired-subtree-mark-subtree)
(define-key dired-mode-map (kbd "C-. <backspace>") 'dired-subtree-unmark-subtree)
(define-key dired-mode-map (kbd "C-. o f") 'dired-subtree-only-this-file)
(define-key dired-mode-map (kbd "C-. o d") 'dired-subtree-only-this-directory)

;; move lines
(defhydra hydra-move-text ()
  "move-text"
  ("p" move-text-up "move-text-up")
  ("n" move-text-down "move-text-down")
  ;; ("/" undo)
  ;; ("C-/" undo)
  ("RET" nil)
  ("q" nil))
(global-set-key (kbd "C-c M-p") 'hydra-move-text/move-text-up)
(global-set-key (kbd "C-c M-n") 'hydra-move-text/move-text-down)

(defhydra hydra-nav (global-map "C-c n")
  "nav"
  ("n" next-line)
  ;; ("k" next-line)
  ("p" previous-line)
  ;; ("j" previous-line)
  ("f" forward-char)
  ;; ("l" forward-char)
  ("F" forward-word)
  ("b" backward-char)
  ;; ("h" backward-char)
  ("B" backward-word)
  ("a" beginning-of-line)
  ("e" move-end-of-line)
  ("v" scroll-up-command)
  ("V" scroll-down-command)
  ("M-v" scroll-down-command)
  ("u" sp-backward-up-sexp)
  ("d" sp-down-sexp)
  ("l" recenter-top-bottom)
  ("<" beginning-of-buffer "top")
  (">" end-of-buffer "end")
  ("o" other-window "other-window")
  ("SPC" set-mark-command)
  ("=" er/expand-region "expand-region")
  ("9" er/contract-region "contract-region")
  ("x" exchange-point-and-mark)
  ;; ("j" ace-jump-word-mode "jump-word" :color blue)
  ;; ("c" ace-jump-char-mode "jump-char" :color blue)
  ;; ("g" ace-jump-line-mode "jump-line" :color blue)
  ("j" avy-goto-word-1)
  ("c" avy-goto-char-timer)
  ("g" avy-goto-line)
  ;; ("b" avy-goto-word-1-below)
  ("r" avy-resume)
  ("q" nil)
  ("ESC" nil))
;; (define-key (current-global-map) [remap next-line] 'hydra-nav/next-line)
;; (define-key (current-global-map) [remap previous-line] 'hydra-nav/previous-line)
;; (define-key (current-global-map) [remap forward-char] 'hydra-nav/forward-char)
;; (define-key (current-global-map) [remap backward-char] 'hydra-nav/backward-char)
;; (define-key (current-global-map) [remap next-line] 'next-line)
;; (define-key (current-global-map) [remap previous-line] 'previous-line)
;; (define-key (current-global-map) [remap forward-char] 'forward-char)
;; (define-key (current-global-map) [remap backward-char] 'backward-char)

(defhydra hydra-yank ()
  "yank"
  ("C-y" yank "yank")
  ("y" yank-pop "yank-pop")
  ("M-y" yank-pop "yank-pop")
  ("/" undo "undo")
  ("q" nil))
(define-key (current-global-map) [remap yank] 'hydra-yank/yank)
(define-key (current-global-map) [remap yank-pop] 'hydra-yank/yank-pop)

(defhydra hydra-window (global-map "C-c {")
  "window"
  ("{" shrink-window-horizontally)
  ("}" enlarge-window-horizontally)
  ("^" enlarge-window)
  ("v" shrink-window)
  ("+" balance-windows)
  ("=" balance-windows)
  ("o" other-window)
  ("0" delete-window "del")
  ("1" delete-other-windows "del-other")
  ("2" split-window-below "split-below")
  ("3" split-window-right "split-right"))


;; smartparens
;; (global-set-key (kbd "C-M-S-w") 'kill-sexp)
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
(define-key smartparens-mode-map (kbd "C-S-k") 'sp-kill-hybrid-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)

(define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
(define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

(define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
;; (define-key smartparens-mode-map (kbd "C-S-<right>") 'sp-slurp-hybrid-sexp)
(define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key smartparens-mode-map (kbd "C-M-S-f") 'sp-forward-barf-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

;; (define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
;; (define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
;; (define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)

(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
;; (define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

(define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

;; dired-sidebar
(global-set-key (kbd "C-c (") 'dired-sidebar-toggle-sidebar)

;; w3m
(define-key w3m-mode-map (kbd "C-,") 'w3m-tab-previous-buffer)
(define-key w3m-mode-map (kbd "C-.") 'w3m-tab-next-buffer)

;; XXX move these function definitions
(defun w3m-search-wikipedia (article)
  (interactive "MWikipedia search: ")
  (let ((url (format "https://en.wikipedia.org/w/index.php?title=Special:Search&search=%s" article)))
    (w3m-goto-url-new-session url)))

(defun w3m-python-module (module-name use-py2)
  (interactive "MPython module: \nP")
  (message (format "use-py2 is %s" use-py2))
  (let* ((py-version (if use-py2 "2" "3"))
         (url (format "https://docs.python.org/%s/library/%s.html" py-version module-name)))
    (w3m-goto-url-new-session url)))

(defun w3m-pypi-search (query)
  (interactive "MPyPI search query: ")
  (let ((url (format "https://pypi.org/search/?q=%s" query)))
    (w3m-goto-url-new-session url)))

(global-set-key (kbd "C-c C-c p") 'w3m-python-module)
(global-set-key (kbd "C-c C-c w") 'w3m-search-wikipedia)
(global-set-key (kbd "C-c C-c P") 'w3m-pypi-search)

(provide 'keybindings)
;;; keybindings ends here
