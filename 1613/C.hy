;;; hy==1.0a4

(defn real-input-generator []
  (while True
    (yield (input))))

(defn example-input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

;;; TODO: copy and paste example inputs
(setv examples ["4
2 5
1 5
3 10
2 4 10
5 3
1 2 4 5 7
4 1000
3 25 64 1337"])

(defn solve [[test-case-num -1]]
  (setv ig (if (< test-case-num 0)
               (real-input-generator)
               (do (print "TESTING NOW")
                   (example-input-generator (get examples test-case-num)))))
  ;; TODO: parse inputs
  (setv t (int (next ig)))
  (for [_ (range t)]
    (setv [n h] (list (map int (.split (next ig))))
          lst (list (map int (.split (next ig)))))
    (print (solution n h lst))))

(defn solution [n h lst]
  (if (>= n h) (return 1))
  (for [i (range (- n 1))]
    (setv (get lst i) (- (get lst (+ i 1)) (get lst i))))
  (setv (get lst (- n 1)) h)
  (lst.sort)
  (for [[i v] (enumerate lst)]
    (if (>= (* v (- n i)) h)
        (return (+ (// (- h 1) (- n i)) 1)))
    (-= h v))
  (+ (get lst -1) h))

(solve 0)
