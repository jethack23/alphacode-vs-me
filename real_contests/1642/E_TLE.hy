;;; hy==1.0a4

(defn solve []
  
  (testcase)

  ;; (for [_ (range (int (input)))] (testcase))
  
  )

;;; input helpers
(setv ii (fn [] (int (input)))
      il (fn [] (.split (input)))
      iil (fn [] (list (map int (il)))))

(defn testcase []
  ;; TODO : implement solution
  (setv [n q] (iil)
        result (* ["N/A"] (+ n 1))
        not-settled [])
  (for [i (range q)]
    (setv query (iil))
    (when (= (len query) 4)
      (setv [_ l r d] query
            changed False)
      (if (= d 0)
          (for [i (range l (+ r 1))]
            (setv (get result i) "NO"
                  changed True))
          (do (setv notyet (lfor i (range l (+ r 1)) :if (!= (get result i) "NO") i)
                    l (len notyet))
              (cond [(= l 1) (setv (get result (notyet.pop)) "YES")]
                    [(> l 1) (not-settled.append notyet)])))
      (when changed
        (setv new-lst [])
        (for [q not-settled]
          (setv q (lfor j q :if (!= (get result j) "NO") j)
                l (len q))
          (cond [(> l 1)
                 (new-lst.append q)]
                [(= l 1)
                 (setv (get result (q.pop)) "YES")]))
        (setv not-settled new-lst)))
    (if (= (len query) 2)
        (print (get result (get query 1))))))




;;; TEST REGION : WON"T BE TRANSCOMPILED

;;; TODO: copy and paste example inputs
(setv examples ["6 9
0 4 5 0
1 5
1 6
0 4 6 1
1 6
0 2 5 1
0 2 2 0
1 3
1 2"])

(defn input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(for [[i e] (enumerate examples)]
  (setv ig (input-generator e)
        input (fn [] (next ig)))
  (print "Testing example case:" (+ i 1))
  (solve))
