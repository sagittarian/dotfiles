(pyvenv-workon "geniedev")

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

(provide 'colabo)
;;; colabo.el ends here
