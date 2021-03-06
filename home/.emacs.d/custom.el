(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-arguments
   (quote
    ("--line-number" "--smart-case" "--nogroup" "--column" "--stats" "--ignore" "doc" "--ignore" "jsdoc" "--hidden" "--")))
 '(ag-group-matches nil)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(apropos-do-all t)
 '(auto-coding-alist
   (quote
    (("\\.\\(arc\\|zip\\|lzh\\|lha\\|zoo\\|[jew]ar\\|xpi\\|rar\\|7z\\|ARC\\|ZIP\\|LZH\\|LHA\\|ZOO\\|[JEW]AR\\|XPI\\|RAR\\|7Z\\)\\'" . no-conversion-multibyte)
     ("\\.\\(exe\\|EXE\\)\\'" . no-conversion)
     ("\\.\\(sx[dmicw]\\|odt\\|tar\\|t[bg]z\\)\\'" . no-conversion)
     ("\\.\\(gz\\|Z\\|bz\\|bz2\\|xz\\|gpg\\)\\'" . no-conversion)
     ("\\.\\(jpe?g\\|png\\|gif\\|tiff?\\|p[bpgn]m\\)\\'" . no-conversion)
     ("\\.pdf\\'" . no-conversion)
     ("/#[^/]+#\\'" . utf-8-emacs-unix)
     ("\\.py" . utf-8-unix))))
 '(auto-indent-delete-line-char-remove-extra-spaces t)
 '(auto-indent-kill-line-at-eol nil)
 '(auto-indent-kill-remove-extra-spaces t)
 '(auto-save-interval 20)
 '(auto-save-timeout 5)
 '(avy-keys
   (quote
    (97 111 101 117 105 100 104 116 110 115 46 112 121 102 103 99 114)))
 '(browse-url-browser-function (quote w3m-browse-url))
 '(c-default-style
   (quote
    ((c-mode . "c")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(calendar-date-display-form (quote (calendar-iso-date-display-form)))
 '(calendar-date-style (quote iso))
 '(calendar-hebrew-all-holidays-flag t)
 '(calendar-latitude 32.1)
 '(calendar-location-name "Tel Aviv")
 '(calendar-longitude 34.8)
 '(calendar-view-holidays-initially-flag t)
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(company-show-numbers t)
 '(company-tooltip-align-annotations t)
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-scroll-output (quote first-error))
 '(compilation-search-path nil)
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (abyss)))
 '(custom-safe-themes
   (quote
    ("3b5ce826b9c9f455b7c4c8bff22c020779383a12f2f57bf2eb25139244bb7290" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "551596f9165514c617c99ad6ce13196d6e7caa7035cea92a0e143dbe7b28be0e" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "7085ad716baf17384f10a5eb121a840a4c29da57e403e8bceff0ca65a6f83d61" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(delete-selection-mode t)
 '(delete-trailing-lines nil)
 '(desktop-save-mode t)
 '(doc-view-continuous t)
 '(electric-indent-mode t)
 '(electric-layout-mode nil)
 '(electric-pair-delete-adjacent-pairs nil)
 '(electric-pair-preserve-balance nil)
 '(elpy-disable-backend-error-display t)
 '(elpy-mode-hook (quote (hl-line-mode)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-test-pytest-runner-command (quote ("pytest")))
 '(elpy-test-runner (quote elpy-test-pytest-runner))
 '(enable-recursive-minibuffers t)
 '(erc-autojoin-channels-alist (quote (("freenode.net" "#emacs"))))
 '(erc-log-channels-directory "~/.log")
 '(erc-log-insert-log-on-open t)
 '(erc-log-mode t)
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
 '(erc-nick "sagittarian")
 '(erc-save-queries-on-quit nil)
 '(fci-rule-color "#969896")
 '(fill-column 72)
 '(flex-isearch-auto (quote on-failed))
 '(flx-ido-mode nil)
 '(focus-follows-mouse t)
 '(git-commit-confirm-commit nil)
 '(git-gutter+-modified-sign "*")
 '(git-gutter+-unchanged-sign "=")
 '(global-annoying-arrows-mode t)
 '(global-flex-isearch-mode t)
 '(global-flycheck-mode t)
 '(global-git-gutter+-mode t)
 '(global-linum-mode t)
 '(global-smartscan-mode t)
 '(global-undo-tree-mode t)
 '(haskell-font-lock-symbols t)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)) t)
 '(hippie-expand-try-functions-list
   (quote
    (try-complete-file-name-partially try-complete-file-name try-expand-all-abbrevs try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol try-expand-line try-expand-list)))
 '(holiday-bahai-holidays nil)
 '(holiday-general-holidays
   (quote
    ((holiday-fixed 1 1 "New Year's Day")
     (holiday-fixed 2 14 "Valentine's Day")
     (holiday-fixed 4 1 "April Fools' Day")
     (holiday-float 5 0 2 "Mother's Day")
     (holiday-float 6 0 3 "Father's Day")
     (holiday-fixed 10 31 "Samhain/Halloween")
     (holiday-float 11 4 4 "Thanksgiving"))))
 '(holiday-hebrew-holidays
   (quote
    ((holiday-hebrew-passover t)
     (holiday-hebrew-rosh-hashanah t)
     (holiday-hebrew-hanukkah t)
     (holiday-hebrew 11 15 "Tu B'Shevat")
     (if calendar-hebrew-all-holidays-flag
         (append
          (holiday-hebrew-tisha-b-av)
          (holiday-hebrew-misc))))))
 '(holiday-islamic-holidays nil)
 '(holiday-other-holidays
   (quote
    ((holiday-fixed 2 1 "Imbolc")
     (holiday-fixed 5 1 "Beltaine")
     (holiday-fixed 8 1 "Lughnasadh")
     (holiday-fixed 11 1 "Samhain"))))
 '(htmlize-css-name-prefix "htmlize-")
 '(htmlize-output-type (quote css))
 '(idle-highlight-idle-time 0.1)
 '(ido-auto-merge-work-directories-length -1)
 '(ido-default-buffer-method (quote selected-window))
 '(ido-default-file-method (quote selected-window))
 '(ido-enable-flex-matching t)
 '(ido-use-faces nil)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-virtual-buffers t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-height 15)
 '(ivy-mode t)
 '(ivy-use-virtual-buffers t)
 '(ivy-wrap t)
 '(jedi:complete-on-dot t)
 '(js-indent-level 4)
 '(js2-allow-keywords-as-property-names nil)
 '(js2-bounce-indent-p t)
 '(js2-concat-multiline-strings (quote eol))
 '(js2-highlight-external-variables nil)
 '(js2-highlight-level 3)
 '(js2-strict-trailing-comma-warning nil)
 '(keyboard-coding-system (quote utf-8-unix))
 '(kill-do-not-save-duplicates t)
 '(kill-read-only-ok t)
 '(line-number-mode t)
 '(linum-format " %7i ")
 '(magit-completing-read-function (quote ivy-completing-read))
 '(magit-diff-arguments (quote ("--no-ext-diff" "-w")))
 '(magit-diff-options (quote ("--patience" "-b")))
 '(magit-diff-refine-hunk t)
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(magit-process-popup-time 1)
 '(magit-restore-window-configuration t)
 '(makefile-mode-hook (quote ((lambda nil (set-variable (quote tab-width) 8)))))
 '(mouse-autoselect-window t)
 '(mouse-yank-at-point t)
 '(nrepl-message-colors
   (quote
    ("#183691" "#969896" "#a71d5d" "#969896" "#0086b3" "#795da3" "#a71d5d" "#969896")))
 '(org-agenda-files
   (quote
    ("~/src/org/inbox.org" "~/src/org/projects.org" "~/src/org/someday.org")))
 '(org-mode-hook
   (quote
    (er/add-org-mode-expansions
     #[nil "\300\301\302\303\304$\207"
           [org-add-hook change-major-mode-hook org-show-block-all append local]
           5]
     #[nil "\300\301\302\303\304$\207"
           [org-add-hook change-major-mode-hook org-babel-show-result-all append local]
           5]
     org-babel-result-hide-spec org-babel-hide-all-hashes wc-mode)))
 '(package-selected-packages
   (quote
    (w3m smartscan f traad git-gutter-fringe+ git-gutter+ string-inflection string-utils sql-indent format-sql dired-subtree groovy-mode pylint restclient-helm annoying-arrows-mode git-gutter-fringe all-the-icons-dired dired-sidebar ghub fish-mode markdown-mode github-theme abyss-theme js-doc git-timemachine org-jira undo-tree yaml-mode winnow which-key wc-mode swiper sublime-themes ssass-mode smex smartparens scss-mode projectile marcopolo magit js2-refactor jinja2-mode haml-mode ggtags flymake-yaml flymake-json flymake-jshint flymake-hlint flycheck-haskell flycheck-ghcmod fill-column-indicator expand-region dockerfile-mode docker-api docker ansible-doc ag)))
 '(pdf-view-midnight-colors (quote ("#969896" . "#f8eec7")))
 '(projectile-completion-system (quote ivy))
 '(projectile-enable-caching t)
 '(projectile-global-mode t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "worktrees" "node_modules")))
 '(projectile-mode t nil (projectile))
 '(projectile-sort-order (quote recently-active))
 '(projectile-switch-project-action (quote magit-status))
 '(projectile-use-git-grep t)
 '(python-indent-guess-indent-offset t)
 '(python-indent-offset 4)
 '(python-shell-prompt-regexp "In \\[\\d+\\]: ")
 '(python-skeleton-autoinsert t)
 '(pyvenv-mode t)
 '(pyvenv-virtualenvwrapper-python "/home/adam/local/bin/python3")
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((js-indent-level 2) (indent-tabs-mode\. t))))
 '(save-interprogram-paste-before-kill t)
 '(save-place t nil (saveplace))
 '(save-place-file "~/.emacs.d/places")
 '(select-enable-clipboard t)
 '(select-enable-primary t)
 '(sentence-end-double-space t)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(smartparens-global-mode t)
 '(smartparens-global-strict-mode nil)
 '(sp-autoescape-string-quote nil)
 '(sp-hybrid-kill-excessive-whitespace t)
 '(sp-successive-kill-preserve-whitespace 2)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(track-eol t)
 '(tramp-default-method "ssh" nil (tramp))
 '(undo-tree-auto-save-history t)
 '(uniquify-ask-about-buffer-names-p t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-min-dir-content 1)
 '(uniquify-strip-common-suffix t)
 '(vc-annotate-background "#b0cde7")
 '(vc-annotate-color-map
   (quote
    ((20 . "#969896")
     (40 . "#183691")
     (60 . "#969896")
     (80 . "#969896")
     (100 . "#969896")
     (120 . "#a71d5d")
     (140 . "#969896")
     (160 . "#969896")
     (180 . "#969896")
     (200 . "#969896")
     (220 . "#63a35c")
     (240 . "#0086b3")
     (260 . "#795da3")
     (280 . "#969896")
     (300 . "#0086b3")
     (320 . "#969896")
     (340 . "#a71d5d")
     (360 . "#969896"))))
 '(vc-annotate-very-old-color "#969896")
 '(w3m-fill-column 72)
 '(w3m-mode-hook (quote (bookmark-w3m-prepare visual-line-mode)))
 '(warning-minimum-level :error)
 '(wc-modeline-format "WC[%tl,%tw,%tc]")
 '(wdired-allow-to-change-permissions t)
 '(wgrep-enable-key (kbd "C-c C-r"))
 '(which-key-idle-delay 0.5)
 '(which-key-mode t)
 '(with-editor-emacsclient-executable "/usr/bin/emacsclient")
 '(words-include-escapes t)
 '(yas-global-mode t nil (yasnippet))
 '(yas-triggers-in-field t)
 '(yas-wrap-around-region t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "DAMA" :family "Ubuntu Mono"))))
 '(dired-subtree-depth-1-face ((t (:background "maroon"))))
 '(dired-subtree-depth-2-face ((t (:background "forest green"))))
 '(dired-subtree-depth-3-face ((t (:background "royal blue"))))
 '(dired-subtree-depth-4-face ((t (:background "dim gray"))))
 '(dired-subtree-depth-5-face ((t (:background "indian red"))))
 '(dired-subtree-depth-6-face ((t (:background "sea green"))))
 '(git-gutter+-added ((t (:foreground "dark green" :weight bold))))
 '(linum ((t (:background "#EEEEEE" :foreground "#5a5a5a")))))

;;; custom.el ends here
