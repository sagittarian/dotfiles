;;; Code:

(defun delete-trailing-whitespace-except-before-point (&optional start end)
  "Delete trailing whitespace between start and end, but leave it just before the point"
  (interactive "p")
  (unless (and (boundp 'yas-keymap) (member yas-keymap (current-active-maps)))
	(let ((save (when (and
					   (looking-at "\\s-*$")
					   (looking-back "\\s-+" (line-beginning-position) t))
				  (match-string 0))))
	  (delete-trailing-whitespace start end)
	  (when save (insert-before-markers save)))))

;; save the buffer when switching to another window
(defun save-buffer-other-window (count &optional all-frames)
  "Save the buffer before switching to another window"
  (interactive "p")
  (full-auto-save)
  (other-window count all-frames))

(defun shell-command-as-kill (cmd)
  "Execute the given shell command and put its output into the kill ring"
  (interactive "MShell command: ")
  (let ((output (shell-command-to-string cmd)))
	(message output)
	(kill-new output)))

;; quick command to commit changes in the current buffer
(defun commit-buffer (msg)
  "Commit the current state of the current buffer (using magit)."
  (interactive "MCommit message: ")
  (stage-buffer)
  (magit-run-git "commit" "-m" msg "--" (buffer-file-name))
  (message "committed %s" (buffer-file-name)))

(defun amend-buffer ()
  "Amend the last commit to include the current state of the current buffer (using magit)."
  (interactive)
  (stage-buffer)
  (magit-run-git "commit" "--amend" "--no-edit" "--" (buffer-file-name))
  (message "amended last commit for %s" (buffer-file-name)))

;; quick command to stage the current file
(defun stage-buffer ()
  "Stage the current state of the current buffer (using magit)."
  (interactive)
  (full-auto-save)
  (magit-run-git "add" "--" (buffer-file-name))
  (message "staged %s" (buffer-file-name)))

;; quick command to commit all changes in the working tree
(defun commit-all-changes (msg)
  "Commit all changes in the working tree (i.e. git commit -a, using magit)."
  (interactive "MCommit message: ")
  (full-auto-save)
  (magit-run-git "commit" "-am" msg)
  (message "committed all changes in working tree"))

;; date and time stamps
(defun insert-date ()
   (interactive)
   (insert (format-time-string "%Y-%m-%d")))

(defun insert-timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))

;; source: https://github.com/magnars/.emacs.d/blob/master/defuns/lisp-defuns.el
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;; from emacswiki: http://www.emacswiki.org/emacs/MiniBuffer
(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

;; sometimes we want to know the full path of the current file
(defun current-buffer-file-name ()
  (interactive)
  (let ((fname (buffer-file-name)))
    (kill-new (message fname))))

;; ;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
;; (defun rename-file-and-buffer (new-name)
;;   "Renames both current buffer and file it's visiting to NEW-NAME."
;;   (interactive "sNew name: ")
;;   (let ((name (buffer-name))
;;         (filename (buffer-file-name)))
;;     (if (not filename)
;;         (message "Buffer '%s' is not visiting a file!" name)
;;       (if (get-buffer new-name)
;;           (message "A buffer named '%s' already exists!" new-name)
;;         (progn
;;           (full-auto-save)
;;           (rename-file name new-name 1)
;;           (rename-buffer new-name)
;;           (set-visited-file-name new-name)
;;           (set-buffer-modified-p nil))))))

;; (defun move-buffer-file (dir)
;;   "Moves both current buffer and file it's visiting to DIR."
;;   (interactive "DNew directory: ")
;;   (let* ((name (buffer-name))
;;          (filename (buffer-file-name))
;;          (dir
;;           (if (string-match dir "\\(?:/\\|\\\\)$")
;;               (substring dir 0 -1) dir))
;;          (newname (concat dir "/" name)))
;;     (if (not filename)
;;         (message "Buffer '%s' is not visiting a file!" name)
;;       (progn
;;         (full-auto-save)
;;         (copy-file filename newname 1)
;;         (delete-file filename)
;;         (set-visited-file-name newname)
;;         (set-buffer-modified-p nil)
;;         t))))

;; pretty-json
(defun pretty-json ()
  (interactive)
  (mark-whole-buffer)
  (shell-command-on-region
   (region-beginning)
   (region-end)
   "python -mjson.tool" t t nil t))

;; open-next-line
;; modified from
;; https://www.emacswiki.org/emacs/OpenNextLine
(defun am-open-next-line (arg)
  "Move to the next line and then opens a line.
   See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (indent-according-to-mode))

(provide 'functions)
;;; functions.el ends here