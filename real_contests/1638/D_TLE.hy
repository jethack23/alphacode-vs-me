;;; hy==1.0a4

(defn solve [[test-case-num -1]]
  (if (< test-case-num 0)
      (do (import os
                  sys
                  io [BytesIO IOBase])

          (setv BUFSIZE 8192)

          (defclass FastIO [IOBase]
            (setv newlines 0)
            (defn __init__ [self file]
              (setv self._file file
                    self._fd (file.fileno)
                    self.buffer (BytesIO)
                    self.writable (or (in "x" file.mode)
                                      (not (in "r" file.mode)))
                    self.write (if self.writable
                                   self.buffer.write
                                   None))
              None)

            (defn read [self]
              (while True
                (setv b (os.read self._fd (max (. (os.fstat self._fc) st_size) BUFSIZE)))
                (if (not b) (break))
                (setv ptr (self.buffer.tell))
                (self.buffer.seek 0 2)
                (self.buffer.write b)
                (self.buffer.seek ptr))
              (setv self.newlines 0)
              (self.buffer.read))

            (defn readline [self]
              (while (= self.newlines 0)
                (setv b (os.read self._fd (max (. (os.fstat self._fd) st_size) BUFSIZE))
                      self.newlines (+ (b.count b"\n") (not b))
                      ptr (self.buffer.tell))
                (self.buffer.seek 0 2)
                (self.buffer.write b)
                (self.buffer.seek ptr))
              (-= self.newlines 1)
              (self.buffer.readline))

            (defn flush [self]
              (when self.writable
                (os.write self._fd (self.buffer.getvalue))
                (self.buffer.truncate 0)
                (self.buffer.seek 0))))

          (defclass IOWrapper [IOBase]
            (defn __init__ [self file]
              (setv self.buffer (FastIO file)
                    self.flush self.buffer.flush
                    self.writable self.buffer.writable
                    self.write (fn [s] (self.buffer.write (s.encode "ascii")))
                    self.read (fn [] (.decode (self.buffer.read) "ascii"))
                    self.readline (fn [] (.decode (self.buffer.readline) "ascii")))
              None))

          (setv sys.stdin (IOWrapper sys.stdin)
                sys.stdout (IOWrapper sys.stdout)
                input (fn [] (.rstrip (sys.stdin.readline) "\r\n"))))
      (do
        (print "TESTING NOW : this-is-for-preventing-pass-first-example")
        (defn input-generator [example]
          (for [line (.split example "\n")]
            (yield line)))
        (setv ig (input-generator (get examples test-case-num))
              input (fn [] (next ig)))))
  ;; TODO: parse inputs
  ;; (int (input))
  ;; (list (map int (.split (input))))
  (setv [n m] (list (map int (.split (input)))))
  (setv grid (lfor _ (range n) (list (map int (.split (input))))))
  (solution n m grid))

(import collections [deque])

(defn solution [n m grid]
  (setv rst []
        q (deque)
        visited (set)
        colored 0)
  ;; starting points
  (for [i (range (- n 1))]
    (for [j (range (- m 1))]
      (setv [cs ncell] (color-info i j grid))
      (when (= (len cs) 1)
        (q.append [i j (next (iter cs))])
        (visited.add (, i j)))))
  ;; bfs
  (while q
    (setv [x y c] (q.popleft)
          removed (paint x y grid 0))
    (when removed
      (rst.append [x y c])
      (+= colored removed)
      (if (= colored (* m n)) (break))
      (for [i (range (max 0 (- x 1)) (min (- n 1) (+ x 2)))]
        (for [j (range (max 0 (- y 1)) (min (- m 1) (+ y 2)))]
          (if (or (and (= x i) (= y j)) (in (, i j) visited)) (continue))
          (setv [cs ncell] (color-info i j grid))
          (if (= ncell 0) (visited.add (, i j)))
          (when (= (len cs) 1)
            (q.append [i j (next (iter cs))])
            (visited.add (, i j)))))))
  (if (= colored (* n m))
      (do (print (len rst))
          (while rst
            (setv [i j c] (rst.pop))
            (print (+ i 1) (+ j 1) c)))
      (print -1)))

(defn paint [x y grid color]
  (setv rst 0)
  (for [i (range x (+ x 2))]
    (for [j (range y (+ y 2))]
      (when (!= (get (get grid i) j) color)
        (setv (get (get grid i) j) color)
        (+= rst 1))))
  rst)

(defn color-of [i j grid]
  (get (get grid i) j))

(defn color-info [i j grid]
  (setv cset (set)
        num 0)
  (for [x (range i (+ i 2))]
    (for [y (range j (+ j 2))]
      (setv this-color (color-of x y grid))
      (when this-color
        (cset.add this-color)
        (+= num 1))))
  [cset num])

;;; TODO: copy and paste example inputs
(setv examples ["4 4
5 5 3 3
1 1 5 3
2 2 5 4
2 2 4 4"
                "3 4
1 1 1 1
2 2 3 1
2 2 1 1"])

(solve 0)
