;;; hy==1.0a4

(defn solution [lst]
  (setv watered-yesterday None
        height 1)
  (for [watered lst]
    (if watered
        (if watered-yesterday
            (+= height 5)
            (+= height 1))
        (if (and (not (is watered-yesterday None)) (not watered-yesterday))
            (return -1)))
    (setv watered-yesterday watered))
  height)

(setv t (int (input)))
(for [_ (range t)]
  (setv n (int (input))
        lst (list (map int (.split (input)))))
  (print (solution lst)))
