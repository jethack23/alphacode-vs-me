;;; hy==1.0a4

;;; I've spent 50 minutes on problem D, after skip this problem. Again, I made some mistakes on this problem. After I applied ad-hoc solution of sorting, It was a minute passed from virtual participation finished...
;;; Intended solution is B_after_contest.hy

(defn real-input-generator []
  (while True
    (yield (input))))

(defn example-input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

;;; TODO: copy and paste example inputs
(setv examples ["4
2
1 4
4
2 8 3 4
5
3 8 5 9 7
6
2 7 5 3 4 8"])

(defn solve [[test-case-num -1]]
  (setv ig (if (< test-case-num 0)
               (real-input-generator)
               (do (print "TESTING NOW")
                   (example-input-generator (get examples test-case-num)))))
  ;; TODO: parse inputs
  (setv t (int (next ig)))
  (for [idx (range t)]
    (setv n (int (next ig))
          lst (list (map int (.split (next ig)))))
    (for [pair (solution n lst)]
      (print (.join " " (map str pair))))))

(defn solution [n lst]
  (lst.sort :reverse True)
  (setv rst []
        mval (lst.pop))
  (for [i (range 1 (+ (// n 2) 1))]
    (rst.append [(get lst (- i 1)) mval]))
  rst)

(solve 0)
