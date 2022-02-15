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

  (setv [n q] (list (map int (.split (input))))
        colors (* [1] n)
        values (* [0] n)
        color-to-elements (* [(set)] (+ n 1))
        (get color-to-elements 1) (set (range n))
        fns (dict))
  
  (defn addf [c x]
    (for [a (get color-to-elements c)]
      (+= (get values a) x)))
  (defn colorf [l r c]
    (for [i (range (- l 1) r)]
      (setv pre-col (get colors i))
      (.remove (get color-to-elements pre-col) i)
      (.add (get color-to-elements c) i)
      (setv (get colors i) c)))
  (defn queryf [i]
    (print (get values (- i 1))))
  
  (setv (get fns "Add") addf
        (get fns "Query") queryf
        (get fns "Color") colorf)
  (for [_ (range q)]
    (setv query (.split (input)))
    (setv qt (get query 0)
          args (list (map int (get query (slice 1 None)))))
    ((get fns qt) #* args)))

;;; TODO: copy and paste example inputs
(setv examples ["5 8
Color 2 4 2
Add 2 2
Query 3
Color 4 5 3
Color 2 2 3
Add 3 3
Query 2
Query 5"
                "2 7
Add 1 7
Query 1
Add 2 4
Query 2
Color 1 1 1
Add 1 1
Query 2"])

(solve 0)
