;;; hy==1.0a4

(defn solve []
  
  ;; (testcase)

  (for [_ (range (int (input)))] (testcase))
  
  )

;;; input helpers
(setv ii (fn [] (int (input)))
      il (fn [] (.split (input)))
      iil (fn [] (list (map int (il)))))

(defn testcase []
  ;; TODO : implement solution
  (setv n (ii)
        lst (iil))
  
  (print (.join " " (map str (solution n lst))))
  )

(defn solution [n lst]
  (setv
    total (len (set lst)))
  (+ (* [total] total) (list (range (+ total 1) (+ n 1)))))



;;; TEST REGION : WON"T BE TRANSCOMPILED

;;; TODO: copy and paste example inputs
(setv examples ["3
3
1 1 2
6
5 1 2 2 2 4
5
1 1 2 2 3"])

(defn input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(for [[i e] (enumerate examples)]
  (setv ig (input-generator e)
        input (fn [] (next ig)))
  (print "Testing example case:" (+ i 1))
  (solve))
