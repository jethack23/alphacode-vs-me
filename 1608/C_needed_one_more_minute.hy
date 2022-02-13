;;; hy==1.0a4

;;; This solution accepted with both of python3 and pypy3. But I made a mistake of writing "when" where "while" should be placed. When I figured out and fix this problem, it was 30 seconds after contest finished...

(import collections [deque])

(defn solution [n map1 map2]
  (setv rank1 (sorted (range n) :key (fn [x] (get map1 x)))
        rank2 (sorted (range n) :key (fn [x] (get map2 x)))
        map1-popped #{}
        map2-popped #{}
        b1 (rank1.pop)
        b2 (rank2.pop)
        queue (deque [[b1 1] [b2 2]])
        rst (* [0] n))
  (map1-popped.add b1)
  (map2-popped.add b2)
  (setv (get rst b1) 1)
  (setv (get rst b2) 1)
  (while queue
    (setv [p from] (queue.popleft))
    (if (= from 1)
        (do (while (not (in p map2-popped))
              (setv better2 (rank2.pop))
              (map2-popped.add better2)
              (if (= better2 p) (break))
              (queue.append [better2 2])
              (setv (get rst better2) 1)))
        (do (while (not (in p map1-popped))
              (setv better1 (rank1.pop))
              (map1-popped.add better1)
              (if (= better1 p) (break))
              (queue.append [better1 1])
              (setv (get rst better1) 1)))))
  rst)

(setv t (int (input)))
(for [_ (range t)]
  (setv n (int (input))
        map1 (list (map int (.split (input))))
        map2 (list (map int (.split (input)))))
  (print (.join "" (map str (solution n map1 map2)))))
