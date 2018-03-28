(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ack-and-a-half-executable "/usr/bin/ack-grep")
 '(ack-and-a-half-prompt-for-directory t)
 '(ack-and-a-half-use-ido t)
 '(ag-arguments
   (quote
    ("--line-number" "--smart-case" "--nogroup" "--column" "--stats" "--ignore" "doc" "--ignore" "jsdoc" "--")))
 '(ag-group-matches nil)
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
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
 '(compilation-auto-jump-to-first-error nil)
 '(compilation-scroll-output (quote first-error))
 '(compilation-search-path nil)
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "7085ad716baf17384f10a5eb121a840a4c29da57e403e8bceff0ca65a6f83d61" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(delete-selection-mode t)
 '(delete-trailing-lines nil)
 '(desktop-save-mode t)
 '(doc-view-continuous t)
 '(electric-indent-mode t)
 '(electric-layout-mode nil)
 '(electric-pair-delete-adjacent-pairs nil)
 '(electric-pair-preserve-balance nil)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
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
 '(fill-column 72)
 '(flex-isearch-auto (quote on-failed))
 '(focus-follows-mouse t)
 '(git-commit-confirm-commit nil)
 '(global-flex-isearch-mode nil)
 '(global-linum-mode t)
 '(global-magit-file-mode t)
 '(global-undo-tree-mode nil)
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
 '(ido-auto-merge-work-directories-length 0)
 '(ido-default-buffer-method (quote selected-window))
 '(ido-default-file-method (quote selected-window))
 '(ido-enable-flex-matching t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-virtual-buffers t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(jedi:complete-on-dot t)
 '(js2-allow-keywords-as-property-names nil)
 '(js2-basic-offset 4)
 '(js2-bounce-indent-p t)
 '(js2-concat-multiline-strings (quote eol))
 '(js2-highlight-external-variables nil)
 '(js2-highlight-level 3)
 '(js2-strict-trailing-comma-warning nil)
 '(keyboard-coding-system (quote utf-8-unix))
 '(linum-format " %7i ")
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(magit-diff-arguments (quote ("--no-ext-diff" "-w")))
 '(magit-diff-options (quote ("--patience" "-b")))
 '(magit-diff-refine-hunk t)
 '(magit-diff-section-arguments (quote ("--no-ext-diff" "-w")))
 '(magit-process-popup-time 1)
 '(magit-restore-window-configuration t)
 '(makefile-mode-hook (quote ((lambda nil (set-variable (quote tab-width) 8)))))
 '(mouse-autoselect-window t)
 '(org-agenda-files nil)
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
 '(projectile-enable-caching t)
 '(projectile-global-mode t)
 '(projectile-mode t nil (projectile))
 '(projectile-sort-order (quote recently-active))
 '(projectile-switch-project-action (quote projectile-dired))
 '(projectile-use-git-grep t)
 '(python-indent-guess-indent-offset t)
 '(python-indent-offset 4)
 '(python-shell-interpreter "ipython")
 '(python-shell-prompt-regexp "In \\[\\d+\\]: ")
 '(python-skeleton-autoinsert t)
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((indent-tabs-mode\. t))))
 '(save-place t nil (saveplace))
 '(save-place-file "~/.emacs.d/places")
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(size-indication-mode t)
 '(smartparens-global-mode t)
 '(smartparens-global-strict-mode t)
 '(sp-autoescape-string-quote nil)
 '(sp-hybrid-kill-excessive-whitespace t)
 '(sp-successive-kill-preserve-whitespace 2)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(track-eol t)
 '(tramp-default-method "ssh")
 '(undo-tree-auto-save-history t)
 '(uniquify-ask-about-buffer-names-p t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-min-dir-content 1)
 '(uniquify-strip-common-suffix t)
 '(wc-modeline-format "WC[%tl,%tw,%tc]")
 '(wdired-allow-to-change-permissions t)
 '(wgrep-enable-key (kbd "C-c C-r"))
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
 '(default ((t (:background nil :family "Liberation Mono" :foundry "unknown" :slant normal :weight normal :height 83 :width normal)))))

;;; custom.el ends here
