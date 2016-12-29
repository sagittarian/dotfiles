(defun amesha-strip-formatting (txt)
  (set-text-properties 0 (length txt) nil txt)
  txt)

(defun amesha-org-to-root ()
  (interactive)
  (catch 'found-root
    (condition-case nil
        (org-up-element)
      (error
       (throw 'found-root nil)))
    (amesha-org-to-root)))

(defun amesha-org-next-level ()
  (interactive)
  (save-excursion
    (org-goto-first-child)
    (let ((priority-list ())
          (priority)
          (cur-line))
      (while (progn
               (setq cur-line (thing-at-point 'line))
               (save-match-data
                 (if (string-match "@@\\([0-9]+\\)" cur-line)
                     (setq priority (string-to-number
                                     (match-string 1 cur-line)))
                   (setq priority 0)))
               (setq priority-list
                     (cons priority priority-list))
               (org-goto-sibling)))
      (reverse priority-list))))
