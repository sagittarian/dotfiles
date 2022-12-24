;;; Code:

(defun copy-symbol-at-point-as-kill ()
  (interactive)
  (kill-new (thing-at-point 'symbol)))

(defun view-json ()
  "Put the current region in a new `json-mode` buffer and beautify it."
  (interactive)
  (if mark-active
      (let ((buf (generate-new-buffer "*JSON*")))
        (copy-region-as-kill (region-beginning) (region-end))
        (set-buffer buf)
        (json-mode)
        (yank 1)
        (json-mode-beautify)
        (switch-to-buffer buf))
    (error "Mark is not active")))

(defun view-python ()
  "Put the current region in a new `python-mode` buffer and beautify it."
  (interactive)
  (if mark-active
      (let ((buf (generate-new-buffer "*Python*")))
        (copy-region-as-kill (region-beginning) (region-end))
        (set-buffer buf)
        (python-mode)
        (yank 1)
        (mark-whole-buffer)
        (shell-command-on-region (point-min) (point-max) "autopep8 -aaa -" buf t)
        (switch-to-buffer buf))
    (error "Mark is not active")))

(defun scratch-buffer ()
  "Switch to a new scratch buffer."
  (interactive)
  (switch-to-buffer (generate-new-buffer "*scratch*")))

(defun shell-new-buffer ()
  "Run shell in a new buffer."
  (interactive)
  (let* ((shellbuff (generate-new-buffer "*shell*")))
    (shell shellbuff)))

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

(defun full-auto-save ()
  (interactive)
  ;;(message "full-auto-save-one-file")
  (save-excursion
	  (if (and (buffer-file-name) (buffer-modified-p))
		  (save-buffer))))
(add-hook 'auto-save-hook 'full-auto-save)

;; save the buffer when switching to another window
(defun save-buffer-other-window (count &optional all-frames)
  "Save the buffer before switching to another window."
  (interactive "p")
  (full-auto-save)
  (other-window count all-frames))

(defun ara/switch-to-current-buffer-other-window ()
  "Switch to the current buffer in the other window."
  (interactive)
  (switch-to-buffer-other-window (current-buffer)))

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
  (ara/stage-buffer)
  (magit-run-git "commit" "-m" msg "--" (buffer-file-name))
  (message "committed %s" (buffer-file-name)))

(defun amend-buffer ()
  "Amend the last commit to include the current state of the current buffer (using magit)."
  (interactive)
  (ara/stage-buffer)
  (magit-run-git "commit" "--amend" "--no-edit" "--" (buffer-file-name))
  (message "amended last commit for %s" (buffer-file-name)))

;; quick command to stage the current file
(defun ara/stage-buffer ()
  "Stage the current state of the current buffer (using magit)."
  (interactive)
  (full-auto-save)
  (magit-run-git "add" "--" (buffer-file-name))
  (message "Staged %s" (buffer-file-name)))

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

(defun find-todo ()
  (interactive)
  (find-file am-todo-filename))

(defun find-projects ()
  (interactive)
  (find-file am-project-filename))

(defun find-todo-work ()
  (interactive)
  (find-file am-todo-work-filename))

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
(defun ara/buffer-current-name
    (relative)
  (interactive "P")
  (let* ((absname (buffer-file-name))
         (name (cond (w3m-current-url)
                     (relative
                      (let ((root (projectile-project-root)))
                        (if root
                            (replace-regexp-in-string (concat "^" root) "" absname)
                          absname)))
                     (t absname))))
    (kill-new (message "%s" name))))


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

;; XXX this already exists as swiper-isearch-C-r
(defun ara/swiper-C-r (&optional arg)
  "Move cursor vertically up ARG candidates.
If the input is empty, select the previous history element instead."
  (interactive "p")
  (swiper-C-s (- (or arg 1))))

(defun indent-4 ()
  (interactive)
  (indent-rigidly (region-beginning) (region-end) 4))


(defun mark-parens ()
  (interactive)
  (sp-backward-up-sexp)
  (push-mark (point))
  (activate-mark)
  (sp-forward-sexp)
  (kill-new (filter-buffer-substring (region-beginning) (region-end))))


(defun ara/duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank))

(defun ara/duplicate-region ()
  (interactive)
  (let ((end (region-end)))
    (kill-ring-save nil nil t)
    (goto-char end))
  (let ((kill (current-kill 0)))
    (if (not (string= (substring kill -1) "\n"))
        (insert "\n"))
    (insert kill)))

(defun ara/duplicate-line-or-region ()
  (interactive)
  (if mark-active (ara/duplicate-region) (ara/duplicate-line)))

(defun ara/move-sexp-backward ()
  (interactive)
  (sp-transpose-sexp)
  (sp-backward-sexp 2))

(defun ara/move-sexp-forward ()
  (interactive)
  (sp-forward-sexp 1)
  (sp-transpose-sexp)
  (sp-backward-sexp 1))


(defun ara/lines-after-point (n)
  (save-excursion
    ;(forward-line n)
    (move-beginning-of-line n)
    (point)))

(defun ara/show-packages-maybe-list ()
  "Switch to the buffer `*Packages*' if it exists, otherwise call 'list-packages'."
  (interactive)
  (let ((packages-buffer (get-buffer "*Packages*")))
    (if packages-buffer
        (switch-to-buffer packages-buffer)
      (list-packages))))

;; based on: https://kitchingroup.cheme.cmu.edu/blog/2014/09/06/Randomize-a-list-in-Emacs/
(defun ara/swap (lst i j)
  "In LST swap indices I and J in place."
  (let ((tmp (nth i lst)))
    (setf (nth i lst) (nth j lst))
    (setf (nth j lst) tmp)))

(defun ara/shuffle (lst)
  "Shuffle the elements of LST in place."
  (dolist (i (reverse (number-sequence 1 (1- (length lst)))))
    (let ((j (random i)))
      (ara/swap lst i j))))

(defun ara/randletter ()
  "Return a random lowercase letter"
  (char-to-string (+ (random 26) (string-to-char "a"))))

(defun ara/randstring (len)
  "Return a string of random lowercase letters of length LEN"
  (let* ((a (string-to-char "a"))
         (result (mapcar (lambda (i) (+ a (random 26)))
                         (number-sequence 1 len))))
    (apply 'string result)))

(defun ara/blacken (start end &optional diff)
  "Run black on either the buffer or the region.

Pipe the text between START and END to black, and display the
diff if DIFF is not nil, otherwise replace the text in the
buffer."
  (let* ((curbuff (current-buffer))
         (base-cmd "python3 -m black -S -l 79 -")
         (cmd (concat base-cmd (if diff " --diff" "")))
         (outbuff (if diff "*black --diff*" t))
         (replace (if diff nil t))
         (errbuff "*error buffer*"))
    (save-excursion
      (shell-command-on-region start end cmd outbuff replace errbuff nil)
      (switch-to-buffer outbuff)
      (diff-mode)
      (read-only-mode))
    (switch-to-buffer curbuff)))

(defun ara/blacken-region (diff)
  "Run black on the current region.

Replace the text if DIFF is nil, otherwise show the diff."
  (interactive "P")
  (ara/blacken (region-beginning) (region-end) diff))

(defun ara/blacken-buffer (diff)
  "Run black on the entire buffer.

Replace the text if DIFF is nil, otherwise show the diff."
  (interactive "P")
  (ara/blacken (point-min) (point-max) diff))

(defun ara/grammarly-on-region ()
  (interactive)
  (if mark-active
      (grammarly-check-text (buffer-substring-no-properties (point-min) (point-max)))
    (error "Mark is not active")))

(defun test-on-message (data)
  "On message callback with DATA."
  (message "[DATA] %s" data))
;; (add-to-list 'grammarly-on-message-function-list 'test-on-message)
;; (remove 'test-on-message grammarly-on-message-function-list )

(provide 'functions)
;;; functions.el ends here
