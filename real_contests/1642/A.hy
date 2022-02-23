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
  (setv p1 (iil)
        p2 (iil)
        p3 (iil))
  (print (float (solution p1 p2 p3))))

(defn solution [p1 p2 p3]
  (setv [x1 y1] p1
        [x2 y2] p2
        [x3 y3] p3
        miny (min [y1 y2 y3])
        pts [])
  (for [p [p1 p2 p3]]
    (if (!= (get p 1) miny)
        (pts.append p)))
  (if (> (len pts) 1)
      (do (setv [[x1 y1] [x2 y2]] pts)
          (if (= y1 y2)
              (abs (- x1 x2))
              0))
      0))


;;; TEST REGION : WON"T BE TRANSCOMPILED

;;; TODO: copy and paste example inputs
(setv examples ["5
8 10
10 4
6 2
4 6
0 1
4 2
14 1
11 2
13 2
0 0
4 0
2 4
0 1
1 1
0 0"])

(defn input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(for [[i e] (enumerate examples)]
  (setv ig (input-generator e)
        input (fn [] (next ig)))
  (print "Testing example case:" (+ i 1))
  (solve))
