;;; hy==1.0a4

(defn solution [depots k]
  (setv pos-depots (sorted (list (filter (fn [x] (> x 0)) depots)))
        neg-depots (sorted (list (map (fn [x] (- x)) (filter (fn [x] (< x 0)) depots)))))
  (- (+ (pos-solution pos-depots k)
        (pos-solution neg-depots k))
     (max (if pos-depots (get pos-depots -1) 0)
          (if neg-depots (get neg-depots -1) 0))))

(defn pos-solution [arr k]
  "Assume all element of arr are positive"
  (if arr
      (do (setv traveled 0)
          (for [i (range (- (len arr) 1) -1 (- k))]
            (+= traveled (* 2 (get arr i))))
          traveled)
      0))

(setv t (int (input)))
(for [_ (range t)]
  (setv [n k] (list (map int (.split (input))))
        depots (list (map int (.split (input)))))
  (print (solution depots k)))
