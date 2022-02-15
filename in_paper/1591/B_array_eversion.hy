;;; hy==1.0a4

(defn solution [arr]
  (setv max-elt 0
        steps -1)
  (for [x (reversed arr)]
    (when (> x max-elt)
      (+= steps 1)
      (setv max-elt x)))
  steps)

(setv t (int (input)))
(for [_ (range t)]
  (setv n (int (input))
        arr (list (map int (.split (input)))))
  (print (solution arr)))
