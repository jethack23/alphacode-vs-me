;;; hy==1.0a4

(import collections [deque])

(defn solution [n a b]
  (setv limit (// (- n 1) 2))
  (if (or (> a limit)
          (> b limit)
          (> (+ a b) (- (* 2 limit) (% n 2)))
          (> (abs (- a b)) 1))
      (return [-1]))
  (setv rst [1]
        nums (deque (range 2 (+ n 1)))
        M (max a b)
        m (min a b))
  (for [_ (range m)]
    (rst.append (nums.pop))
    (rst.append (nums.popleft)))
  (if (> M m)
      (while nums (rst.append (nums.pop)))
      (while nums (rst.append (nums.popleft))))
  (if (>= a b)
      rst
      (lfor i rst (- (+ n 1) i))))

(setv t (int (input)))
(for [_ (range t)]
  (setv [n a b] (list (map int (.split (input)))))
  (print (.join " " (map str (solution n a b)))))
