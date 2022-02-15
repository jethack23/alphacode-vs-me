;;; hy==1.0a4

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
  (setv rst []
        mval (min lst))
  (for [k lst]
    (if (= mval k) (continue))
    (rst.append [k mval])
    (if (= (len rst) (// n 2)) (break)))
  rst)

(solve 0)
