;;; hy==1.0a4

(defn real-input-generator []
  (while True
    (yield (input))))

(defn example-input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(defn solve [[test-case-num -1]]
  (setv ig (if (< test-case-num 0)
               (real-input-generator)
               (do (print "TESTING NOW")
                   (example-input-generator (get examples test-case-num)))))
  ;; TODO: parse inputs
  ;; (list (map int (.split (next ig))))
  (for [l ig]
    (print l)))

;;; TODO: copy and paste example inputs
(setv examples [""])

(solve 0)
