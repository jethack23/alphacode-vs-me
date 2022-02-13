;;; hy==1.0a4

(defn real-input-generator []
  (while True
    (yield (input))))

(defn example-input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

;;; TODO: copy and paste example inputs
(setv examples [""])

(defn solve [test-case-num]
  (setv input-generator (if (< test-case-num 0)
                            (real-input-generator)
                            (do (print "TESTING NOW")
                                (example-input-generator (get examples test-case-num)))))
  ;; TODO: parse inputs
  (for [l input-generator]
    (print l)))

(solve 0)
