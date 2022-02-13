;;; hy==1.0a4

;;; I've submitted this code after 99 minutes contest started. Then it exceeded time limit on test 4. So I've tried to solve little bit differently like C_needed_one_more_minute.hy
;;; But after virtual participation ended, I just test this code with pypy. Then it was accepted... T_T

(import collections [deque])

(defn solution [n map1 map2]
  (setv rank1 (dict (enumerate (sorted (range n) :key (fn [x] (get map1 x)) :reverse True)))
        rank2 (dict (enumerate (sorted (range n) :key (fn [x] (get map2 x)) :reverse True)))
        p2r1 (dfor [r p] (rank1.items) [p r])
        p2r2 (dfor [r p] (rank2.items) [p r])
        b1 (get rank1 0)
        b2 (get rank2 0)
        queue (deque [])
        rst (* [0] n))
  (del (get rank1 (get p2r1 b1)))
  (del (get rank2 (get p2r2 b1)))
  (queue.append b1)
  (when (!= b1 b2)
    (del (get rank1 (get p2r1 b2)))
    (del (get rank2 (get p2r2 b2)))
    (queue.append b2))
  (while queue
    (setv player (queue.popleft)
          (get rst player) 1
          r1 (get p2r1 player)
          r2 (get p2r2 player)
          players-to-remove (set))
    (for [[r p] (rank1.items)]
      (if (> r r1) (break))
      (queue.append p)
      (players-to-remove.add p))
    (for [[r p] (rank2.items)]
      (if (> r r1) (break))
      (queue.append p)
      (players-to-remove.add p))
    (for [p players-to-remove]
      (del (get rank1 (get p2r1 p)))
      (del (get rank2 (get p2r2 p)))))
  rst)

(setv t (int (input)))
(for [_ (range t)]
  (setv n (int (input))
        map1 (list (map int (.split (input))))
        map2 (list (map int (.split (input)))))
  (print (.join "" (map str (solution n map1 map2)))))
