;;; hy==1.0a4

(defn example-input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(defn real-input-generator []
  (while True
    (yield (input))))

(defn solve [[test-case-num -1]]
  (setv ig (if (< test-case-num 0)
               (real-input-generator)
               (do (print "TESTING NOW")
                   (example-input-generator (get examples test-case-num)))))
  ;; TODO: parse inputs
  (setv t (int (next ig)))
  (for [_ (range t)]
    (setv n (int (next ig))
          lst (list (map int (.split (next ig)))))
    (print (solution n lst))))


(setv mod 998244353)

(defn solution [n lst [mod mod]]
  (setv mem1 (* [0] (+ n 3))
        mem2 (* [0] (+ n 3))
        rst 0)
  (for [a lst]
    ;; do mem1 of full numbers
    (<<= (get mem1 a) 1)
    (if (= a 0)
        (+= (get mem1 0) 1)
        (+= (get mem1 a) (get mem1 (- a 1))))
    (%= (get mem1 a) mod)
    ;; do mem2
    (<<= (get mem2 a) 1)
    (if (= a 1)
        (+= (get mem2 1) 1))
    (if (> a 1)
        (+= (get mem2 a) (get mem1 (- a 2))))
    (%= (get mem2 a) mod)
    (<<= (get mem2 (+ a 2)) 1)
    (%= (get mem2 (+ a 2)) mod))
  (for [m [mem1 mem2]]
    (+= rst (sum m))
    (%= rst mod))
  rst)

;;; TODO: copy and paste example inputs
(setv examples ["4
3
0 2 1
2
1 0
5
0 0 0 0 0
4
0 1 2 3"
                "5
7
1 3 2 3 0 0 1
6
0 3 2 2 1 3
4
0 2 1 0
9
0 1 0 1 1 3 0 3 1
14
1 3 3 0 2 0 1 3 3 3 1 1 3 3"])

(solve 0)
