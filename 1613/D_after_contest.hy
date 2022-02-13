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


(setv MOD 998244353)

(defn add-and-mod [lst [MOD MOD]]
  (setv rst 0)
  (for [n lst]
    (+= rst n))
  (% rst MOD))

(defn solution [n lst [MOD MOD]]
  (setv mem (* [0] (+ n 3))
        mem-hole-right (* [0] (+ n 3))
        mem-hole-left (* [0] (+ n 3))
        rst 0)
  (for [a lst]
    ;; do mem of full numbers
    (cond [(= a 0) (setv (get mem 0)
                         (add-and-mod [(get mem 0)
                                       (get mem 0)
                                       1]))]
          [True (setv (get mem a)
                      (add-and-mod [(get mem a)
                                    (get mem a)
                                    (get mem (- a 1))]))])
    ;; do mem-hole-right
    (setv (get mem-hole-right a)
          (add-and-mod [(get mem-hole-right a)
                        (get mem-hole-right a)
                        (get mem-hole-left (+ a 2))]))
    ;; do mem-hole-left
    (cond [(= a 0) None]
          [(= a 1) (setv (get mem-hole-left 1)
                         (add-and-mod [(get mem-hole-left 1)
                                       (get mem-hole-left 1)
                                       1]))]
          [True (setv (get mem-hole-left a)
                      (add-and-mod [(get mem-hole-left a)
                                    (get mem-hole-left a)
                                    (get mem-hole-right (- a 2))
                                    (get mem (- a 2))]))]))
  (for [m [mem mem-hole-left mem-hole-right]]
    (+= rst (add-and-mod m)))
  (% rst MOD))

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
