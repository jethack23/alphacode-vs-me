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
  (setv [n x] (iil)
        lst (iil))
  (print (solution n x lst))
  )

(import collections [defaultdict])

(defn solution [n x lst]
  (setv cnt (defaultdict int)
        rst 0)
  (for [i (sorted lst)]
    (+= (get cnt i) 1))
  (for [[i c] (cnt.items)]
    (setv multiply (* i x))
    (when (and (in multiply cnt) c (get cnt multiply))
      (setv minc (min (get cnt multiply) c))
      (-= (get cnt multiply) minc)
      (-= (get cnt i) minc)))
  (for [[i c] (cnt.items)]
    (+= rst c))
  rst)



;;; TEST REGION : WON"T BE TRANSCOMPILED

;;; TODO: copy and paste example inputs
(setv examples ["4
4 4
1 16 4 4
6 2
1 2 2 2 4 7
5 3
5 2 3 5 15
9 10
10 10 10 20 1 100 200 2000 3"])

(defn input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(for [[i e] (enumerate examples)]
  (setv ig (input-generator e)
        input (fn [] (next ig)))
  (print "Testing example case:" (+ i 1))
  (solve))
