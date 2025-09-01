;; Package hiauto

(setq am-todo-work-filename "~/media/src/org/work-inbox.org")


;; (defun ara/worktrees (repo)
;;   (let* ((command (format "git worktree list"))
;;          (output-buffer-name "*Git worktrees %s*" repo)
;;          (output-buffer (get-buffer-create output-buffer-name))
;;          (default-directory repo)
;;          )
;;     (call-process "git" nil )
;;     )
;;   )

(defun ara/worktree-list (repo)
  "List worktrees for REPO in a new scratch buffer."
  (interactive "D")
  (let* ((buf-name (format "*worktrees %s*" repo))
         (cur-buf (get-buffer buf-name))
         (buf (if cur-buf cur-buf (generate-new-buffer buf-name))))
    (switch-to-buffer buf)
    (make-local-variable 'buffer-read-only)
    (setq buffer-read-only t)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (cd repo)
      (call-process "git" nil buf nil "worktree" "list")
      (insert (make-string 80 ?-) "\n"))))

(provide 'hiauto)
;; hiauto.el ends here
