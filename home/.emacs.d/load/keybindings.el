;;; Code:

;; execute-extended-command
(evil-define-key 'normal ara/keymap (kbd "SPC RET") 'execute-extended-command)
(evil-define-key 'normal ara/keymap (kbd "SPC TAB") 'execute-extended-command)
(evil-define-key 'normal ara/keymap (kbd "SPC SPC SPC") 'execute-extended-command)
;; print screen is where the menu key should be on my thinkpad
(define-key ara/keymap (kbd "<print>") 'execute-extended-command)

(define-key ara/keymap (kbd "C-M-;") 'comment-line)
(evil-define-key 'normal ara/keymap (kbd "SPC ;") 'comment-line)

;; Formatting
(define-key ara/keymap (kbd "C-<return>") 'newline-and-indent)
(define-key python-mode-map (kbd "C-c \\") 'python-black-partial-dwim)
(define-key python-mode-map (kbd "C-c C-M-\\") 'python-black)
;; Align your code in a pretty way.
(define-key ara/keymap (kbd "C-x \\") 'align-regexp)

;; golang
;; python utilities
(evil-define-key 'normal python-mode-map (kbd "SPC \\ b") 'python-black-partial-dwim)
(evil-define-key 'visual python-mode-map (kbd "SPC \\ b") 'python-black-partial-dwim)
(evil-define-key 'normal python-mode-map (kbd "SPC \\ B") 'python-black-buffer)
(evil-define-key 'normal python-mode-map (kbd "SPC \\ i") 'py-isort-buffer)

;; misc
;; Need to toggle importmagic-mode sometimes to get it to work
(evil-define-key 'normal ara/keymap (kbd "SPC M") 'importmagic-mode)
(define-key ara/keymap (kbd "C-c C-x C-c") 'save-buffers-kill-emacs)
(define-key ara/keymap (kbd "C-S-g") 'keyboard-quit)
(define-key ivy-minibuffer-map (kbd "C-S-g") 'minibuffer-keyboard-quit)
(define-key ara/keymap (kbd "M-+") 'other-window)
(define-key ara/keymap (kbd "C-+") 'ace-window)
(define-key ara/keymap (kbd "C-M-+") 'ara/switch-to-current-buffer-other-window)
(evil-global-set-key 'normal (kbd "SPC +")
                     'ara/switch-to-current-buffer-other-window)
;; (define-key ara/keymap (kbd "M-<return>") 'am-open-next-line)
(define-key ara/keymap (kbd "C-M-)") 'make-frame-command)
(define-key ara/keymap (kbd "C-)") 'make-frame-command)
(evil-define-key 'normal ara/keymap (kbd "SPC )") 'make-frame-command)
(define-key ara/keymap (kbd "s-;") 'delete-frame)
;; (define-key ara/keymap (kbd "C-M-}") 'split-window-right)

;; expand region
(define-key ara/keymap (kbd "C-=") 'er/expand-region)
(define-key ara/keymap (kbd "C-9") 'er/contract-region)

(define-key ara/keymap (kbd "C-c C-M-SPC") 'mark-parens)

(define-key ara/keymap (kbd "C-c C-S-D") 'ara/duplicate-line-or-region)

;; macro to make an anki cloze
(define-key ara/keymap (kbd "C-c C") 'make-cloze)

;; yasnippet
;; alternative yasnippet expand key
;; (define-key ara/keymap (kbd "C-<tab>") 'yas-expand)
(define-key ara/keymap (kbd "C-c <tab>") 'yas-expand)
;; (global-unset-key (kbd "C-<tab>"))

(define-key ara/keymap (kbd "C-c c") 'org-capture)
(defhydra hydra-org-todo ()
  "Track todos"
  ("t" org-todo "next TODO state")
  ("C-t" org-todo "next TODO state")
  ("RET" nil)
  ("q" nil))
(define-key org-mode-map [remap org-todo] 'hydra-org-todo/org-todo)
(evil-define-key 'normal org-mode-map (kbd "SPC -") 'org-ctrl-c-minus)
(defun ara/org-add-item-below ()
  (interactive)
  (org-insert-heading-respect-content)
  (org-toggle-item nil)
  (evil-append-line nil))
(evil-define-key 'normal org-mode-map (kbd "SPC o RET") 'ara/org-add-item-below)
(defun ara/org-paste-item-below ()
  (interactive)
  (org-insert-heading-respect-content)
  (org-toggle-item nil)
  (evil-end-of-line)
  (evil-paste-after 1))
(evil-define-key 'normal org-mode-map (kbd "SPC o p") 'ara/org-paste-item-below)

;; more discoverablitity from which-key
(define-key ara/keymap (kbd "C-c h") 'which-key-show-full-major-mode)
(define-key ara/keymap (kbd "C-c C-h") 'which-key-show-full-minor-mode-keymap)

;; imenu
(define-key ara/keymap (kbd "C-x i") 'imenu)
(define-key ara/keymap (kbd "M-g i") 'ivy-imenu-anywhere)
;; (define-key ara/keymap (kbd "C-x i") 'insert-file)  ;; original keybinding for C-x i
(evil-define-key 'normal ara/keymap (kbd "SPC i") 'imenu)

;; elpy
(require 'elpy)
(define-key elpy-mode-map (kbd "C-.") 'xref-find-definitions-other-window)
(define-key elpy-mode-map (kbd "C-c i") 'pyimport-insert-missing)
;; what?
(define-key python-mode-map (kbd "C-<backspace>") 'backward-kill-word)
;; globally M-i is tab-to-tab-stop
(define-key python-mode-map (kbd "M-i") 'importmagic-fix-symbol-at-point)

;; traad
(define-key elpy-mode-map (kbd "C-c r r") 'traad-rename)
(define-key elpy-mode-map (kbd "C-c r x") 'traad-extract-method)
(define-key elpy-mode-map (kbd "C-c r v") 'traad-extract-variable)
(define-key elpy-mode-map (kbd "C-c r f") 'traad-local-to-field)
(define-key elpy-mode-map (kbd "C-c r i") 'traad-organize-imports)

;; evil
(require 'evil)
(define-key ara/keymap (kbd "C-c v") 'evil-mode)
(let ((evil-nonnormal-states
       (list 'insert 'visual 'operator 'replace 'motion)))
  (dolist (state evil-nonnormal-states)
                 (evil-global-set-key state (kbd "C-c [") 'evil-normal-state)
                 (evil-global-set-key state (kbd "C-S-n") 'evil-normal-state)
                 (evil-global-set-key state (kbd "C-n") 'evil-normal-state)
                 (evil-global-set-key state (kbd "C-*") 'evil-normal-state)))

(evil-global-set-key 'insert (kbd "C-_") 'evil-normal-state)
(evil-global-set-key 'insert (kbd "S-SPC") 'evil-normal-state)  ;; doesn't work
                                                                ;; on a terminal
(evil-global-set-key 'insert (kbd "M-RET") 'evil-normal-state)
(evil-global-set-key 'normal (kbd "g R") 'revert-buffer)
;; (evil-global-set-key 'insert (kbd "C-S-n") 'evil-normal-state)

(defun ara/evil-global-set-key-all-states
    (key def &optional exclude-states)
  (let* ((evil-states
          (list 'normal 'insert 'visual 'operator 'replace 'motion 'emacs))
         (states (cl-set-difference evil-states exclude-states)))
    (message "defining key %s as %s for states %s" key def states)
    (evil-define-key states 'global key def)))

(ara/evil-global-set-key-all-states (kbd "M-.") 'xref-find-definitions)
(ara/evil-global-set-key-all-states (kbd "M-*") 'xref-pop-marker-stack)

;; The following code was used to help me get used to evil mode.
;; (let ((keys
;;        (list
;;              ;; "C-n"
;;              "C-p"
;;              ;; "C-f" "C-b"
;;              "M-b" "M-f"
;;              ;; "C-v" "M-v"
;;              "<up>" "<down>" "<right>" "<left>"
;;              "M-<" "M->")))
;;   ;; C-a and C-e have evil keys in insert state
;;   (dolist (key keys)
;;     (ara/evil-global-set-key-all-states
;;      (kbd key) 'ara/evil-no-emacs-movement '(emacs))))


;; ;; Disable emacs motion keys in insert state to force me to get used to
;; ;; vim keys
;; (defun ara/evil-no-emacs-movement ()
;;   (interactive)
;;   (beep)
;;   (error "Don't use Emacs motion keys in evil mode"))


(require 'git-timemachine)
(defhydra hydra-git-timemachine (:foreign-keys run)
  "Time travel"
  ("j" git-timemachine-show-next-revision "next revision")
  ("C-j" git-timemachine-show-next-revision "next revision")
  ("k" git-timemachine-show-previous-revision "previous revision")
  ("C-k" git-timemachine-show-previous-revision "previous revision")
  ("RET" nil)
  ("q" nil))
(define-key git-timemachine-mode-map [remap git-timemachine-show-next-revision]
  'hydra-git-timemachine/git-timemachine-show-next-revision)
(define-key git-timemachine-mode-map [remap git-timemachine-show-previous-revision]
  'hydra-git-timemachine/git-timemachine-show-previous-revision)

;; swiper
(define-key (current-global-map) [remap isearch-forward] 'swiper)
(define-key (current-global-map) [remap isearch-forward-symbol-at-point]
  'swiper-isearch-thing-at-point)
(define-key swiper-map (kbd "C-r") 'ara/swiper-C-r)

;; string-inflection
(require 'string-inflection)
(defhydra hydra-string-inflection ()
  "string-inflection"
  ("-" string-inflection-cycle "string inflect")
  ("C--" string-inflection-cycle "string inflect")
  ("_" string-inflection-all-cycle "string inflect all")
  ("RET" nil)
  ("q" nil))
(define-key ara/keymap (kbd "C-c _")
                'hydra-string-inflection/string-inflection-all-cycle)
;; (define-key ara/keymap (kbd "C-c C--") 'string-inflection-all-cycle)
(define-key ara/keymap (kbd "C-c C--")
                'hydra-string-inflection/string-inflection-cycle)
(define-key ara/keymap (kbd "C-c -")
                'hydra-string-inflection/string-inflection-cycle)
;; (define-key python-mode-map (kbd "C-c C--")
;;   'string-inflection-python-style-cycle)
(define-key python-mode-map (kbd "C-c C--")
  'hydra-string-inflection/string-inflection-cycle)
(define-key python-mode-map (kbd "C-c C-_")
  'hydra-string-inflection/string-inflection-all-cycle)
(define-key python-mode-map (kbd "C-c _")
  'hydra-string-inflection/string-inflection-all-cycle)

;; help
(evil-define-key 'normal ara/keymap (kbd "SPC h") 'help-command)

;; magit
(require 'magit)
(define-key ara/keymap (kbd "C-c g g") 'magit-status-quick)
(define-key ara/keymap (kbd "C-x g") 'magit-status-quick)
(define-key ara/keymap (kbd "C-x G") 'magit-status)
;; (define-key ara/keymap (kbd "C-M-g") 'magit-status)
(define-key ara/keymap (kbd "C-S-m") 'magit-status)
(define-key ara/keymap (kbd "C-c g b") 'magit-blame)
(define-key ara/keymap (kbd "C-c g B") 'magit-blame-popup)
(define-key ara/keymap (kbd "C-c g t") 'git-timemachine)
(define-key magit-status-mode-map (kbd "S-<return>") 'magit-diff-visit-file-other-window)

;; git-gutter+
(defhydra hydra-git-gutter+ (git-gutter+-mode-map "C-c u")
  "git-gutter+"
  ("n" git-gutter+-next-hunk "next" :column "nav")
  ("j" git-gutter+-next-hunk "next")
  ("p" git-gutter+-previous-hunk "previous")
  ("k" git-gutter+-previous-hunk "previous")
  ("v" git-gutter+-show-hunk "show hunk" :column "view")
  ("r" (git-gutter+-refresh) "refresh")
  ("m" magit-status "magit status" :exit t)
  ("g" magit-status "magit status" :exit t)
  ("R" git-gutter+-revert-hunks "revert hunks" :column "edit")
  ("s" git-gutter+-stage-hunks "stage hunks" :column "stage/commit")
  ("+" (progn (git-gutter+-stage-hunks) (git-gutter+-next-hunk 1)) "stage and next")
  ("-" (progn (git-gutter+-stage-hunks) (git-gutter+-previous-hunk 1)) "stage and previous")
  ("S" (progn (ara/stage-buffer) (git-gutter+-refresh)) "stage buffer" :exit t)
  ("c" git-gutter+-commit "commit" :exit t)
  ("C" git-gutter+-stage-and-commit "stage and commit" :exit t)
  ("y" git-gutter+-stage-and-commit-whole-buffer "stage and commit buffer"
   :exit t)
  ("u" git-gutter+-unstage-whole-buffer "unstage buffer")
  ("RET" nil "quit" :column nil)
  ("q" nil "quit"))
(define-key git-gutter+-mode-map (kbd "C-c u") 'hydra-git-gutter+/body)


;; custom commands
(define-key ara/keymap (kbd "C-M-&") 'shell-command-as-kill)
;; (define-key ara/keymap (kbd "C-c s") 'commit-buffer)
;; XXX set this up to be run with commit-buffer above with prefix arg
(define-key ara/keymap (kbd "C-c A") 'amend-buffer)
(define-key ara/keymap (kbd "C-c a") 'stage-buffer)
(define-key ara/keymap (kbd "C-c S") 'commit-all-changes)
(define-key ara/keymap (kbd "C-c D") 'insert-date)
(define-key ara/keymap (kbd "C-c T") 'insert-timestamp)
(define-key ara/keymap (kbd "C-c t") 'find-todo)
(define-key ara/keymap (kbd "C-c j") 'find-projects)
(define-key ara/keymap (kbd "C-c m") 'switch-to-minibuffer)
(define-key ara/keymap (kbd "C-x M-e") 'eval-and-replace)
(define-key ara/keymap (kbd "C-c w") 'current-buffer-file-name)

(define-key ara/keymap (kbd "C-c s") 'scratch-buffer)

;; use my own function that saves the file when you switch windows
(define-key (current-global-map) [remap other-window] 'save-buffer-other-window)

;; use avy-goto-line instead of goto-line
(define-key (current-global-map) [remap goto-line] 'avy-goto-line)

;; kill this buffer without confirmation
(define-key (current-global-map) [remap kill-buffer] (lambda () (interactive) (kill-buffer nil)))

;; avy
(avy-setup-default)
;; (define-key ara/keymap (kbd "C-'") 'avy-goto-char-timer)
(define-key ara/keymap (kbd "C-'") 'hydra-nav/avy-goto-char-timer)
(define-key ara/keymap (kbd "C-S-SPC") 'avy-goto-char-timer)
;; (define-key ara/keymap (kbd "C-;") 'avy-goto-word-1)
(define-key ara/keymap (kbd "C-;") 'hydra-nav/avy-goto-word-1)
(define-key ara/keymap (kbd "C-:") 'avy-goto-word-0)
;; (define-key ara/keymap (kbd "C-c SPC") 'avy-resume)
(define-key ara/keymap (kbd "C-c SPC") 'avy-goto-word-1)
(define-key ara/keymap (kbd "C-S-n") 'hydra-nav/body)

;; flycheck
(define-key ara/keymap (kbd "C-!") 'flycheck-next-error)
(define-key ara/keymap (kbd "C-M-!") 'flycheck-previous-error)
(define-key ara/keymap (kbd "C-c >") 'sgml-close-tag)

;; misc
(define-key ara/keymap (kbd "<f11>") 'calendar)
(define-key ara/keymap (kbd "<f5>") 'revert-buffer)
(define-key ara/keymap (kbd "<f12>") 'shell)
(define-key ara/keymap (kbd "S-<f12>") 'run-python)


(defun tabify-buffer ()
  (interactive)
  (message "tabify-buffer")
  (tabify (point-min) (point-max)))
;(define-key ara/keymap (kbd "<f6>") 'tabify-buffer)
(define-key ara/keymap (kbd "C-`") 'bury-buffer)
;; (define-key ara/keymap (kbd "<C-tab>") 'bury-buffer)
(define-key ara/keymap (kbd "M-/") 'hippie-expand)

(define-key ara/keymap (kbd "C-c %") 'replace-string)
(define-key ara/keymap (kbd "C-c M-%") 'replace-regexp)
(define-key ara/keymap (kbd "C-x j") 'auto-fill-mode)

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
(define-key ara/keymap (kbd "C-x \\") 'align-regexp)

;; ;; Start proced in a similar manner to dired
(define-key ara/keymap (kbd "C-x p") 'proced)

;; yasnippet
(define-key ara/keymap (kbd "C-<tab>") 'yas-expand)

;; beeminder
(define-key ara/keymap (kbd "C-c b a") 'beeminder-add-data)
(define-key ara/keymap (kbd "C-c b w") 'beeminder-whoami)
(define-key ara/keymap (kbd "C-c b g") 'beeminder-my-goals-org)
(define-key ara/keymap (kbd "C-c b r") 'beeminder-refresh-goal)
(define-key ara/keymap (kbd "C-c b t") 'beeminder-submit-clocked-time)

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
(define-key ara/keymap (kbd "C-S-p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "C-S-s") 'projectile-ag)

;; dired-subtree

(define-key dired-mode-map (kbd "C-. i") 'dired-subtree-insert)
(define-key dired-mode-map (kbd "C-. r") 'dired-subtree-remove)
(define-key dired-mode-map (kbd "C-. t") 'dired-subtree-toggle)
(define-key dired-mode-map (kbd "\\") 'dired-subtree-toggle)
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle)
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
(define-key ara/keymap (kbd "C-c M-p") 'hydra-move-text/move-text-up)
(define-key ara/keymap (kbd "C-c M-n") 'hydra-move-text/move-text-down)

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
;; (define-key ara/keymap (kbd "C-M-S-w") 'kill-sexp)
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
(define-key ara/keymap (kbd "C-c (") 'dired-sidebar-toggle-sidebar)

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

(define-key ara/keymap (kbd "C-c C-c p") 'w3m-python-module)
(define-key ara/keymap (kbd "C-c C-c w") 'w3m-search-wikipedia)
(define-key ara/keymap (kbd "C-c C-c P") 'w3m-pypi-search)

(provide 'keybindings)
;;; keybindings ends here
