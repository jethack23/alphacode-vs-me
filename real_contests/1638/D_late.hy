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
  (setv [n m] (iil))
  (setv grid (lfor _ (range n) (iil))
        rst (solution n m grid))
  (if rst
      (do (print (len rst))
          (for [[i j c] (reversed rst)]
            (print (+ i 1) (+ j 1) c)))
      (print -1)))

(defn color-case [i j grid]
  (setv c 0)
  (for [x (range i (+ i 2))]
      (for [y (range j (+ j 2))]
        (setv this-c (get (get grid x) y))
        (cond [(= this-c 0) (continue)]
              [(= c 0) (setv c this-c)]
              [(!= c this-c) (return -1)])))
  c)

(defn solution [n m grid]
  (setv rst []
        q [])
  
  (for [i (range (- n 1))]
    (for [j (range (- m 1))]
      (setv c (color-case i j grid))
      (if (<= c 0) (continue))
      (setv q [[i j]])
      (while q
        (setv [i j] (q.pop)
              c (color-case i j grid))
        (if (<= c 0) (continue))
        (rst.append [i j c])
        (for [x (range i (+ i 2))]
          (for [y (range j (+ j 2))]
            (setv (get (get grid x) y) 0)))
        (for [x (range (- i 1) (+ i 2))]
          (if (not (<= 0 x (- n 2))) (continue))
          (for [y (range (- j 1) (+ j 2))]
            (if (not (<= 0 y (- m 2))) (continue))
            (setv c (color-case x y grid))
            (when (> c 0)
              (q.append [x y])))))))
  (for [i (range n)]
    (for [j (range m)]
      (if (get (get grid i) j)
          (return []))))
  rst)

;;; TEST REGION : WON"T BE TRANSCOMPILED

(setv examples
;;; TODO: copy and paste example inputs
      ["4 4
5 5 3 3
1 1 5 3
2 2 5 4
2 2 4 4"
       "3 4
1 1 1 1
2 2 3 1
2 2 1 1"])

(defn input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))
(for [[i e] (enumerate examples)]
  (setv ig (input-generator e)
        input (fn [] (next ig)))
  (print "Testing example case:" (+ i 1))
  (solve))

