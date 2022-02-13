;;; hy==1.0a4

(defn real-input-generator []
  (while True
    (yield (input))))

(defn example-input-generator [example]
  (for [line (.split example "\n")]
    (yield line)))

(setv examples ["5
2 1
19 0
10 2
100 1
1999 0
2 3
1 0
1 0
99 0
1 2"
                "1
2 100
1 10"])

(defn solve [test-case-num]
  (setv ig (if (< test-case-num 0)
               (real-input-generator)
               (do (print "TESTING NOW")
                   (example-input-generator (get examples test-case-num)))))
  (setv t (int (next ig)))
  (for [_ (range t)]
    (setv [x p] (list (map int (.split (next ig))))
          [y q] (list (map int (.split (next ig)))))
    (print (solution x p y q))))

(defn solution [x p y q]
  (setv expdiff (- p q))
  (cond [(> expdiff 6) (return ">")]
        [(< expdiff -6) (return "<")])
  (setv me (min p q)
        a (* x (** 10 (- p me)))
        b (* y (** 10 (- q me))))
  (cond [(> a b) ">"]
        [(< a b) "<"]
        [True "="]))

(solve -1)
