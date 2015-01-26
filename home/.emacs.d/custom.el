(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ack-and-a-half-executable "/usr/bin/ack-grep")
 '(ack-and-a-half-prompt-for-directory t)
 '(ack-and-a-half-use-ido t)
 '(auto-indent-delete-line-char-remove-extra-spaces t)
 '(auto-indent-kill-line-at-eol nil)
 '(auto-indent-kill-remove-extra-spaces t)
 '(auto-save-interval 20)
 '(auto-save-timeout 5)
 '(blink-cursor-mode t)
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes (quote ("0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(delete-selection-mode t)
 '(delete-trailing-lines nil)
 '(desktop-save-mode t)
 '(doc-view-continuous t)
 '(electric-indent-mode nil)
 '(electric-layout-mode nil)
 '(erc-autojoin-channels-alist (quote (("freenode.net" "#emacs"))))
 '(erc-log-channels-directory "~/.log")
 '(erc-log-insert-log-on-open t)
 '(erc-log-mode t)
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(erc-modules (quote (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
 '(erc-nick "sagittarian")
 '(erc-save-queries-on-quit nil)
 '(fci-rule-column 80)
 '(flex-isearch-auto (quote on-failed))
 '(focus-follows-mouse t)
 '(git-commit-confirm-commit nil)
 '(global-flex-isearch-mode t)
 '(global-undo-tree-mode nil)
 '(haskell-font-lock-symbols t)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)) t)
 '(htmlize-css-name-prefix "htmlize-")
 '(htmlize-output-type (quote css))
 '(ido-auto-merge-work-directories-length 0)
 '(ido-default-buffer-method (quote selected-window))
 '(ido-default-file-method (quote selected-window))
 '(ido-enable-flex-matching t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-virtual-buffers t)
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(js2-allow-keywords-as-property-names nil)
 '(js2-basic-offset 4)
 '(js2-bounce-indent-p nil)
 '(js2-concat-multiline-strings (quote eol))
 '(js2-highlight-external-variables nil)
 '(js2-highlight-level 3)
 '(linum-format " %7i ")
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(magit-diff-options (quote ("--patience" "-b")))
 '(magit-diff-refine-hunk t)
 '(magit-process-popup-time 1)
 '(magit-restore-window-configuration t)
 '(mouse-autoselect-window t)
 '(org-agenda-files nil)
 '(org-mode-hook (quote (er/add-org-mode-expansions #[nil "\300\301\302\303\304$\207" [org-add-hook change-major-mode-hook org-show-block-all append local] 5] #[nil "\300\301\302\303\304$\207" [org-add-hook change-major-mode-hook org-babel-show-result-all append local] 5] org-babel-result-hide-spec org-babel-hide-all-hashes wc-mode)))
 '(projectile-global-mode t)
 '(projectile-switch-project-action (quote projectile-dired))
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(python-shell-interpreter "ipython")
 '(python-shell-prompt-regexp "In \\[\\d+\\]: ")
 '(python-skeleton-autoinsert t)
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((indent-tabs-mode\. t))))
 '(save-place t nil (saveplace))
 '(save-place-file "~/.emacs.d/places")
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tab-width 4)
 '(text-mode-hook (quote (er/add-text-mode-expansions text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(track-eol t)
 '(tramp-default-method "ssh")
 '(undo-tree-auto-save-history t)
 '(uniquify-ask-about-buffer-names-p t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-min-dir-content 1)
 '(uniquify-strip-common-suffix t)
 '(wdired-allow-to-change-permissions t)
 '(wgrep-enable-key (kbd "C-c C-r"))
 '(words-include-escapes t)
 '(yas-global-mode t nil (yasnippet))
 '(yas-triggers-in-field t)
 '(yas-wrap-around-region t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

;;; custom.el ends here
