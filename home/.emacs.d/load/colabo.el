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

(provide 'colabo)
;;; colabo.el ends here


(defun list-worktree ()
  "Switch to a new scratch buffer."
  (interactive)
  (let ((buf (generate-new-buffer "*worktrees*")))
    (switch-to-buffer buf)
    (cd "~/src/genie")
    (call-process "git" nil buf nil "worktree" "list")))

(defalias 'worktree-list 'list-worktree)
