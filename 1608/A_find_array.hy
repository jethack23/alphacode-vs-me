;;; hy==1.0a4

(setv t (int (input)))
(for [_ (range t)]
  (setv n (int (input)))
  (print (.join " " (map str (range 2 (+ n 2))))))
