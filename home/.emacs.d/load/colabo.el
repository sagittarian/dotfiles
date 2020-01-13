(pyvenv-workon "buzzdev")

(setenv "PYTHONPATH"
        (concat
         "./email_reader_svc/src/python/genie_email_reader" path-separator
         "./carrier_svc/src/python/genie_carriers" path-separator
         "./history_svc/src/python/genie_history" path-separator
         "./test/src/python/genie_test/genie_test" path-separator
         "./oms_svc/src/python/genie_oms" path-separator
         "./src/python/pycase" path-separator
         "./src/python/genie" path-separator
         "/home/adam/python" path-separator
         (getenv "PYTHONPATH")))

(setq am-todo-filename "~/src/genie/todo.org")

(defun list-worktree ()
  "List all my worktrees in a new scratch buffer."
  (interactive)
  (let* ((buf-name "*worktrees*")
         (cur-buf (get-buffer buf-name))
         (buf (if cur-buf cur-buf (generate-new-buffer buf-name))))
    (switch-to-buffer buf)
    (make-local-variable 'buffer-read-only)
    (setq buffer-read-only t)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (dolist (path '("~/src/genie" "~/src/buzz"))
        (cd path)
        (call-process "git" nil buf nil "worktree" "list")
        (insert (make-string 80 ?-) "\n")))))

(defalias 'worktree-list 'list-worktree)

(global-set-key (kbd "C-c l") 'list-worktree)

(provide 'colabo)
;;; colabo.el ends here
