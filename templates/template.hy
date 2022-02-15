;;; hy==1.0a4

(defn solve []
  
  ;; (testcase)

  ;; (for [_ (range (int (input)))] (testcase))
  
  )

;;; input helpers
(setv ii (fn [] (int (input)))
      il (fn [] (.split (input)))
      iil (fn [] (list (map int (il)))))

(defn testcase []
  ;; TODO : implement solution
  )



;;; TEST REGION : WON"T BE TRANSCOMPILED

;;; TODO: copy and paste example inputs
(setv examples [""])

(defn input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(for [[i e] (enumerate examples)]
  (setv ig (input-generator e)
        input (fn [] (next ig)))
  (print "Testing example case:" (+ i 1))
  (solve))
